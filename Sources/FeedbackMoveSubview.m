//
//  FeedbackMoveSubview.m
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import "FeedbackMoveSubview.h"

@implementation FeedbackMoveSubview

- (instancetype)init {
    if (self = [super init]) {
        [self setupAction];
    }
    return self;
}

- (void)setupAction {
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidMove:)];
    [self setUserInteractionEnabled:true];
    [self addGestureRecognizer:panGestureRecognizer];
}

- (void)viewDidMove:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint locationInView = [panGestureRecognizer locationInView:self.superview];
    locationInView.y = self.center.y;
    [self setCenter:locationInView];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_delegate && [_delegate respondsToSelector:@selector(viewMoveDidStoppedAtLocation:)]) {
            [_delegate viewMoveDidStoppedAtLocation:locationInView];
        }
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(viewDidMoveToLocation:)]) {
        [_delegate viewDidMoveToLocation:locationInView];
    }
}

@end
