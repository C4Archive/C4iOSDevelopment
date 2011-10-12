//
//  C4GlobalStringAttributes.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-09.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"
#import <CoreText/CTStringAttributes.h>

@interface C4GlobalStringAttributes : C4Object 

+(C4GlobalStringAttributes *)sharedManager;

@property (readwrite, strong, nonatomic) UIFont *font;
@property (readwrite, strong, nonatomic) UIColor *underlineColor, *strokeColor, *foregroundColor, *backgroundColor;
@property (readwrite, nonatomic) CGFloat strokeWidth, kernWidth;
@property (readwrite, nonatomic) int32_t underlineStyle;
@property (readwrite, nonatomic) BOOL foregroundVisible, backgroundVisible, strokeVisible, underlineVisible;
@end
