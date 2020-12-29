//
//  MASGuideViewConstraint+Private.h
//  Masonry_LayoutGuideExt
//
//  Created by 李宁 on 2020/12/29.
//


#import <Masonry/Masonry.h>
#import "MASGuideViewConstraint.h"

@interface MASGuideViewConstraint ()

@property (nonatomic, weak) MAS_VIEW *installedView;
@property (nonatomic, weak) MASLayoutConstraint *layoutConstraint;
@property (nonatomic, assign) NSLayoutRelation layoutRelation;
@property (nonatomic, assign) MASLayoutPriority layoutPriority;
@property (nonatomic, assign) CGFloat layoutMultiplier;
@property (nonatomic, assign) CGFloat layoutConstant;
@property (nonatomic, strong) id mas_key;

- (BOOL)supportsActiveProperty;
- (BOOL)hasBeenInstalled;

@end

