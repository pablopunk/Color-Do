//
//  PVListItem.m
//  Color Do
//
//  Created by Pablo Varela on 20/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import "PVListItem.h"

@implementation PVListItem

-(UIColor*) getColorHex {
    if (self.color == blue) {
        return UIColorFromRGB(BLUECOLORHEX);
    }
    
    else if (self.color == red) {
        return UIColorFromRGB(REDCOLORHEX);
    }
    
    else if (self.color == yellow) {
        return UIColorFromRGB(YELLOWCOLORHEX);
    }
    
    else if (self.color == green) {
        return UIColorFromRGB(GREENCOLORHEX);
    }
    
    else if (self.color == blueD) {
        return [self darkerColorForColor:UIColorFromRGB(BLUECOLORHEX)];
    }
    
    else if (self.color == redD) {
        return [self darkerColorForColor:UIColorFromRGB(REDCOLORHEX)];
    }
    
    else if (self.color == yellowD) {
        return [self darkerColorForColor:UIColorFromRGB(YELLOWCOLORHEX)];
    }
    
    else if (self.color == greenD) {
        return [self darkerColorForColor:UIColorFromRGB(GREENCOLORHEX)];
    }
    
    return nil;
}

// Get darker color
- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.1, 0.0)
                               green:MAX(g - 0.1, 0.0)
                                blue:MAX(b - 0.1, 0.0)
                               alpha:a];
    return nil;
}

// Metodos para compresion a NSUserDefaults
- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:[self titulo] forKey:@"titulo"];
    [coder encodeObject:[NSNumber numberWithInt:self.color] forKey:@"color"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        self.titulo = [coder decodeObjectForKey:@"titulo"];
        self.color = [[coder decodeObjectForKey:@"color"] intValue];
    }
    return self;
}

@end
