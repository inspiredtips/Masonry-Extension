//
//  UILayoutGuide+MASShorthandAdditions.h
//  Masonry_LayoutGuideExt
//
//  Created by 李宁 on 2020/12/27.
//

#import <UIKit/UIKit.h>
#import "UILayoutGuide+MASAdditions.h"
#import "MASLayoutGuideConstraintMaker.h"

#define MAS_ATTR_FORWARD(attr)  \
- (MASViewAttribute *)attr {    \
    return [self mas_##attr];   \
}

#define MAS_ATTR_FORWARD_AVAILABLE(attr, available)  \
- (MASViewAttribute *)attr available {    \
    return [self mas_##attr];   \
}

/**
 *    Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface UILayoutGuide (MASShorthandAdditions)


@property (nonatomic, strong, readonly) MASViewAttribute *leading;
@property (nonatomic, strong, readonly) MASViewAttribute *trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *left;
@property (nonatomic, strong, readonly) MASViewAttribute *top;
@property (nonatomic, strong, readonly) MASViewAttribute *right;
@property (nonatomic, strong, readonly) MASViewAttribute *bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *width;
@property (nonatomic, strong, readonly) MASViewAttribute *height;
@property (nonatomic, strong, readonly) MASViewAttribute *centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *centerY;


- (NSArray *)makeConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker *make))block;


@end

