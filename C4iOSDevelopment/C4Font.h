//
//  C4Font.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-11.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"
#import <CoreText/CTFont.h>
@class C4String;

@interface C4Font : C4Object
-(id)initWithFontName:(id)fontName size:(CGFloat)fontSize;
-(id)initWithUIFont:(UIFont *)font;

+(C4Font *)fontWithName:(id)fontName size:(CGFloat)fontSize;
+(C4Font *)fontWithUIFont:(UIFont *)font;

+(NSArray *)familyNames;
+(NSArray *)fontNamesForFamilyName:(NSString *)familyName;

+(C4Font *)systemFontOfSize:(CGFloat)fontSize;
+(C4Font *)boldSystemFontOfSize:(CGFloat)fontSize;
+(C4Font *)italicSystemFontOfSize:(CGFloat)fontSize;
-(C4Font *)fontWithSize:(CGFloat)fontSize;

-(C4String *)familyName;
-(C4String *)fontName;
-(CGFloat)fontSize;
-(CGFloat)ascender;
-(CGFloat)descender;
-(CGFloat)capHeight;
-(CGFloat)xHeight;
-(CGFloat)lineHeight;

-(void)setFontSize:(CGFloat)fontSize;

@property (readwrite, strong, nonatomic) UIFont *uiFont;
@property (readonly) CTFontRef ctFont;
@end