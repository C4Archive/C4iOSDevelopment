//
//  C4TextLayer.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-10.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4TextLayer.h"

@implementation C4TextLayer
@synthesize uiFont;

+(C4TextLayer *)layerWithString:(NSString *)string {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65.0f];    
    CGSize size = [string sizeWithFont:font];
    
    return [C4TextLayer layerWithString:string andRect:CGRectMake(0, 0, size.width, size.height)];
}

+(C4TextLayer *)layerWithC4String:(C4String *)string andRect:(CGRect)rect {
    C4TextLayer *newLayer = [[C4TextLayer alloc] init];

    UIFont *font = string.font;
    CGSize size = [[string string] sizeWithFont:font];
    [newLayer resizeBoundsToRect:CGRectMake(0, 0, size.width, size.height)];
        
    newLayer.fontSize = font.pointSize;
    newLayer.anchorPoint = CGPointZero;

    if(string.backgroundVisible == YES) 
        newLayer.backgroundColor = string.backgroundColor.CGColor;

    newLayer.string = (__bridge NSAttributedString*)[string stringRef];

    return newLayer;
}

+(C4TextLayer *)layerWithString:(NSString *)string andRect:(CGRect)rect {
    C4TextLayer *newLayer = [[C4TextLayer alloc] init];
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:65.0f];    
    newLayer.uiFont = font;
    newLayer.wrapped = YES;
    newLayer.bounds = rect;
    newLayer.anchorPoint = CGPointMake(0, 0);
    newLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    newLayer.font =  CTFontCreateWithName((__bridge_retained CFStringRef)font.fontName, 0.0f, NULL);
    newLayer.fontSize = font.pointSize;
    
    /* DOING THE FOLLOWING WITH CORE TEXT BECAUSE UIFONTS CRASH WHEN USING NSMUTABLEDICTIONARY OBJECTS */
    
    /* TO DO 
     Need to make sure that the uiFont stays synced with what we create in the dictionary below when we modify the string 
     */
    CFMutableDictionaryRef dict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, NULL, NULL);
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)@"HelveticaNeue-UltraLight", 65.0f, NULL);
    CFDictionaryAddValue(dict, kCTFontAttributeName, ctFont);
    
    int32_t underlineStyle = kCTUnderlineStyleSingle|kCTUnderlinePatternSolid;
    CFDictionaryAddValue(dict, kCTUnderlineStyleAttributeName, CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &underlineStyle));
    
    const CGFloat components[4] = {0.96f,0.96f,0.96f,1.0f};
    CGColorRef underlineColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
    CFDictionaryAddValue(dict, kCTUnderlineColorAttributeName, underlineColor);
    
    CFAttributedStringRef attrstr = CFAttributedStringCreate(kCFAllocatorDefault, (__bridge CFStringRef)string, dict);
    
    newLayer.string = (__bridge NSAttributedString *)attrstr;
    
    return newLayer;
}

-(void)resizeBounds {
    CGSize size = [(NSString*)self.string sizeWithFont:self.uiFont];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

-(void)resizeBoundsToRect:(CGRect)rect {
    self.bounds = rect;
}

-(void)fitTextToWidth:(CGFloat)width {
    [self fitTextToWidth:width withMaximumFontSize:1000.0f];
}

-(void)fitTextToWidth:(CGFloat)width withMaximumFontSize:(CGFloat)maxFontSize {
    NSString *fontName = (__bridge NSString *)CTFontCopyName(self.font, kCTFontPostScriptNameKey);
    UIFont *font = [UIFont fontWithName:fontName size:maxFontSize];
    CGFloat variableFontSize;
    CGSize size = [(NSString *)self.string sizeWithFont:font minFontSize:6.0f actualFontSize:&variableFontSize forWidth:width lineBreakMode:UILineBreakModeTailTruncation];
    self.fontSize = variableFontSize;
    self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, size.width, size.height);
}

-(void)setUiFont:(UIFont *)newFont {
    uiFont = newFont;
    self.font =  CTFontCreateWithName((__bridge_retained CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
    self.fontSize = newFont.pointSize;
}
@end
