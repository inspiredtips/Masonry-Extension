//
//  UILayoutGuide+MASShorthandAdditions.h
//  Masonry_LayoutGuideExt
//
//  Created by 李宁 on 2020/12/27.
//

#import <UIKit/UIKit.h>
#import "UILayoutGuide+MASAdditions.h"

NS_ASSUME_NONNULL_BEGIN

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

@property (nonatomic, strong, readonly) MASViewAttribute *left;
@property (nonatomic, strong, readonly) MASViewAttribute *top;
@property (nonatomic, strong, readonly) MASViewAttribute *right;
@property (nonatomic, strong, readonly) MASViewAttribute *bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *leading;
@property (nonatomic, strong, readonly) MASViewAttribute *trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *width;
@property (nonatomic, strong, readonly) MASViewAttribute *height;
@property (nonatomic, strong, readonly) MASViewAttribute *centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *centerY;
@property (nonatomic, strong, readonly) MASViewAttribute *baseline;
@property (nonatomic, strong, readonly) MASViewAttribute *(^attribute)(NSLayoutAttribute attr);

@property (nonatomic, strong, readonly) MASViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) MASViewAttribute *lastBaseline;

@property (nonatomic, strong, readonly) MASViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *topMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) MASViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) MASViewAttribute *centerYWithinMargins;


- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;


@end

NS_ASSUME_NONNULL_END
