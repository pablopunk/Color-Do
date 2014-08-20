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

@interface PVSecondTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) PVSecondTableViewController* superTable;

- (PVSecondTableViewCell*) inicializar:(PVListItem *) item;

@end
