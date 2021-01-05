//
//  MASViewController.m
//  Masonry_LayoutGuideExt
//
//  Created by inspiredtip on 12/27/2020.
//  Copyright (c) 2020 inspiredtip. All rights reserved.
//

#import "MASViewController.h"
#import "MASExampleBasicView.h"
#import <Masonry_LayoutGuideExt/Masonry+layoutGuide.h>


@interface MASViewController ()

@end

@implementation MASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[MASExampleBasicView alloc] init];
    
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

@end
