//
//  C4Color.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-24.
//  Copyright 2011 mediart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4Object.h"

@interface C4Color : C4Object {
    @private
    UIColor *cColor;
}

+(C4Color *)colorWithWhite:(CGFloat)white;
+(C4Color *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha;
+(C4Color *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness;
+(C4Color *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
+(C4Color *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+(C4Color *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(C4Color *)colorWithColor:(id)aColor;
+(C4Color *)colorWithCGColor:(CGColorRef)cgColor;
+(C4Color *)colorWithUIColor:(UIColor *)uiColor;

+(C4Color *)blackColor;
+(C4Color *)darkGrayColor;
+(C4Color *)lightGrayColor;
+(C4Color *)whiteColor;
+(C4Color *)grayColor;
+(C4Color *)redColor;
+(C4Color *)greenColor;
+(C4Color *)blueColor;
+(C4Color *)cyanColor;
+(C4Color *)yellowColor;
+(C4Color *)magentaColor;
+(C4Color *)orangeColor;
+(C4Color *)purpleColor;
+(C4Color *)brownColor;
+(C4Color *)clearColor;

+(C4Color *)lightTextColor;
+(C4Color *)darkTextColor;
+(C4Color *)groupTableViewBackgroundColor;
+(C4Color *)viewFlipsideBackgroundColor;
+(C4Color *)scrollViewTexturedBackgroundColor;

-(C4Color *)colorWithAlphaComponent:(CGFloat)alpha;

-(id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
-(id)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;
-(id)initWithColor:(id)color;
-(id)initWithCGColor:(CGColorRef)color;
-(id)initWithUIColor:(UIColor *)color;

-(void)set;
-(void)setFill;
-(void)setStroke;

-(CGColorRef)CGcolor;
-(UIColor *)UIcolor;
-(const CGFloat *)components;
-(CGFloat)redComponent;
-(CGFloat)blueComponent;
-(CGFloat)greenComponent;
-(CGFloat)alphaComponent;

@property(readonly,retain) UIColor *cColor;
@end