//
//  TimeViewController.m
//  yoga
//
//  Created by Dustin Bayer on 10/6/14.
//  Copyright (c) 2014 Dustin Bayer. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()
@property NSArray *pickerData;
@end

@implementation TimeViewController

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
    _time = 5 * 60;
    _timePicker.delegate = self;
    _timePicker.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if([_state isEqual: @"Yoga"])
    {
        _pickerData = @[@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", @"55", @"60", @"65", @"70", @"75"];
    }
    else if ([_state isEqual: @"Meditation"])
    {
        _pickerData = @[@"5", @"10", @"15", @"20", @"25", @"30"];
    }
}

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
   // self.view.frame = parent.view.frame;
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _time = (row * 5 +5) * 60;
}

- (IBAction)clickedGo:(id)sender {
    [self.delegate toMusic:_time];
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
