//
//  MusicViewController.m
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()
@property int minutes;
@property int seconds;
@property NSTimer *updateTimer;
@property double currSeconds;
@property NSDate *reftime;
@end

@implementation MusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _minutes = _time / 60;
    _seconds = _time % 60;
    
    _reftime = [NSDate date];
    _SongTitle.text = [NSString stringWithFormat:@""];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    _StateLabel.text = [NSString stringWithFormat:@"%@",_state];
    _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_minutes, _seconds];

    
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1
                                                             target: self
                                                           selector: @selector(timerUpdate:)
                                                           userInfo: nil
                                                            repeats: YES];
}

-(void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [_updateTimer invalidate];
}

-(void)willMoveToParentViewController:(UIViewController *)parent

{
    //self.view.backgroundColor=[UIColor blueColor];
}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    //self.view.frame = parent.view.frame;
}

-(void)timerUpdate:(NSTimer*)timer
{
    _currSeconds = [[NSDate date] timeIntervalSinceDate:_reftime];
    
    
    NSLog(@"%f", _currSeconds);
    
    _minutes = (_time - (int)_currSeconds) / 60;
    _seconds = (_time - (int)_currSeconds) % 60;
    
    _TimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_minutes, _seconds];
    
    if(_minutes <= 0 && _seconds <= 0)
    {
        [_updateTimer invalidate];
    }
    
}

- (IBAction)toHome:(id)sender {
    [self.delegate toHome];
}

-(void)toPortrait
{
    if(self.view.frame.size.width > self.view.frame.size.height)
    {
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
                             
                         }completion:^(BOOL finished) {}];
    }
}

-(void)toLandscape
{
    if(self.view.frame.size.height > self.view.frame.size.width)
    {
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.view.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
                             
                         }completion:^(BOOL finished) {}];
    }
}

-(void)setNewSongTitle:(NSString *)songTitle
{
    _SongTitle.text = [NSString stringWithFormat:songTitle];
}



@end
