//
//  PVSettingsViewController.m
//  Color Do
//
//  Created by Pablo Varela on 25/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import "PVSettingsViewController.h"

@interface PVSettingsViewController ()

@end

@implementation PVSettingsViewController

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
    // Do any additional setup after loading the view.
    
    // Right gesture
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(rightSwipeHandle:)];
    [rightRecognizer setDirection: (UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:rightRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Swipe to pop VC
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    UINavigationController *navController = self.navigationController;
    
    // Pop this controller and replace with another
    [navController popViewControllerAnimated:YES];
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
