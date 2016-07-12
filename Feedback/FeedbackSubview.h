//
//  FeedbackSubview.h
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FeedbackSubview;

@protocol FeedbackSubviewDelegate <NSObject>

@required
- (CGSize)sizeForSubview;

@optional
- (void)didSelectFeedbackSubview:(FeedbackSubview *)feedbackSubview;

@end

@interface FeedbackSubview : UIView

@property (nonatomic, strong, readonly) UIImageView *feedbackImageView;
@property (nonatomic, strong, readonly) UILabel *feedbackTitleLabel;

@property (nonatomic, weak) id <FeedbackSubviewDelegate> delegate;

-(instancetype)initWithDelegate:(id <FeedbackSubviewDelegate>)delegate;

@end
