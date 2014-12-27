//
//  PVInfoViewController.m
//  Color Do
//
//  Created by Pablo Varela on 25/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import "PVInfoViewController.h"

@interface PVInfoViewController ()

@end

@implementation PVInfoViewController

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

- (IBAction)pablopunkButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.pablopunk.com"]];
}

- (IBAction)mailButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"mailto:pablovarela182@gmail.com?&subject=Color%20Do%20Support"]];
    
}

- (IBAction)rateUsButton:(id)sender {
    // Cambiar 'id' 409954448
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/color-do-organize-with-colors/id912541576?l=es&ls=1&mt=8"]];

}
@end
