//
//  C4TextLayer.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-10.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "C4Foundation.h"
#import "C4String.h"

@interface C4TextLayer : CATextLayer

+(C4TextLayer *)layerWithString:(id)string;
//+(C4TextLayer *)layerWithC4String:(C4String *)string andRect:(CGRect)rect;
+(C4TextLayer *)layerWithString:(C4String *)string andRect:(CGRect)rect;

-(void)resizeBounds;
-(void)resizeBoundsToRect:(CGRect)rect;
-(void)fitTextToWidth:(CGFloat)width;
-(void)fitTextToWidth:(CGFloat)width withMaximumFontSize:(CGFloat)maxFontSize;

@property (readwrite,retain,nonatomic) UIFont* uiFont;
@end