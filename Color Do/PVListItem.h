//
//  PVListItem.h
//  Color Do
//
//  Created by Pablo Varela on 20/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ayuda.h"

@interface PVListItem : NSObject

@property (nonatomic, retain) NSString* titulo;
@property enum {blue,red,yellow,green,blueD,redD,yellowD,greenD} color;

-(UIColor*) getColorHex;

@end
