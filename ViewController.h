//
//  ViewController.h
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "TimeViewController.h"
#import "MusicViewController.h"
#import "MasterMind.h"

@interface ViewController : UIViewController <HomeViewControllerDelegate, TimeViewControllerDelegate, MusicViewControllerDelegate, MasterMindDelegate>

@property HomeViewController *homeView;
@property TimeViewController *timeView;
@property MusicViewController *musicView;

@property MasterMind *musicPlayer;

@property NSString *state;
@property NSString *viewState;
@property int time;

@end
