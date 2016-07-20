//
//  FeedbackMoveSubview.h
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedbackMoveSubviewDelegate <NSObject>

- (void)viewDidMoveToLocation:(CGPoint)location;
- (void)viewMoveDidStoppedAtLocation:(CGPoint)location;

@end

@interface FeedbackMoveSubview : UIImageView

@property (nonatomic, weak) id <FeedbackMoveSubviewDelegate> delegate;

@end
