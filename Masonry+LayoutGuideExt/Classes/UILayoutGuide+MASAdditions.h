//
//  UILayoutGuide+MASAdditions.h
//  Masonry LayoutGuide Extension
//
//  Created by Hiuson on 2020/8/31.
//  Copyright © 2020 Hiuson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/MASViewAttribute.h>
#import <Masonry/MASUtilities.h>
#import "MASLayoutGuideConstraintMaker.h"


@interface UILayoutGuide (MASAdditions)

/**
 *    following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) MASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_trailing;

@property (nonatomic, strong, readonly) MASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *mas_centerY;

/**
 *    a key to associate with this view
 */
@property (nonatomic, strong) id mas_key;

/**
 *    Finds the closest common superview between this view and another view
 *
 *    @param    view    other view
 *
 *    @return    returns nil if common superview could not be found
 */
- (UIView *)mas_closestCommonSuperview:(MAS_VIEW *)view;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker * make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void(NS_NOESCAPE ^)(MASLayoutGuideConstraintMaker *make))block;

@end


