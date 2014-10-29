//
//  HomeViewController.m
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property UIViewController *parent;
@end

@implementation HomeViewController

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
    
    
}

-(BOOL)shouldAutorotate { return YES;}

-(NSUInteger)supportedInterfaceOrientations {
    //NSLog(@"called orientation");
    return (UIInterfaceOrientationMaskAll); }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willMoveToParentViewController:(UIViewController *)parent

{
    //self.view.backgroundColor=[UIColor blueColor];

}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
    NSLog(@"(%f, %f)", parent.view.bounds.size.width, parent.view.bounds.size.height);
    //self.view.bounds = parent.view.bounds;
    /*self.view.frame = parent.view.frame;
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        self.view.frame = CGRectMake(0, 0, parent.view.frame.size.height, parent.view.frame.size.width);
    }*/
    
    
}


- (IBAction)clickedYoga:(id)sender {
    [self.delegate toTime:@"Yoga"];
    NSLog(@"Pressed Yoga");
}

- (IBAction)clickedMeditation:(id)sender {
    [self.delegate toTime:@"Meditation"];
    NSLog(@"Pressed Meditation");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
