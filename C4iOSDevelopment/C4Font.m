//
//  C4Font.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-11.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Font.h"

@implementation C4Font
@synthesize uiFont, ctFont;

-(id)initWithFontName:(id)fontName size:(CGFloat)fontSize {
    self = [super init];
    if (self) {
        if([fontName isKindOfClass:[NSString class]]) {
            self.uiFont = [UIFont fontWithName:fontName size:fontSize];
        } else if([fontName isKindOfClass:[C4String class]]) {
            self.uiFont = [UIFont fontWithName:((C4String *)fontName).string size:fontSize];
        }
    }
    return self;
}

-(id)initWithUIFont:(UIFont *)font {
    self = [super init];
    if (self) {
        self.uiFont = font;
    }
    return self;
}

+ (C4Font *)fontWithName:(id)fontName size:(CGFloat)fontSize {
    return [[C4Font alloc] initWithFontName:fontName size:fontSize];
}

+ (C4Font *)fontWithUIFont:(UIFont *)font {
    return [[C4Font alloc] initWithUIFont:font];
}

+ (NSArray *)familyNames {
    return [UIFont familyNames];
}

+ (NSArray *)fontNamesForFamilyName:(NSString *)familyName {
    return [UIFont fontNamesForFamilyName:familyName];
}

+ (C4Font *)systemFontOfSize:(CGFloat)fontSize {
    return [C4Font fontWithUIFont:[UIFont systemFontOfSize:fontSize]];
}

+ (C4Font *)boldSystemFontOfSize:(CGFloat)fontSize {
    return [C4Font fontWithUIFont:[UIFont boldSystemFontOfSize:fontSize]];
}

+ (C4Font *)italicSystemFontOfSize:(CGFloat)fontSize {
    return [C4Font fontWithUIFont:[UIFont italicSystemFontOfSize:fontSize]];
}

- (C4Font *)fontWithSize:(CGFloat)fontSize {
    return [C4Font fontWithUIFont:[self.uiFont fontWithSize:fontSize]];
}

-(C4String *)familyName {
    return [C4String stringWithFormat:@"%@",[self.uiFont familyName]];
}

-(C4String *)fontName {
    return [C4String stringWithFormat:@"%@",[self.uiFont fontName]];
}

-(void)setFontSize:(CGFloat)fontSize {
    self.uiFont = [self.uiFont fontWithSize:fontSize];
}

-(CGFloat)fontSize {
    return [self.uiFont pointSize];
}

-(CGFloat)ascender {
    return [self.uiFont ascender];
}

-(CGFloat)descender {
    return [self.uiFont descender];
}

-(CGFloat)capHeight {
    return [self.uiFont capHeight];
}

-(CGFloat)xHeight {
    return [self.uiFont xHeight];
}

-(CGFloat)lineHeight {
    return [self.uiFont lineHeight];
}

-(void)setUiFont:(UIFont *)_uiFont {
    uiFont = _uiFont;
    ctFont = CTFontCreateWithName((__bridge_retained CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
}
@end
