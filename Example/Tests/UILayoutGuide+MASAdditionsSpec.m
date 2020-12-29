//
//  View+MASAdditionsSpec.m
//  Masonry
//
//  Created by Jonas Budelmann on 8/09/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "UILayoutGuide+MASAdditions.h"

SpecBegin(LayoutGuide_MASAdditions)

- (void)testSetTranslatesAutoresizingMaskIntoConstraints {
    UILayoutGuide *layoutGuide = UILayoutGuide.new;
    [layoutGuide mas_makeConstraints:^(MASLayoutGuideConstraintMaker * _Nonnull make) {
        expect(make.updateExisting).to.beFalsy();
    }];
}

- (void)testSetUpdateExisting {
    UILayoutGuide *layoutGuide = UILayoutGuide.new;
    [layoutGuide mas_updateConstraints:^(MASLayoutGuideConstraintMaker * _Nonnull make) {
        expect(make.updateExisting).to.beTruthy();
    }];
}

- (void)testSetRemoveExisting {
    UILayoutGuide *layoutGuide = UILayoutGuide.new;
    [layoutGuide mas_remakeConstraints:^(MASLayoutGuideConstraintMaker * _Nonnull make) {
        expect(make.removeExisting).to.beTruthy();
    }];
}

SpecEnd
