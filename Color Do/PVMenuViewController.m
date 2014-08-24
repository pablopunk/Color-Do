//
//  PVMenuViewController.m
//  Color Do
//
//  Created by Pablo Varela on 24/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import "PVMenuViewController.h"

@interface PVMenuViewController ()

@end

@implementation PVMenuViewController

@synthesize countToDo;
@synthesize countToBuy;

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
    
    [self.countToDoLabel setFont: [UIFont fontWithName:@"Aller" size:18]];
    [self.countToBuyLabel setFont: [UIFont fontWithName:@"Aller" size:18]];
    [self.countToDoLabel setTextColor:[UIColor whiteColor]];
    [self.countToBuyLabel setTextColor:[UIColor whiteColor]];
    
    [self cargarCounts];
}

- (void)viewWillAppear:(BOOL)animated {
    [self cargarCounts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cargarCounts {
    countToDo = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"count"]];
    countToBuy = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"count_buy"]];
    
    [self.countToDoLabel setText:[NSString stringWithFormat:@"%li",(long)countToDo]];
    [self.countToBuyLabel setText:[NSString stringWithFormat:@"%li",(long)countToBuy]];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = countToDo+countToBuy;
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
