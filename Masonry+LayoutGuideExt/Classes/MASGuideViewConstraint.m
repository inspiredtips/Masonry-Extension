//
//  MASGuideViewConstraint.m
//  Masonry_LayoutGuideExt
//
//  Created by 李宁 on 2020/12/29.
//

#import "MASGuideViewConstraint.h"
#import <objc/runtime.h>
#import <Masonry/MASConstraint+Private.h>
#import "MASGuideViewConstraint+Private.h"


@interface UILayoutGuide (MASConstraints)

@property (nonatomic, readonly) NSMutableSet *mas_installedConstraints;

@end

@implementation UILayoutGuide (MASConstraints)

static char kInstalledConstraintsKey;

- (NSMutableSet *)mas_installedConstraints {
    NSMutableSet *constraints = objc_getAssociatedObject(self, &kInstalledConstraintsKey);
    if (!constraints) {
        constraints = [NSMutableSet set];
        objc_setAssociatedObject(self, &kInstalledConstraintsKey, constraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return constraints;
}

@end

@interface MASGuideViewConstraint ()

@property (nonatomic, weak) UILayoutGuide *installedLayoutGuide;

@end

@implementation MASGuideViewConstraint

- (void)install {
    if (self.hasBeenInstalled) {
        return;
    }
    
    if ([self.firstViewAttribute.item isKindOfClass:[MAS_VIEW class]]) {
        [super install];
        return;
    }
    
    if (![self.firstViewAttribute.item isKindOfClass:[UILayoutGuide class]]) {
        NSCAssert(NO, @"不支持 除 View 和 UILayoutGuide 外其他类型对象布局");
        return;
    }
    
    UILayoutGuide *firstLayoutItem = self.firstViewAttribute.item;
    
    
    if ([self supportsActiveProperty] && self.layoutConstraint) {
        self.layoutConstraint.active = YES;
        [firstLayoutItem.mas_installedConstraints addObject:self];
        return;
    }
    
    
    NSLayoutAttribute firstLayoutAttribute = self.firstViewAttribute.layoutAttribute;
    id secondLayoutItem = self.secondViewAttribute.item;
    NSLayoutAttribute secondLayoutAttribute = self.secondViewAttribute.layoutAttribute;

    // alignment attributes must have a secondViewAttribute
    // therefore we assume that is refering to superview
    // eg make.left.equalTo(@10)
    if (!self.firstViewAttribute.isSizeAttribute && !self.secondViewAttribute) {
        secondLayoutItem = firstLayoutItem.owningView;
        NSCAssert(secondLayoutItem, @"UILayoutGuide  %@ should be added to view before add masonry", firstLayoutItem);
        secondLayoutAttribute = firstLayoutAttribute;
    }
    
    MASLayoutConstraint *layoutConstraint
        = [MASLayoutConstraint constraintWithItem:firstLayoutItem
                                        attribute:firstLayoutAttribute
                                        relatedBy:self.layoutRelation
                                           toItem:secondLayoutItem
                                        attribute:secondLayoutAttribute
                                       multiplier:self.layoutMultiplier
                                         constant:self.layoutConstant];
    
    layoutConstraint.priority = self.layoutPriority;
    layoutConstraint.mas_key = self.mas_key;
    
    if (self.secondViewAttribute.view) {
        MAS_VIEW *closestCommonSuperview = [firstLayoutItem.owningView mas_closestCommonSuperview:self.secondViewAttribute.view];
        NSAssert(closestCommonSuperview,
                 @"couldn't find a common superview for %@ and %@",
                 self.firstViewAttribute.view, self.secondViewAttribute.view);
        self.installedView = closestCommonSuperview;
    } else if (self.firstViewAttribute.isSizeAttribute) {
        self.installedView = self.firstViewAttribute.view;
        self.installedLayoutGuide = firstLayoutItem;
    } else {
        self.installedView = self.firstViewAttribute.view.superview;
    }


    MASLayoutConstraint *existingConstraint = nil;
    if (self.updateExisting) {
        existingConstraint = [self layoutConstraintSimilarTo:layoutConstraint];
    }
    if (existingConstraint) {
        // just update the constant
        existingConstraint.constant = layoutConstraint.constant;
        self.layoutConstraint = existingConstraint;
    } else {
        [self.installedView addConstraint:layoutConstraint];
        self.layoutConstraint = layoutConstraint;
        [firstLayoutItem.mas_installedConstraints addObject:self];
    }
}

- (MASLayoutConstraint *)layoutConstraintSimilarTo:(MASLayoutConstraint *)layoutConstraint {
    // check if any constraints are the same apart from the only mutable property constant

    // go through constraints in reverse as we do not want to match auto-resizing or interface builder constraints
    // and they are likely to be added first.
    for (NSLayoutConstraint *existingConstraint in self.installedView.constraints.reverseObjectEnumerator) {
        if (![existingConstraint isKindOfClass:MASLayoutConstraint.class]) continue;
        if (existingConstraint.firstItem != layoutConstraint.firstItem) continue;
        if (existingConstraint.secondItem != layoutConstraint.secondItem) continue;
        if (existingConstraint.firstAttribute != layoutConstraint.firstAttribute) continue;
        if (existingConstraint.secondAttribute != layoutConstraint.secondAttribute) continue;
        if (existingConstraint.relation != layoutConstraint.relation) continue;
        if (existingConstraint.multiplier != layoutConstraint.multiplier) continue;
        if (existingConstraint.priority != layoutConstraint.priority) continue;

        return (id)existingConstraint;
    }
    return nil;
}

- (void)uninstall {
    if ([self.firstViewAttribute.item isKindOfClass:[MAS_VIEW class]]) {
        [super uninstall];
        return;
    }
    if (![self.firstViewAttribute.item isKindOfClass:[UILayoutGuide class]]) {
        NSCAssert(NO, @"不支持 除 View 和 UILayoutGuide 外其他类型对象布局");
        return;
    }
    
    UILayoutGuide *layoutGuide = self.firstViewAttribute.item;
    
    if ([self supportsActiveProperty]) {
        [NSLayoutConstraint deactivateConstraints:[NSArray arrayWithObjects:self.layoutConstraint, nil]];
        [layoutGuide.mas_installedConstraints removeObject:self];
        return;
    }
    
    
    self.layoutConstraint = nil;
    self.installedView = nil;
    
    [layoutGuide.mas_installedConstraints removeObject:self];
}

+ (NSArray *)installedConstraintsForLayoutGuide:(UILayoutGuide *)layoutGuide {
    return layoutGuide.mas_installedConstraints.allObjects;
}



@end
