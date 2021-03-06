//
//  UILayoutGuide+MASShorthandAdditions.m
//  Masonry_LayoutGuideExt
//
//  Created by 李宁 on 2020/12/27.
//

#import "UILayoutGuide+MASShorthandAdditions.h"

@implementation UILayoutGuide (MASShorthandAdditions)


MAS_ATTR_FORWARD(leading);
MAS_ATTR_FORWARD(trailing);
MAS_ATTR_FORWARD(top);
MAS_ATTR_FORWARD(left);
MAS_ATTR_FORWARD(bottom);
MAS_ATTR_FORWARD(right);
MAS_ATTR_FORWARD(width);
MAS_ATTR_FORWARD(height);
MAS_ATTR_FORWARD(centerX);
MAS_ATTR_FORWARD(centerY);


- (NSArray *)makeConstraints:(void (NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker * _Nonnull))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void (NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker * _Nonnull))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void (NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker * _Nonnull))block {
    return [self mas_remakeConstraints:block];
}


@end
