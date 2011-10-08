//
//  C4Color.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Color.h"

@implementation C4Color
@synthesize cColor = _cColor;

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
        color = [C4Color colorWithUIColor:(UIColor *)aColor];
    } else if ([aColor isKindOfClass:[C4Color class]]) {
        color = [C4Color colorWithUIColor:[aColor UIcolor]];
    } else {
        C4Log(@"color object must be C4Color or UIColor");
        return nil;
    }
    return color;
}

+(C4Color *)colorWithUIColor:(UIColor *)uiColor{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithUIColor:uiColor];
    return color;
}

+(C4Color *)colorWithCGColor:(CGColorRef)cgColor{
    C4Color *color = (C4Color *)[[C4Color alloc] initWithCGColor:cgColor];
    return color;
}

+(C4Color *)blackColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor blackColor]];
    return color;
}

+(C4Color *)darkGrayColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor darkGrayColor]];
    return color;
}

+(C4Color *)lightGrayColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor lightGrayColor]];
    return color;
}

+(C4Color *)whiteColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor whiteColor]];
    return color;
}

+(C4Color *)grayColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor grayColor]];
    return color;
}

+(C4Color *)redColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor redColor]];
    return color;
}

+(C4Color *)greenColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor greenColor]];
    return color;
}

+(C4Color *)blueColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor blueColor]];
    return color;
}

+(C4Color *)cyanColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor cyanColor]];
    return color;
}

+(C4Color *)yellowColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor yellowColor]];
    return color;
}

+(C4Color *)magentaColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor magentaColor]];
    return color;
}

+(C4Color *)orangeColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor orangeColor]];
    return color;
}

+(C4Color *)purpleColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor purpleColor]];
    return color;
}

+(C4Color *)brownColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor brownColor]];
    return color;
}

+(C4Color *)clearColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor clearColor]];
    return color;
}

+(C4Color *)lightTextColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor lightTextColor]];
    return color;
}

+(C4Color *)darkTextColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor darkTextColor]];
    return color;
}

+(C4Color *)groupTableViewBackgroundColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor groupTableViewBackgroundColor]];
    return color;
}

+(C4Color *)viewFlipsideBackgroundColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor viewFlipsideBackgroundColor]];
    return color;
}

+(C4Color *)scrollViewTexturedBackgroundColor{
    C4Color *color = [C4Color colorWithUIColor:[UIColor scrollViewTexturedBackgroundColor]];
    return color;
}


-(C4Color *)colorWithAlphaComponent:(CGFloat)alpha{
    C4Color *color = [C4Color colorWithUIColor:[self.cColor colorWithAlphaComponent:alpha]];
    return color;
}

-(id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    self = [super init];
    if(self) {
        self.cColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    return self;
}

-(id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(id)initWithColor:(id)aColor {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(id)initWithCGColor:(CGColorRef)cgColor {
    self = [super init];
    if(self) {
        
    }
    return self;
}

-(id)initWithUIColor:(UIColor *)uiColor {
    self = [super init];
    if(self) {
        
    }
    return self;
}


-(void)set{
    [self.cColor set];
}

-(void)setFill{
    [self.cColor setFill];
}

-(void)setStroke{
    [self.cColor setStroke];
}

-(CGColorRef)CGcolor{
    return [self.cColor CGColor];
}

-(UIColor *)UIcolor{
    return self.cColor;
}

-(const CGFloat *)components {
    const CGFloat *components = CGColorGetComponents([self.cColor CGColor]);
    return components;
}

-(CGFloat)redComponent{
    const CGFloat *components = CGColorGetComponents([self.cColor CGColor]);
    return components[0];
}

-(CGFloat)greenComponent{
    const CGFloat *components = CGColorGetComponents([self.cColor CGColor]);
    return components[1];
}

-(CGFloat)blueComponent{
    const CGFloat *components = CGColorGetComponents([self.cColor CGColor]);
    return components[2];
}

-(CGFloat)alphaComponent{
    const CGFloat *components = CGColorGetComponents([self.cColor CGColor]);
    return components[3];
}
@end
