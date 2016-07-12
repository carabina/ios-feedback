//
//  FeedbackView.h
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedbackDatasource <NSObject>

@required
- (NSInteger)numberOfRows;
- (NSString *)titleForSelectedViewAtRow:(NSInteger)row;
- (UIImage *)imageForUnselectedViewAtRow:(NSInteger)row;
- (UIImage *)imageForSelectedViewAtRow:(NSInteger)row;

@end

@protocol FeedbackDelegate <NSObject>

@required
- (CGSize)sizeForViewAtRow:(NSInteger)row;
- (CGSize)sizeForMoveView;

@end

@interface FeedbackView : UIView

@property (nonatomic, weak) id <FeedbackDatasource> datasource;
@property (nonatomic, weak) id <FeedbackDelegate> delegate;

- (void)reloadView;

@end
