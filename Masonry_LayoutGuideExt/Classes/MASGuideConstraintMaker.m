//
//  MASGuideConstraintMaker.m
//  Masonry LayoutGuide Extension
//
//  Created by Hiuson on 2020/8/31.
//  Copyright © 2020 Hiuson. All rights reserved.
//

#import "MASGuideConstraintMaker.h"
#import "UILayoutGuide+MASAdditions.h"
#import "MASConstraint+Private.h"
#import <objc/runtime.h>

@interface NSObject (Guide_private)

@property (nonatomic, readonly) NSMutableSet *mas_installedConstraints;

@end

@implementation NSObject (Guide_private)

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

@interface MASGuideConstraintMaker ()

@property (nonatomic, strong) UILayoutGuide *item;

@end

@implementation MASGuideConstraintMaker

- (id)initWithView:(UIView *)view item:(UILayoutGuide *)item {
    self = [super initWithView:view];
    if (self) {
        _item = item;
    }
    return self;
}

- (id<MASConstraintDelegate>)delegateInstance {
    if ([self conformsToProtocol:@protocol(MASConstraintDelegate)]) {
        return (id<MASConstraintDelegate>)self;
    }
    NSAssert(NO, @"Unreachable");
    return nil;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [self.item.mas_installedConstraints allObjects];
        for (MASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    
    
    id mutableconstraints = [self performSelector:@selector(constraints)];
    NSArray *constraints = nil;
    if ([mutableconstraints isKindOfClass:[NSMutableArray class]]) {
        constraints = [(NSMutableArray *)mutableconstraints copy];
        for (MASConstraint *constraint in constraints) {
            
            void (^checkSecondViewAttribute)(id c) = ^(id c){
                if ([c isKindOfClass:[MASViewConstraint class]]) {
                    MASViewConstraint *MASc = c;
                    if ([MASc.firstViewAttribute.item isKindOfClass:[UILayoutGuide class]] && !MASc.secondViewAttribute) {
                        UIView *owningView = [(UILayoutGuide *)MASc.firstViewAttribute.item owningView];
                        
                        MASViewAttribute *attribute = [[MASViewAttribute alloc] initWithView:owningView layoutAttribute:MASc.firstViewAttribute.layoutAttribute];
                        [MASc setValue:attribute forKey:@"secondViewAttribute"];
                    }
                }
            };
            
            if ([constraint isKindOfClass:[MASCompositeConstraint class]]) {
                MASCompositeConstraint *c = (MASCompositeConstraint *)constraint;
                NSArray  *childConstraints = [c valueForKey:@"childConstraints"];
                for (id c in childConstraints) {
                    checkSecondViewAttribute(c);
                }
            } else if ([constraint isKindOfClass:[MASViewConstraint class]]) {
                checkSecondViewAttribute(constraint);
            }
            
            constraint.updateExisting = self.updateExisting;
            [constraint install];
        }
        [mutableconstraints removeAllObjects];
    }
    return constraints;
}

- (MASConstraint *)constraint:(MASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    id view = [self performSelector:@selector(view)];
    
    if (![view isKindOfClass:[UIView class]]) {
        return nil;
    }
    MASViewAttribute *viewAttribute = [[MASViewAttribute alloc] initWithView:view item:self.item layoutAttribute:layoutAttribute];
    MASViewConstraint *newConstraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:MASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        MASCompositeConstraint *compositeConstraint = [[MASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self.delegateInstance;
        [self.delegateInstance constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self.delegateInstance;
        id constraints = [self performSelector:@selector(constraints)];
        if ([constraints isKindOfClass:[NSMutableArray class]]) {
            [constraints addObject:newConstraint];
        }
    }
    return newConstraint;
}

- (MASConstraint *)addConstraintWithAttributes:(MASAttribute)attrs {
    __unused MASAttribute anyAttribute = (MASAttributeLeft | MASAttributeRight | MASAttributeTop | MASAttributeBottom | MASAttributeLeading
                                          | MASAttributeTrailing | MASAttributeWidth | MASAttributeHeight | MASAttributeCenterX
                                          | MASAttributeCenterY | MASAttributeBaseline
                                          | MASAttributeFirstBaseline | MASAttributeLastBaseline
                                          | MASAttributeLeftMargin | MASAttributeRightMargin | MASAttributeTopMargin | MASAttributeBottomMargin
                                          | MASAttributeLeadingMargin | MASAttributeTrailingMargin | MASAttributeCenterXWithinMargins
                                          | MASAttributeCenterYWithinMargins
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & MASAttributeLeft) [attributes addObject:self.item.mas_left];
    if (attrs & MASAttributeRight) [attributes addObject:self.item.mas_right];
    if (attrs & MASAttributeTop) [attributes addObject:self.item.mas_top];
    if (attrs & MASAttributeBottom) [attributes addObject:self.item.mas_bottom];
    if (attrs & MASAttributeLeading) [attributes addObject:self.item.mas_leading];
    if (attrs & MASAttributeTrailing) [attributes addObject:self.item.mas_trailing];
    if (attrs & MASAttributeWidth) [attributes addObject:self.item.mas_width];
    if (attrs & MASAttributeHeight) [attributes addObject:self.item.mas_height];
    if (attrs & MASAttributeCenterX) [attributes addObject:self.item.mas_centerX];
    if (attrs & MASAttributeCenterY) [attributes addObject:self.item.mas_centerY];
    if (attrs & MASAttributeBaseline) [attributes addObject:self.item.mas_baseline];
    if (attrs & MASAttributeFirstBaseline) [attributes addObject:self.item.mas_firstBaseline];
    if (attrs & MASAttributeLastBaseline) [attributes addObject:self.item.mas_lastBaseline];
    if (attrs & MASAttributeLeftMargin) [attributes addObject:self.item.mas_leftMargin];
    if (attrs & MASAttributeRightMargin) [attributes addObject:self.item.mas_rightMargin];
    if (attrs & MASAttributeTopMargin) [attributes addObject:self.item.mas_topMargin];
    if (attrs & MASAttributeBottomMargin) [attributes addObject:self.item.mas_bottomMargin];
    if (attrs & MASAttributeLeadingMargin) [attributes addObject:self.item.mas_leadingMargin];
    if (attrs & MASAttributeTrailingMargin) [attributes addObject:self.item.mas_trailingMargin];
    if (attrs & MASAttributeCenterXWithinMargins) [attributes addObject:self.item.mas_centerXWithinMargins];
    if (attrs & MASAttributeCenterYWithinMargins) [attributes addObject:self.item.mas_centerYWithinMargins];
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (MASViewAttribute *a in attributes) {
        [children addObject:[[MASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    MASCompositeConstraint *constraint = [[MASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self.delegateInstance;
    id constraints = [self performSelector:@selector(constraints)];
    if ([constraints isKindOfClass:[NSMutableArray class]]) {
    [constraints addObject:constraint];
    }
    return constraint;
}

@end
