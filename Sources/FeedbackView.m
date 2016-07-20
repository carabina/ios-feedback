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

#import "PureLayout.h"

@interface FeedbackView()<FeedbackSubviewDelegate, FeedbackMoveSubviewDelegate>

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) FeedbackMoveSubview *currentView;
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
    
    _currentView = [FeedbackMoveSubview newAutoLayoutView];
    _currentView.delegate = self;
    [self addSubview:_currentView];
}

- (void)reloadView {
    if (_datasource == nil) {
        return;
    }
    
    FeedbackSubview *previousSubview;
    NSInteger totalRows = [self.datasource numberOfRows];
    for (int i = 0 ; i < totalRows; i++) {
        FeedbackSubview *subView = [[FeedbackSubview alloc] initWithDelegate:self];
        [self addSubview:subView];
        
        subView.unselectedImage = [_datasource imageForUnselectedViewAtRow:i];
        subView.selectedImage = [_datasource imageForSelectedViewAtRow:i];
        subView.feedbackTitleLabel.text = [_datasource titleForSelectedViewAtRow:i];
        
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
    
    if (_defaultRow) {
        _currentView.image = [_datasource imageForSelectedViewAtRow:_defaultRow];
    }
    
    [self sendSubviewToBack:_line];
    [self bringSubviewToFront:_currentView];
    [self setupConstraint];
}

- (void)setupConstraint {
    if (_delegate == nil) {
        return;
    }
    
    [_currentView autoSetDimension:ALDimensionHeight toSize:[_delegate sizeForMoveView].height];
    [_currentView autoSetDimension:ALDimensionWidth toSize:[_delegate sizeForMoveView].width];
    
    FeedbackSubview *firstView = _views.firstObject;
    FeedbackSubview *lastView = _views.lastObject;
    
    if (_defaultRow) {
        [_currentView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:[_views objectAtIndex:_defaultRow]];
        [_currentView autoAlignAxis:ALAxisVertical toSameAxisOfView:[_views objectAtIndex:_defaultRow]];
    } else {
        [_currentView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:firstView];
        [_currentView autoAlignAxis:ALAxisVertical toSameAxisOfView:firstView];
    }
    
    [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:firstView.feedbackImageView];
    [_line autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:lastView.feedbackImageView];
    [_line autoSetDimension:ALDimensionHeight toSize:5];
    [_line autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

#pragma mark - FeedbackSubviewDelegate

-(CGSize)sizeForSubview {
    return [_delegate sizeForViewAtRow:0];
}

- (void)didSelectFeedbackSubview:(FeedbackSubview *)feedbackSubview {
    [UIView animateWithDuration:0.25 animations:^{
        self.currentView.image = feedbackSubview.selectedImage;
        [self.currentView setCenter:feedbackSubview.center];
    }];
}

#pragma mark - FeedbackMoveSubviewDelegate

- (void)viewDidMoveToLocation:(CGPoint)location {
    
}

- (void)viewMoveDidStoppedAtLocation:(CGPoint)location {
    
    int distance;
    int minIndex = 0;
    int minDistance = INT_MAX;
    
    for (int i = 0; i < _views.count; i++) {
        FeedbackSubview *view = [_views objectAtIndex:i];
        distance = fabs(view.center.x - location.x);
        if (minDistance > distance) {
            minIndex = i;
            minDistance = distance;
        }
    }
    FeedbackSubview *view = [_views objectAtIndex:minIndex];
    [UIView animateWithDuration:0.15 animations:^{
        self.currentView.image = view.selectedImage;
        [self.currentView setCenter:view.center];
    }];
}

@end
