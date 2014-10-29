//
//  TimeViewController.h
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeViewControllerDelegate
- (void) toMusic:(int) time;
@end

@interface TimeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <TimeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

@property NSString *state;
@property int time;

-(void)toPortrait;
-(void)toLandscape;

@end
