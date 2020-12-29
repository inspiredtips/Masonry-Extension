//
//  MASGuideViewConstraint.h
//  Masonry_LayoutGuideExt
//
//  Created by 李宁 on 2020/12/29.
//

#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MASGuideViewConstraint : MASViewConstraint

+ (NSArray  * _Nullable)installedConstraintsForLayoutGuide:(UILayoutGuide *)layoutGuide;

@end

NS_ASSUME_NONNULL_END
