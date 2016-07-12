//
//  FeedbackView.m
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import "FeedbackView.h"
#import "FeedbackSubview.h"
#import "FeedbackMoveSubview.h"

#import <PureLayout.h>

@interface FeedbackView()<FeedbackSubviewDelegate>

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) FeedbackSubview *moveView;
@property (nonatomic, strong) NSMutableArray *views;

@end

@implementation FeedbackView

- (instancetype)init {
    if (self = [super init]) {
        _views = [NSMutableArray array];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        _views = [NSMutableArray array];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

- (void)setupView {
    _line = [UIView newAutoLayoutView];
    _line.backgroundColor = [UIColor grayColor];
    [self addSubview:_line];
    [self sendSubviewToBack:_line];
    
    _moveView = [FeedbackSubview newAutoLayoutView];
    [self addSubview:_moveView];
}

- (void)reloadView {
    if (_datasource == nil) {
        return;
    }
    
    FeedbackSubview *previousSubview;
    NSInteger totalRows = ([self.datasource numberOfRows] - 1);
    for (int i = 0 ; i < totalRows; i++) {
        FeedbackSubview *subView = [[FeedbackSubview alloc] initWithDelegate:self];
        [self addSubview:subView];
        
        // Setup Constraints
        [subView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [subView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        if (previousSubview == nil) {
            [subView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        } else {
            [subView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:previousSubview];
            [subView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:previousSubview];
        }
        
        if (totalRows - 1 == i) {
            [subView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        }
        
        
        previousSubview = subView;
        [_views addObject:subView];
    }
    [self setupConstraint];
}

- (void)setupConstraint {
    if (_delegate == nil) {
        return;
    }
    
    [_moveView autoSetDimension:ALDimensionHeight toSize:[_delegate sizeForMoveView].height];
    [_moveView autoSetDimension:ALDimensionWidth toSize:[_delegate sizeForMoveView].width];
    
    FeedbackSubview *firstView = _views.firstObject;
    FeedbackSubview *lastView = _views.lastObject;
    
    [_moveView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:firstView];
    [_moveView autoAlignAxis:ALAxisVertical toSameAxisOfView:firstView];
    
    [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:firstView.feedbackImageView];
    [_line autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:lastView.feedbackImageView];
    [_line autoSetDimension:ALDimensionHeight toSize:5];
    [_line autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

-(CGSize)sizeForSubview {
    return [_delegate sizeForViewAtRow:0];
}

#pragma mark - FeedbackSubviewDelegate

- (void)didSelectFeedbackSubview:(FeedbackSubview *)feedbackSubview {
    [UIView animateWithDuration:0.25 animations:^{
        
    }];
}

@end
