//
//  PVSecondTableViewCell.m
//  Color Do
//
//  Created by Pablo Varela on 20/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import "PVSecondTableViewCell.h"

@implementation PVSecondTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (PVSecondTableViewCell*) inicializar:(PVListItem *) item {

    self.backgroundColor = [self.item getColorHex];

    self.textField.delegate = self; // tiene los metodos de textField
    [self.textField setBackgroundColor: [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0]]; //transparente
    [self.textField setTextColor: [UIColor whiteColor]];
    [self.textField setFont: [UIFont fontWithName:@"Aller" size:18]];
    [self.textField setText: item.titulo];
    [self.textField setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
    
    self.item = item;
    
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSString *trimmedTextField = [textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    if ([trimmedTextField  isEqual: @""]) {
        [self.superTable.items removeObjectAtIndex:[self.superTable.tableView indexPathForCell:self].row];
        
    } else {
        PVListItem* nuevo = [[PVListItem alloc] init];
        nuevo.titulo = self.textField.text;
        nuevo.color = self.item.color;
        
        if ([self.superTable.tableView indexPathForCell:self].row == 0) {
            [self.superTable.items removeObjectAtIndex:0];
            [self.superTable.items insertObject:nuevo atIndex:0];
            self.isBeingEditedForTheFirstTime = NO;
            
        } else {
            [self.superTable.items replaceObjectAtIndex:[self.superTable.tableView indexPathForCell:self].row withObject:nuevo];
        }
        
        [self.superTable guardarDatos];
    }
    
    [self desaparecerBotones];
    [self.superTable refreshTable];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    // Botones en la primera celda
    if ([self.superTable.tableView indexPathForCell:self].row == 0) {
        // Barra de botones
        self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x+20.0f, self.frame.origin.y+70.0f,self.frame.size.width-40.0f,50.0f)];
        [self.buttonView setBackgroundColor:[UIColor whiteColor]];
        [self.buttonView setAlpha:0.8f];
        self.buttonView.layer.cornerRadius = 10.0f;
        [self.superTable.view addSubview:self.buttonView];
        
        // Colores
        self.redButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+50.0f, self.frame.origin.y+75.0f,40.0f,40.0f)];
        [self.redButton setBackgroundColor: UIColorFromRGB(REDCOLORHEX)];
        [self.redButton addTarget:self action:@selector(changeToRed) forControlEvents:UIControlEventTouchUpInside];
        self.redButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.redButton];
        
        self.blueButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+110.0f, self.frame.origin.y+75.0f, 40.0f, 40.0f)];
        [self.blueButton setBackgroundColor: UIColorFromRGB(BLUECOLORHEX)];
        [self.blueButton addTarget:self action:@selector(changeToBlue) forControlEvents:UIControlEventTouchUpInside];
        self.blueButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.blueButton];
        
        self.greenButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+170.0f, self.frame.origin.y+75.0f, 40.0f, 40.0f)];
        [self.greenButton setBackgroundColor: UIColorFromRGB(GREENCOLORHEX)];
        [self.greenButton addTarget:self action:@selector(changeToGreen) forControlEvents:UIControlEventTouchUpInside];
        self.greenButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.greenButton];
        
        self.yellowButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+230.0f, self.frame.origin.y+75.0f, 40.0f, 40.0f)];
        [self.yellowButton setBackgroundColor: UIColorFromRGB(YELLOWCOLORHEX)];
        [self.yellowButton addTarget:self action:@selector(changeToYellow) forControlEvents:UIControlEventTouchUpInside];
        self.yellowButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.yellowButton];
        
    } else {
        // Barra de botones
        self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x+20.0f, self.frame.origin.y-50.0f,self.frame.size.width-40.0f,50.0f)];
        [self.buttonView setBackgroundColor:[UIColor whiteColor]];
        [self.buttonView setAlpha:0.8f];
        self.buttonView.layer.cornerRadius = 10.0f;
        [self.superTable.view addSubview:self.buttonView];
        
        // Colores
        self.redButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+50.0f, self.frame.origin.y-45.0f,40.0f,40.0f)];
        [self.redButton setBackgroundColor: UIColorFromRGB(REDCOLORHEX)];
        [self.redButton addTarget:self action:@selector(changeToRed) forControlEvents:UIControlEventTouchUpInside];
        self.redButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.redButton];
        
        self.blueButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+110.0f, self.frame.origin.y-45.0f, 40.0f, 40.0f)];
        [self.blueButton setBackgroundColor: UIColorFromRGB(BLUECOLORHEX)];
        [self.blueButton addTarget:self action:@selector(changeToBlue) forControlEvents:UIControlEventTouchUpInside];
        self.blueButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.blueButton];
        
        self.greenButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+170.0f, self.frame.origin.y-45.0f, 40.0f, 40.0f)];
        [self.greenButton setBackgroundColor: UIColorFromRGB(GREENCOLORHEX)];
        [self.greenButton addTarget:self action:@selector(changeToGreen) forControlEvents:UIControlEventTouchUpInside];
        self.greenButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.greenButton];
        
        self.yellowButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.origin.x+230.0f, self.frame.origin.y-45.0f, 40.0f, 40.0f)];
        [self.yellowButton setBackgroundColor: UIColorFromRGB(YELLOWCOLORHEX)];
        [self.yellowButton addTarget:self action:@selector(changeToYellow) forControlEvents:UIControlEventTouchUpInside];
        self.yellowButton.layer.cornerRadius = 20;
        [self.superTable.view addSubview:self.yellowButton];
    }
    
    return YES;
}

- (void)changeToRed {
    //NSInteger index = [self.superTable.tableView indexPathForCell:self].row;
    self.item.color = red;
    
    if (![self isBeingEditedForTheFirstTime]) {
        [self.superTable refreshTable];
    } else {
        [self setBackgroundColor: UIColorFromRGB(REDCOLORHEX)];
    }
}

- (void)changeToGreen {
    self.item.color = green;
    
    if (![self isBeingEditedForTheFirstTime]) {
        [self.superTable refreshTable];
    } else {
        [self setBackgroundColor: UIColorFromRGB(GREENCOLORHEX)];
    }
}

- (void)changeToYellow {
    self.item.color = yellow;
    
    if (![self isBeingEditedForTheFirstTime]) {
        [self.superTable refreshTable];
    } else {
        [self setBackgroundColor: UIColorFromRGB(YELLOWCOLORHEX)];
    }
}

- (void)changeToBlue {
    self.item.color = blue;
    
    if (![self isBeingEditedForTheFirstTime]) {
        [self.superTable refreshTable];
    } else {
        [self setBackgroundColor: UIColorFromRGB(BLUECOLORHEX)];
    }
}

-(void)desaparecerBotones {
    [self.buttonView removeFromSuperview];
    [self.redButton removeFromSuperview];
    [self.blueButton removeFromSuperview];
    [self.yellowButton removeFromSuperview];
    [self.greenButton removeFromSuperview];
}


@end
