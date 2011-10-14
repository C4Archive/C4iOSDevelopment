//
//  C4TextLayer.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-10.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4TextLayer.h"

@implementation C4TextLayer
@synthesize uiFont, c4String;

+(C4TextLayer *)layerWithString:(id)string {
    CGSize size;
    if([string isKindOfClass:[NSString class]]) {
        size = [string sizeWithFont:[C4GlobalStringAttributes sharedManager].font.uiFont];
    } else if ([string isKindOfClass:[C4String class]]) {
        size = [((C4String *)string) sizeWithFont:((C4String *)string).font];
    }
    
    return [C4TextLayer layerWithString:[C4String stringWithString:string] andRect:CGRectMake(0, 0, size.width, size.height)];
}

+(C4TextLayer *)layerWithString:(C4String *)string andRect:(CGRect)rect {
    C4TextLayer *newLayer = [[C4TextLayer alloc] init];

    newLayer.c4String = string;

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

-(void)setC4String:(C4String *)_c4String {
    C4Log(@"..");
    c4String = _c4String;
    self.font = self.c4String.font.ctFont;
    
    CGSize size = [self.c4String sizeWithFont:self.c4String.font];
    [self resizeBoundsToRect:CGRectMake(0, 0, size.width, size.height)];
    
    self.fontSize = self.c4String.font.fontSize;
    
    if(self.c4String.backgroundVisible == YES) {
        self.backgroundColor = [((C4String *)self.c4String).backgroundColor cgColor];
    }
    self.string = (__bridge NSAttributedString*)[self.c4String stringRef];
}
@end
