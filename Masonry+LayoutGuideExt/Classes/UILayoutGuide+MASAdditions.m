//
//  UILayoutGuide+MASAdditions.m
//  Masonry LayoutGuide Extension
//
//  Created by Hiuson on 2020/8/31.
//  Copyright © 2020 Hiuson. All rights reserved.
//

#import "UILayoutGuide+MASAdditions.h"
#import <objc/runtime.h>

@implementation UILayoutGuide (MASAdditions)

- (NSArray *)mas_makeConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker * make))block {
    MASLayoutGuideConstraintMaker *constraintMaker = [[MASLayoutGuideConstraintMaker alloc] initWithLayoutGuide:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker * make))block {
    MASLayoutGuideConstraintMaker *constraintMaker = [[MASLayoutGuideConstraintMaker alloc] initWithLayoutGuide:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker * make))block {
    MASLayoutGuideConstraintMaker *constraintMaker = [[MASLayoutGuideConstraintMaker alloc] initWithLayoutGuide:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (MASViewAttribute *)mas_leading {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeLeading];
}

- (MASViewAttribute *)mas_trailing {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (MASViewAttribute *)mas_left {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeLeft];
}

- (MASViewAttribute *)mas_top {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeTop];
}

- (MASViewAttribute *)mas_right {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeRight];
}

- (MASViewAttribute *)mas_bottom {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeBottom];
}

- (MASViewAttribute *)mas_width {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeWidth];
}

- (MASViewAttribute *)mas_height {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeHeight];
}

- (MASViewAttribute *)mas_centerX {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (MASViewAttribute *)mas_centerY {
    return [[MASViewAttribute alloc] initWithView:nil item:self layoutAttribute:NSLayoutAttributeCenterY];
}

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (UIView *)mas_closestCommonSuperview:(UIView *)view {
    UIView *closestCommonSuperview = nil;

    UIView *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        UIView *firstViewSuperview = self.owningView;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
