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
    self.backgroundColor = item.getColorHex;
    self.textField.delegate = self; // tiene los metodos de textField
    [self.textField setBackgroundColor: [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0]]; //transparente
    [self.textField setTextColor: [UIColor whiteColor]];
    [self.textField setFont: [UIFont fontWithName:@"Aller" size:18]];
    [self.textField setText: item.titulo];
    [self.textField setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
    
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    PVListItem* nuevo = [[PVListItem alloc] init];
    nuevo.titulo = self.textField.text;
    
    // añadir a los datos !!!!!!!!!!!!!!!!!!!
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Cuando se empieza a editar
    return YES;
}

- (void)changeToRed {
    
}

- (void)changeToGreen {
    
}

- (void)changeToYellow {
    
}

- (void)changeToBlue {
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *trimmedTextField = [textField.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedTextField  isEqual: @""]) {
        
        [self.superTable.items removeObjectAtIndex:[self.superTable.tableView indexPathForCell:self].row];
        [self.superTable refreshTable];
        
    }
}


@end
