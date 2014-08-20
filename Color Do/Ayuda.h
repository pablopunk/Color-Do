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

#define BLUECOLORHEX 0x007AFF
#define REDCOLORHEX 0xFF3B30
#define YELLOWCOLORHEX 0xFFCC00
#define GREENCOLORHEX 0x4CD964

#define ROW_HEIGHT 70.0f

#endif
