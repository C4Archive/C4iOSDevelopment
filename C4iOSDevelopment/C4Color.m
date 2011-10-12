//
//  C4Color.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Color.h"

@implementation C4Color
@synthesize uiColor, cgColor;

-(id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [self initWithUIColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
}

-(id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
    return [self initWithUIColor:[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha]];
}

-(id)initWithUIColor:(UIColor*)aColor {
    self = [super init];
    if(self) {
            self.uiColor = (UIColor *)aColor;
            cgColor = CGColorCreateCopy(uiColor.CGColor);
            CFRetain(cgColor);
    }
    return self;
}
-(id)initWithC4Color:(C4Color*)aColor {
    self = [super init];
    if(self) {
            self.uiColor = ((C4Color *)aColor).uiColor;
            cgColor = CGColorCreateCopy(uiColor.CGColor);
            CFRetain(cgColor);
    }
    return self;
}

-(id)initWithCGColor:(CGColorRef)aColor {
    self = [super init];
    if(self) {
        const CGFloat *components = CGColorGetComponents(aColor);
        self.uiColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
        cgColor = CGColorCreateCopy(aColor);
        CFRetain(cgColor);
    }
    return self;
}

+(C4Color *)colorWithWhite:(CGFloat)white{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithRed:white green:white blue:white alpha:1.0f];
    return color;
}

+(C4Color *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithRed:white green:white blue:white alpha:alpha];
    return color;
}

+(C4Color *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness {
    C4Color *color = (C4Color *)[[C4Color alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
    return color;
}

+(C4Color *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
    return color;
}

+(C4Color *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithRed:red green:green blue:blue alpha:1.0f];
    return color;
}

+(C4Color *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

+(C4Color *)colorWithColor:(id)aColor {
    C4Color *color;
    if([aColor isKindOfClass:[UIColor class]]) {
        color = [[C4Color alloc] initWithUIColor:aColor];
    } else if ([aColor isKindOfClass:[C4Color class]]){
        color = [[C4Color alloc] initWithC4Color:aColor];
    } else {
        C4Log(@"color object must be C4Color or UIColor");
        return nil;
    }
    return color;
}

+(C4Color *)colorWithUIColor:(UIColor *)uiColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:uiColor];
    return color;
}

+(C4Color *)colorWithCGColor:(CGColorRef)cgColor{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithCGColor:cgColor];
    return color;
}

+(C4Color *)blackColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor blackColor]];
    return color;
}

+(C4Color *)darkGrayColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor darkGrayColor]];
    return color;
}

+(C4Color *)lightGrayColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor lightGrayColor]];
    return color;
}

+(C4Color *)whiteColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor whiteColor]];
    return color;
}

+(C4Color *)grayColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor grayColor]];
    return color;
}

+(C4Color *)redColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor redColor]];
    return color;
}

+(C4Color *)greenColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor greenColor]];
    return color;
}

+(C4Color *)blueColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor blueColor]];
    return color;
}

+(C4Color *)cyanColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor cyanColor]];
    return color;
}

+(C4Color *)yellowColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor yellowColor]];
    return color;
}

+(C4Color *)magentaColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor magentaColor]];
    return color;
}

+(C4Color *)orangeColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor orangeColor]];
    return color;
}

+(C4Color *)purpleColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor purpleColor]];
    return color;
}

+(C4Color *)brownColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor brownColor]];
    return color;
}

+(C4Color *)clearColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor clearColor]];
    return color;
}

+(C4Color *)lightTextColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor lightTextColor]];
    return color;
}

+(C4Color *)darkTextColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor darkTextColor]];
    return color;
}

+(C4Color *)groupTableViewBackgroundColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor groupTableViewBackgroundColor]];
    return color;
}

+(C4Color *)viewFlipsideBackgroundColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor viewFlipsideBackgroundColor]];
    return color;
}

+(C4Color *)scrollViewTexturedBackgroundColor{
    C4Color *color = [[C4Color alloc] initWithUIColor:[UIColor scrollViewTexturedBackgroundColor]];
    return color;
}


-(C4Color *)colorWithAlphaComponent:(CGFloat)alpha{
    C4Color *color = [[C4Color alloc] initWithUIColor:[self.uiColor colorWithAlphaComponent:alpha]];
    return color;
}

-(void)set{
    [self.uiColor set];
}

-(void)setFill{
    [self.uiColor setFill];
}

-(void)setStroke{
    [self.uiColor setStroke];
}

-(CGColorRef)CGColor{
    return self.uiColor.CGColor;
}

-(const CGFloat *)components {
    const CGFloat *components = CGColorGetComponents([self.uiColor CGColor]);
    return components;
}

-(CGFloat)redComponent{
    const CGFloat *components = CGColorGetComponents([self.uiColor CGColor]);
    return components[0];
}

-(CGFloat)greenComponent{
    const CGFloat *components = CGColorGetComponents([self.uiColor CGColor]);
    return components[1];
}

-(CGFloat)blueComponent{
    const CGFloat *components = CGColorGetComponents([self.uiColor CGColor]);
    return components[2];
}

-(CGFloat)alphaComponent{
    const CGFloat *components = CGColorGetComponents([self.uiColor CGColor]);
    return components[3];
}

-(void)setUIColor:(UIColor *)_uiColor {
    uiColor = _uiColor;
    CFRelease(cgColor);
    cgColor = CGColorCreateCopy(uiColor.CGColor);
    CFRetain(cgColor);
}
@end
