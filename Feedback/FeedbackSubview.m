//
//  FeedbackSubview.m
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import "FeedbackSubview.h"

#import <PureLayout.h>

@interface FeedbackSubview()

@property (nonatomic, strong) UIImageView *feedbackImageView;
@property (nonatomic, strong) UILabel *feedbackTitleLabel;

@end

@implementation FeedbackSubview

-(instancetype)initWithDelegate:(id <FeedbackSubviewDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        [self setupView];
        [self setupConstraint];
        [self setupAction];
    }
    return self;
}

- (void)setupView {
    _feedbackImageView = [UIImageView newAutoLayoutView];
    [_feedbackImageView.layer setCornerRadius:([_delegate sizeForSubview].width / 2)];
    [_feedbackImageView.layer setMasksToBounds:true];
    [_feedbackImageView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:_feedbackImageView];
    
    _feedbackTitleLabel = [UILabel newAutoLayoutView];
    [self addSubview:_feedbackTitleLabel];
}

- (void)setupConstraint {
    if (_delegate == nil) {
        return;
    }
    
    [_feedbackImageView autoSetDimension:ALDimensionHeight toSize:[_delegate sizeForSubview].height];
    [_feedbackImageView autoSetDimension:ALDimensionWidth toSize:[_delegate sizeForSubview].width];
    [_feedbackImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_feedbackImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    [_feedbackTitleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:_feedbackImageView withOffset:12];
}

- (void)setupAction {
    
}

@end
