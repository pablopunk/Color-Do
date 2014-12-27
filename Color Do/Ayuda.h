//
//  Ayuda.h
//  Color Do
//
//  Created by Pablo Varela on 20/08/14.
//  Copyright (c) 2014 Pablo Varela. All rights reserved.
//

#ifndef Color_Do_Ayuda_h
#define Color_Do_Ayuda_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BLUECOLORHEX 0x1d94f0
#define REDCOLORHEX 0xFF5E3A
#define YELLOWCOLORHEX 0xFFDB4C
#define GREENCOLORHEX 0x4CD964

#define ROW_HEIGHT 70.0f

#endif
