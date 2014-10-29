//
//  MusicViewController.h
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicViewControllerDelegate
- (void) toHome;
@end

@interface MusicViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *SongTitle;
@property (weak, nonatomic) IBOutlet UILabel *StateLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;

@property (weak, nonatomic) id <MusicViewControllerDelegate> delegate;

@property NSString *state;
@property int time;

-(void)toPortrait;
-(void)toLandscape;

-(void)setNewSongTitle:(NSString *)songTitle;

@end
