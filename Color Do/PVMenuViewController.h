//
//  PVMenuViewController.h
//  Color Do
//
//  Created by Pablo Varela on 24/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVMenuViewController : UIViewController

@property (nonatomic) NSInteger countToDo;
@property (nonatomic) NSInteger countToBuy;
@property (weak, nonatomic) IBOutlet UILabel *countToDoLabel;
@property (weak, nonatomic) IBOutlet UILabel *countToBuyLabel;

@end
