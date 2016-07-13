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
        
        [self addObserver:self forKeyPath:@"unselectedImage" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"unselectedImage"]) {
        _feedbackImageView.image = _unselectedImage;
    }
    
    if ([keyPath isEqualToString:@"selectedImage"]) {
        _feedbackImageView.highlightedImage = _selectedImage;
    }
}

- (void)setupView {
    _feedbackImageView = [UIImageView newAutoLayoutView];
    _feedbackImageView.backgroundColor = [UIColor whiteColor];
    [_feedbackImageView.layer setCornerRadius:([_delegate sizeForSubview].width / 2)];
    [_feedbackImageView.layer setMasksToBounds:true];
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
    
    [_feedbackTitleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:_feedbackImageView];
    [_feedbackTitleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_feedbackImageView withOffset:8];
}

- (void)setupAction {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectFeedbackSubview)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
    [self setUserInteractionEnabled:true];
}

- (void)didSelectFeedbackSubview {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectFeedbackSubview:)]) {
        [_delegate didSelectFeedbackSubview:self];
    }
}

@end
