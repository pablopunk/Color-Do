//
//  PVThirdTableViewController.m
//  Color Do
//
//  Created by Pablo Varela on 21/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import "PVThirdTableViewController.h"
#import "PVSecondTableViewCell.h"

@interface PVThirdTableViewController ()

@end

@implementation PVThirdTableViewController  {
    BOOL pullDownInProgress;
}

@synthesize items;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //[super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Right gesture
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(rightSwipeHandle:)];
    [rightRecognizer setDirection: (UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:rightRecognizer];
    
    // Drag and drop
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
    
    // Refreshing
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat refreshHeight = 60.0f;
    //UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, screenWidth, refreshHeight)];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"New Item"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [refresh setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin)];
    [[refresh.subviews objectAtIndex:0] setFrame:CGRectMake(0, 0, screenWidth, refreshHeight)];
    
    // Items
    PVListItem* primerItem = [[PVListItem alloc] init];
    primerItem.titulo = @"Leche";
    primerItem.color = blue;
    PVListItem* segundoItem = [[PVListItem alloc] init];
    segundoItem.titulo = @"Pan";
    segundoItem.color = red;
    PVListItem* tercerItem = [[PVListItem alloc] init];
    tercerItem.titulo = @"Helados";
    tercerItem.color = yellow;
    PVListItem* cuartoItem = [[PVListItem alloc] init];
    cuartoItem.titulo = @"Patatas fritas";
    cuartoItem.color = green;
    
    
    items = [[NSMutableArray alloc] init];
//    [items addObject:primerItem];
//    [items addObject:segundoItem];
//    [items addObject:tercerItem];
//    [items addObject:cuartoItem];
    
    // Cargar items
    [self cargarItemsGuardados];
    
}

- (void)cargarItemsGuardados {
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"count_buy"]];
    
    for (int i=0; i < count; i++) {
        [items insertObject:[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"item_buy%i",i]]] atIndex:i];
    }
}

- (void)addItem: (PVListItem*) item {
    [items addObject:item];
    [self guardarDatos];
}

- (void) guardarDatos {
    NSData* temp;
    
    [[NSUserDefaults standardUserDefaults] setInteger:[items count] forKey:@"count_buy"];
    
    for (int i=0; i < [items count]; i++) {
        temp = [NSKeyedArchiver archivedDataWithRootObject:[items objectAtIndex:i]];
        [[NSUserDefaults standardUserDefaults] setObject:temp forKey:[NSString stringWithFormat:@"item_buy%i",i]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    UINavigationController *navController = self.navigationController;
    
    // Pop this controller and replace with another
    [navController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PVSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.superTable = self;
    cell.item = [items objectAtIndex:indexPath.row];
    cell = [cell inicializar:[items objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

// Swipe to delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PVSecondTableViewCell* celda = (PVSecondTableViewCell*) [self.tableView cellForRowAtIndexPath:indexPath];
        NSString* trimmedText = [celda.textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        
        if (indexPath.row > 0) {
            [items removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self refreshTable];
            
        } else if ([trimmedText isEqualToString:@""]){
            [celda.textLabel resignFirstResponder];
        } else {
            [items removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self refreshTable];
        }
    }
}

- (void)refreshTable {
    PVListItem *item, *item1;
    
    for (int i = 0; i < [items count]; i++) {
        
        item = [items objectAtIndex:i];
        PVSecondTableViewCell* celda = (PVSecondTableViewCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [celda desaparecerBotones];
        [celda textFieldShouldReturn:celda.textField];
        
        if (i < [items count]-1) {
            item1 = [items objectAtIndex:i+1];
            if (item.color == item1.color) {
                if (item.color == red) {
                    item1.color = redD;
                } else if (item.color == blue) {
                    item1.color = blueD;
                } else if (item.color == yellow) {
                    item1.color = yellowD;
                } else if (item.color == green) {
                    item1.color = greenD;
                } else if (item.color == redD) {
                    item1.color = red;
                } else if (item.color == yellowD) {
                    item1.color = yellow;
                } else if (item.color == greenD) {
                    item1.color = green;
                } else if (item.color == blueD) {
                    item1.color = blue;
                }
            }
        }
    }
    
    [self guardarDatos];
    
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
}

//#pragma mark - UIScrollViewDelegate
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    // this behaviour starts when a user pulls down while at the top of the table
//    pullDownInProgress = scrollView.contentOffset.y <= 0.0f;
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    if (pullDownInProgress && self.tableView.contentOffset.y <= 0.0f) {
//
//    } else {
//        pullDownInProgress = false;
//    }
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//
//    if (-self.tableView.contentOffset.y > (155-20)) {
//        PVListItem* nuevo = [[PVListItem alloc] init];
//        nuevo.titulo = @"New Item";
//        nuevo.color = red;
//        [items insertObject:nuevo atIndex:0];
//        [self refreshTable];
//    }
//}

// Refreshing
-(void)refreshView:(UIRefreshControl *)refresh {
    [refresh endRefreshing];
    
    PVSecondTableViewCell* celda = (PVSecondTableViewCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    NSString* trimmedText = [celda.textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    
    if (![trimmedText isEqualToString: @""]) {
        PVListItem* nuevo = [[PVListItem alloc] init];
        nuevo.color = blue;
        nuevo.titulo = @"";
        [items insertObject:nuevo atIndex:0];
        [self refreshTable];
    }
    
    celda = (PVSecondTableViewCell*) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [celda.textField becomeFirstResponder];
    celda.isBeingEditedForTheFirstTime = YES;
}

// Drag and drop para mover celdas
- (IBAction)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    //PROPIO: desactivar el teclado cuando empieza el drag
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell endEditing:YES];
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshotFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    
                    // Fade out.
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [items exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo fade out.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
                // PROPIO: Para refrescar colores
                [self refreshTable];
                
            }];
            break;
        }
    }
}

- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
