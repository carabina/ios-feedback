//
//  ViewController.m
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import "ViewController.h"
#import <FeedbackView.h>

@interface ViewController ()<FeedbackDelegate, FeedbackDatasource>

@property (weak, nonatomic) IBOutlet FeedbackView *feedbackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _feedbackView.datasource = self;
    _feedbackView.delegate = self;
    _feedbackView.defaultRow = 1;
    [_feedbackView reloadView];
}

- (NSInteger)numberOfRows {
    return 4;
}

- (NSString *)titleForSelectedViewAtRow:(NSInteger)row {
    NSString *returnValue = @"";
    switch (row) {
        case 0:
            returnValue = @"Bad";
            break;
        case 1:
            returnValue = @"Okay";
            break;
        case 2:
            returnValue = @"Good";
            break;
        case 3:
            returnValue = @"Great";
            break;
    }
    return returnValue;
}

- (UIImage *)imageForUnselectedViewAtRow:(NSInteger)row {
    UIImage *returnValue = [UIImage imageNamed:@""];
    switch (row) {
        case 0:
            returnValue = [UIImage imageNamed:@"Bad"];
            break;
        case 1:
            returnValue = [UIImage imageNamed:@"Okay"];
            break;
        case 2:
            returnValue = [UIImage imageNamed:@"Good"];
            break;
        case 3:
            returnValue = [UIImage imageNamed:@"Great"];
            break;
    }
    return returnValue;}

- (UIImage *)imageForSelectedViewAtRow:(NSInteger)row {
    UIImage *returnValue = [UIImage imageNamed:@""];
    switch (row) {
        case 0:
            returnValue = [UIImage imageNamed:@"Bad_Selected"];
            break;
        case 1:
            returnValue = [UIImage imageNamed:@"Okay_Selected"];
            break;
        case 2:
            returnValue = [UIImage imageNamed:@"Good_Selected"];
            break;
        case 3:
            returnValue = [UIImage imageNamed:@"Great_Selected"];
            break;
    }
    return returnValue;
}

- (CGSize)sizeForViewAtRow:(NSInteger)row {
    return CGSizeMake(49, 49);
}

-(CGSize)sizeForMoveView {
    return CGSizeMake(60, 60);
}

@end
