//
//  ViewController.m
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import "ViewController.h"
#import "FeedbackView.h"

@interface ViewController ()<FeedbackDelegate, FeedbackDatasource>

@property (weak, nonatomic) IBOutlet FeedbackView *feedbackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _feedbackView.datasource = self;
    _feedbackView.delegate = self;
    [_feedbackView reloadView];
}

- (NSInteger)numberOfRows {
    return 4;
}

- (NSString *)titleForSelectedViewAtRow:(NSInteger)row {
    return @"Hello World";
}

- (UIImage *)imageForUnselectedViewAtRow:(NSInteger)row {
    return [[UIImage alloc] init];
}

- (UIImage *)imageForSelectedViewAtRow:(NSInteger)row {
    return [[UIImage alloc] init];
}

- (CGSize)sizeForViewAtRow:(NSInteger)row {
    return CGSizeMake(49, 49);
}

-(CGSize)sizeForMoveView {
    return CGSizeMake(49, 49);
}

@end
