//
//  MASLayoutGuideConstraintMaker.h
//  Masonry_LayoutGuideExt
//
//  Created by 李宁 on 2020/12/29.
//

#import <UIKit/UIKit.h>
#import "MASConstraintMaker.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  Provides factory methods for creating MASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface MASLayoutGuideConstraintMaker : NSObject

/**
 *    The following properties return a new MASViewConstraint
 *  with the first item set to the makers associated view and the appropriate MASViewAttribute
 */
@property (nonatomic, strong, readonly) MASConstraint *left;
@property (nonatomic, strong, readonly) MASConstraint *top;
@property (nonatomic, strong, readonly) MASConstraint *right;
@property (nonatomic, strong, readonly) MASConstraint *bottom;
@property (nonatomic, strong, readonly) MASConstraint *leading;
@property (nonatomic, strong, readonly) MASConstraint *trailing;
@property (nonatomic, strong, readonly) MASConstraint *width;
@property (nonatomic, strong, readonly) MASConstraint *height;
@property (nonatomic, strong, readonly) MASConstraint *centerX;
@property (nonatomic, strong, readonly) MASConstraint *centerY;
@property (nonatomic, strong, readonly) MASConstraint *baseline;



@property (nonatomic, strong, readonly) MASConstraint *firstBaseline;
@property (nonatomic, strong, readonly) MASConstraint *lastBaseline;

@property (nonatomic, strong, readonly) MASConstraint *leftMargin;
@property (nonatomic, strong, readonly) MASConstraint *rightMargin;
@property (nonatomic, strong, readonly) MASConstraint *topMargin;
@property (nonatomic, strong, readonly) MASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) MASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) MASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) MASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) MASConstraint *centerYWithinMargins;


/**
 *  Returns a block which creates a new MASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  MASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) MASConstraint *(^attributes)(MASAttribute attrs);

/**
 *    Creates a MASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate MASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) MASConstraint *edges;

/**
 *    Creates a MASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate MASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) MASConstraint *size;

/**
 *    Creates a MASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate MASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) MASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *    initialises the maker with a default view
 *
 *    @param    view    any MASConstraint are created with this view as the first item
 *
 *    @return    a new MASConstraintMaker
 */
- (id)initWithView:(MAS_VIEW *)view;

/**
 *    Calls install method on any MASConstraints which have been created by this maker
 *
 *    @return    an array of all the installed MASConstraints
 */
- (NSArray *)install;

- (MASConstraint * (^)(dispatch_block_t))group;

- (id)initWithLayoutGuide:(UILayoutGuide *)layoutGuide;

@end

NS_ASSUME_NONNULL_END

