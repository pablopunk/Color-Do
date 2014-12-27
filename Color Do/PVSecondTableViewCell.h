//
//  PVSecondTableViewCell.h
//  Color Do
//
//  Created by Pablo Varela on 20/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ayuda.h"
#import "PVListItem.h"
#import "PVSecondTableViewController.h"


@interface PVSecondTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) PVListItem* item;
@property (weak, nonatomic) UITableViewController* superTable;
@property BOOL isBeingEditedForTheFirstTime;

@property (nonatomic, retain) UIView* buttonView;
@property (nonatomic, retain) UIButton* redButton;
@property (nonatomic, retain) UIButton* blueButton;
@property (nonatomic, retain) UIButton* greenButton;
@property (nonatomic, retain) UIButton* yellowButton;

- (PVSecondTableViewCell*) inicializar:(PVListItem *) item;

- (void)changeToRed;
- (void)changeToGreen;
- (void)changeToYellow;
- (void)changeToBlue;

-(void)desaparecerBotones;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
