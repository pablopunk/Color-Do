//
//  PVThirdTableViewController.h
//  Color Do
//
//  Created by Pablo Varela on 21/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ayuda.h"
#import "PVListItem.h"

@interface PVThirdTableViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray* items;
- (void) addItem: (PVListItem*) item;
- (void) refreshTable;
- (void) guardarDatos;
- (void)cargarItemsGuardados;

@end
