//
//  C4GlobalStringAttributes.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-09.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"
@class C4Color;
@class C4Font;

@interface C4GlobalStringAttributes : C4Object 

+(C4GlobalStringAttributes *)sharedManager;

@property (readwrite, strong, nonatomic) C4Font *font;
@property (readwrite, strong, nonatomic) C4Color *underlineColor, *strokeColor, *foregroundColor, *backgroundColor;
@property (readwrite, nonatomic) CGFloat strokeWidth, kernWidth;
@property (readwrite, nonatomic) int32_t underlineStyle;
@property (readwrite, nonatomic) BOOL foregroundVisible, backgroundVisible, strokeVisible, underlineVisible;
@end
