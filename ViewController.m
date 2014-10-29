//
//  ViewController.m
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _homeView = [self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
    
    _homeView.delegate = self;
  
    
    _state = [[NSString alloc] init];
    _viewState = [[NSString alloc] initWithFormat:@"Home"];
    
    _musicPlayer = [[MasterMind alloc] init];
    _musicPlayer.delegate = self;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(deviceOrientationDidChangeNotification:)
     name:UIDeviceOrientationDidChangeNotification
     object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self displayContentController:_homeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deviceOrientationDidChangeNotification:(NSNotification*)note
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if(orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown)
    {
        if([_viewState  isEqual: @"Home"])
        {
            [_homeView toPortrait];
        }
        else if([_viewState  isEqual: @"Time"])
        {
            [_timeView toPortrait];
        }
        else if([_viewState  isEqual: @"Music"])
        {
            [_musicView toPortrait];
        }
    }
    else if(orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
    {
        if([_viewState  isEqual: @"Home"])
        {
            [_homeView toLandscape];
        }
        else if([_viewState  isEqual: @"Time"])
        {
            [_timeView toLandscape];
        }
        else if([_viewState  isEqual: @"Music"])
        {
            [_musicView toLandscape];
        }
    }
}

- (void) displayContentController: (UIViewController*) content;
{
    [self addChildViewController:content];
    
    content.view.frame = CGRectMake(0, 0,
                                      CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(self.view.bounds));
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];
}

- (void) hideContentController: (UIViewController*) content
{
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}

- (void) cycleFromViewController: (UIViewController*) oldC
                toViewController: (UIViewController*) newC
{
    [oldC willMoveToParentViewController:nil];                      
    [self addChildViewController:newC];
    
    newC.view.frame = CGRectMake(self.view.frame.size.width, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    CGRect endFrame = CGRectMake(-self.view.frame.size.width, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    
    [self transitionFromViewController: oldC toViewController: newC
                              duration: 0.25 options:0
                            animations:^{
                                newC.view.frame = oldC.view.frame;
                                oldC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                [self hideContentController:oldC];
                                [newC didMoveToParentViewController:self];
                            }];
}

- (void)toHome {
    
    [_musicPlayer stopPlaying];
    _homeView = [self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
    _viewState = @"Home";
    _homeView.delegate = self;
    [self cycleFromViewController:_musicView toViewController:_homeView];
    _musicView = nil;
}

- (void)toTime:(NSString *)state {
    
    _timeView = [self.storyboard instantiateViewControllerWithIdentifier:@"timeView"];
    _viewState = @"Time";
    _timeView.delegate = self;
    _state = state;
    _timeView.state = _state;
    [self cycleFromViewController:_homeView toViewController:_timeView];
    _homeView= nil;
}

- (void)toMusic:(int) time{
    
    _musicView = [self.storyboard instantiateViewControllerWithIdentifier:@"musicView"];
    _viewState = @"Music";
    _musicView.delegate = self;
    _time = time;
    _musicView.time = _time;
    _musicView.state = _state;
    [self cycleFromViewController:_timeView toViewController:_musicView];
    _timeView = nil;
    
    [_musicPlayer startPlayingWithDuration:_time];
}

-(void)updateSongTitle:(NSString *)songTitle
{
    [_musicView setNewSongTitle:songTitle];
}

@end
