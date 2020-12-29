//
//  MASExampleBasicView.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "MASExampleBasicView.h"
#import <Masonry_LayoutGuideExt/Masonry+layoutGuide.h>
#import <Masonry/Masonry.h>

@implementation MASExampleBasicView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];
    
//    UIView *redView = UIView.new;
//    redView.backgroundColor = UIColor.redColor;
//    redView.layer.borderColor = UIColor.blackColor.CGColor;
//    redView.layer.borderWidth = 2;
//    [self addSubview:redView];
    
    UILayoutGuide *redLayoutGuide = [UILayoutGuide new];
    
    [self addLayoutGuide:redLayoutGuide];
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(redLayoutGuide);
//    }];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];
    
    UIView *superview = self;
    int padding = 10;
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.mas_top).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
        make.width.equalTo(redLayoutGuide.mas_width);
//        
//        make.left.equalTo(superview.left).offset(padding);
//        make.bottom.equalTo(blueView.top).offset(-padding);
//        make.width.equalTo(redLayoutGuide.width);
    }];

    
//    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.greaterThanOrEqualTo(superview.top);
//    }];
//    [greenView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.greaterThanOrEqualTo(superview.top).offset(padding);
//        make.left.equalTo(superview.left).offset(padding);
//        make.bottom.equalTo(blueView.top).offset(-padding);
//        make.width.equalTo(redLayoutGuide.width);
//
////        make.height.equalTo(redLayoutGuide.height);
////        make.height.equalTo(blueView.height);
//
//    }];

    //with is semantic and option
    [redLayoutGuide mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding); //with with
        make.left.equalTo(greenView.mas_right).offset(padding); //without with
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        
//        make.height.equalTo(@[greenView, blueView]); //can pass array of views
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(greenView.mas_bottom).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.height.equalTo(@[greenView.mas_height, redLayoutGuide.mas_height]); //can pass array of attributes
    }];

    return self;
}

@end
