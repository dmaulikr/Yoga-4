//
//  HomeViewController.h
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewControllerDelegate
- (void) toTime:(NSString *) state;
@end

@interface HomeViewController : UIViewController

@property (weak, nonatomic) id <HomeViewControllerDelegate> delegate;


-(void)toPortrait;
-(void)toLandscape;

@end
