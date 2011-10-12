//
//  C4String.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-10.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4String.h"

@implementation C4String
@synthesize font, backgroundColor, backgroundVisible, foregroundColor, foregroundVisible, kernWidth, strokeColor, strokeWidth, strokeVisible, underlineColor, underlineStyle, underlineVisible;

#pragma mark Initialization Methods
-(id)initWithString:(id)aString{
    if(!(self = [super init])) {
        return nil;
    }
    if([aString isKindOfClass:[NSString class]]) {
        stringRef = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);        
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:aString];
        
        CFAttributedStringBeginEditing(stringRef);
        [(__bridge NSMutableAttributedString *)stringRef appendAttributedString:str];
        CFAttributedStringEndEditing(stringRef);
        
        self.font = [C4GlobalStringAttributes sharedManager].font;
        
        self.foregroundColor = [C4GlobalStringAttributes sharedManager].foregroundColor ;
        self.foregroundVisible = [C4GlobalStringAttributes sharedManager].foregroundVisible;
        
        self.backgroundColor = [C4GlobalStringAttributes sharedManager].backgroundColor;
        self.backgroundVisible = [C4GlobalStringAttributes sharedManager].backgroundVisible;
        
        self.underlineStyle = [C4GlobalStringAttributes sharedManager].underlineStyle;
        self.underlineColor = [C4GlobalStringAttributes sharedManager].underlineColor;
        self.underlineVisible = [C4GlobalStringAttributes sharedManager].underlineVisible;
        
        self.strokeWidth = [C4GlobalStringAttributes sharedManager].strokeWidth;
        self.strokeColor = [C4GlobalStringAttributes sharedManager].strokeColor;
        self.strokeVisible = [C4GlobalStringAttributes sharedManager].strokeVisible;
        
        self.kernWidth = [C4GlobalStringAttributes sharedManager].kernWidth;
    }
    else if ([aString isKindOfClass:[C4String class]]) {
        CFAttributedStringBeginEditing(stringRef);
        stringRef = CFAttributedStringCreateMutableCopy(kCFAllocatorDefault, 0, [(C4String *)aString stringRef]);
        CFAttributedStringEndEditing(stringRef);
        
        self.font = ((C4String *)aString).font;
    }
    else {
        C4Log(@"Type is not C4String or NSString");
        return nil;
    }
        
    return self;
}

-(id)initWithFormat:(NSString *)aFormatString, ...{
	NSString *finalString;
    
	va_list args;
	va_start (args, aFormatString);
    finalString = [[NSString alloc] initWithFormat:aFormatString arguments:args];
	va_end (args);
	
	return [self initWithString:finalString];
}

+(C4String *)stringWithString:(id)aString{ 
    return [[C4String alloc] initWithString:aString]; 
}

+(C4String *)stringWithFormat:(NSString *)aFormatString, ...{ 
    return [[C4String alloc] initWithFormat:aFormatString]; 
}

#pragma mark String Manipulation Methods
-(void)appendString:(id)aString {
    CFAttributedStringRef stringToAppend;
    CFDictionaryRef attributesToAppend = CFAttributedStringGetAttributes(stringRef,0,NULL);
    
    if ([aString class] == [C4String class]) {
        stringToAppend = ((C4String *)aString).stringRef;
    } else {
        CFStringRef newString = CFStringCreateCopy(kCFAllocatorDefault, (__bridge CFStringRef)aString);
        stringToAppend = CFAttributedStringCreate(kCFAllocatorDefault, newString, attributesToAppend);
    }
    
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringReplaceAttributedString(stringRef, CFRangeMake(CFAttributedStringGetLength(stringRef), 0), stringToAppend);
    CFAttributedStringEndEditing(stringRef);
}

-(C4String *)stringByAppendingString:(id)aString{
    C4String *newString = [self copy];
    [newString appendString:aString];
	return newString;
} 

-(C4String *)stringByAppendingFormat:(NSString *)aFormatString, ...{
    
    NSString *formattedString;
    
	va_list args;
	va_start (args, aFormatString);
    formattedString = [[NSString alloc] initWithFormat:aFormatString arguments:args];
	va_end (args);
	
    return [self stringByAppendingString:formattedString];
}

-(void)trimStringToRange:(CFRange)range {
    CFAttributedStringRef attributedSubstring = CFAttributedStringCreateWithSubstring(kCFAllocatorDefault, stringRef, range);
    
    CFAttributedStringBeginEditing(stringRef);    
        CFAttributedStringReplaceAttributedString(stringRef, CFRangeMake(0, CFAttributedStringGetLength(stringRef)), (CFAttributedStringRef)attributedSubstring);
    CFAttributedStringEndEditing(stringRef);
}

-(C4String *)substringWithRange:(CFRange)range{ 
    C4String *newString = [self copy];
    [newString trimStringToRange:range];
    return newString; 
}

-(C4String *)substringFromIndex:(NSInteger)index{ 
    return [self substringWithRange:CFRangeMake(index, CFAttributedStringGetLength(stringRef))];
}


-(C4String *)substringToIndex:(NSInteger)index{
    return [self substringWithRange:CFRangeMake(0,index)];
}

-(C4String *)stringByReplacingOccurencesOfString:(id)aString withString:(id)bString{ 
    return nil; 
}

#pragma mark Style Methods
-(void)setFont:(UIFont *)_font {
    font = _font;
    CTFontRef ctFont = CTFontCreateWithName((__bridge_retained CFStringRef)font.fontName, font.pointSize, NULL);
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTFontAttributeName, ctFont);
    CFAttributedStringEndEditing(stringRef);
}

-(void)setUnderlineStyle:(int32_t)_underlineStyle {
    underlineStyle = _underlineStyle;
    underlineStyleRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &underlineStyle);
}

-(void)setUnderlineVisible:(BOOL)_underlineVisible {
    underlineVisible = _underlineVisible;
    
    CFAttributedStringBeginEditing(stringRef);
        if(underlineVisible == YES) {
            CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTUnderlineStyleAttributeName, underlineStyleRef);
        } else {
            int32_t _underlineStyle = kCTUnderlineStyleNone;
            CFNumberRef underlineStyleNone = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &_underlineStyle);
            CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTUnderlineStyleAttributeName, underlineStyleNone);
        }
    CFAttributedStringEndEditing(stringRef);
}

-(void)setUnderlineColor:(UIColor *)_underlineColor {
    underlineColor = _underlineColor;
    CFAttributedStringBeginEditing(stringRef);
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTUnderlineColorAttributeName, underlineColor.CGColor);
    CFAttributedStringEndEditing(stringRef);
}

-(void)setStrokeWidth:(CGFloat)_strokeWidth {
    strokeWidth = _strokeWidth;
    strokeWidthRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &strokeWidth);
    CFAttributedStringBeginEditing(stringRef);
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTStrokeWidthAttributeName, strokeWidthRef);
    CFAttributedStringEndEditing(stringRef);
}

-(void)setStrokeVisible:(BOOL)_strokeVisible {
    strokeVisible = _strokeVisible;
    
    CFAttributedStringBeginEditing(stringRef);
    if(strokeVisible == YES) {
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTStrokeWidthAttributeName, strokeWidthRef);
    } else {
        CGFloat _strokeWidth = 0.0f;
        CFNumberRef strokeWidthNone = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &_strokeWidth);
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length),kCTStrokeWidthAttributeName, strokeWidthNone);
    }
    CFAttributedStringEndEditing(stringRef);
}

-(void)setStrokeColor:(UIColor *)_strokeColor {
    strokeColor = _strokeColor;
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTStrokeColorAttributeName, strokeColor.CGColor);
    CFAttributedStringEndEditing(stringRef);
}

-(void)setForegroundColor:(UIColor *)_foregroundColor {
    foregroundColor = _foregroundColor;
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTForegroundColorAttributeName, foregroundColor.CGColor);
    CFAttributedStringEndEditing(stringRef);
}

-(void)setForegroundVisible:(BOOL)_foregroundVisible {
    foregroundVisible = _foregroundVisible;
    CFAttributedStringBeginEditing(stringRef);
    if(foregroundVisible == YES) {
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTForegroundColorAttributeName, foregroundColor.CGColor);
    } else {
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTForegroundColorAttributeName, [UIColor clearColor].CGColor);
    }
    CFAttributedStringEndEditing(stringRef);
}

-(void)setKernWidth:(CGFloat)_kernWidth {
    kernWidth = _kernWidth;
    kernWidthRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberCGFloatType, &kernWidth);
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTKernAttributeName, kernWidthRef);
    CFAttributedStringEndEditing(stringRef);
}

-(NSArray *)componentsSeparatedByString:(id)aString{ return nil; }

-(BOOL)hasPrefix:(id)aString{ return NO; }
-(BOOL)hasSuffix:(id)aString{ return NO; }
-(void)capitalizedString{}
-(void)lowercaseString{}
-(void)uppercaseString{}

-(NSInteger) length{
    return CFAttributedStringGetLength(stringRef);
}

-(double)doubleValue{ return 0; }
-(float)floatValue{ return 0.0f; }
-(NSInteger)intValue{ return 0; }
-(NSInteger)integerValue{ return 0; }
-(BOOL)boolValue{ return NO; }

-(void)font:(id)font{}

-(void)foregroundColor:(id)color{}
-(void)strikethroughColor:(id)color{}
-(void)strokeColor:(id)color{}
-(void)underlineColor:(id)color{}

-(void)strokeWidth:(CGFloat)width{}
-(void)underlineStyle:(int32_t)style{}
-(void)strikethroughStyle:(int32_t)style{}
-(void)baselineOffset:(CGFloat)offset{}
-(void)kern:(CGFloat)kern{}
-(void)ligatureStyle:(int32_t)style{}

+(C4String *)globalAttributes{ return nil; }

+(NSString *)nsStringFromObject:(id)object{ return nil; }

-(NSString *)string {
    return (__bridge NSString *)[self cfString];
}

-(CFStringRef)cfString {
    return CFAttributedStringGetString(stringRef);
}

-(CFMutableAttributedStringRef)stringRef {
    return stringRef;
}

-(C4String *)copyWithZone:(NSZone *)zone {
    C4String *copiedString = [[C4String alloc] initWithString:self.string];
    copiedString.font = self.font;
    
    copiedString.foregroundColor = self.foregroundColor;
    copiedString.foregroundVisible = self.foregroundVisible;
    
    copiedString.backgroundColor = self.backgroundColor;
    copiedString.backgroundVisible = self.backgroundVisible;
    
    copiedString.underlineStyle = self.underlineStyle;
    copiedString.underlineColor = self.underlineColor;
    copiedString.underlineVisible = self.underlineVisible;
    
    copiedString.strokeWidth = self.strokeWidth;
    copiedString.strokeColor = self.strokeColor;
    copiedString.strokeVisible = self.strokeVisible;
    
    copiedString.kernWidth = self.kernWidth;
    return copiedString;
}

-(void)setString:(CFMutableAttributedStringRef)str {
    C4Log(@"hi %d", self.length);
    stringRef = str;
    C4Log(@"hi %d", self.length);
}
@end


const CFStringRef kCTLigatureAttributeName;
const CFStringRef kCTParagraphStyleAttributeName;
const CFStringRef kCTSuperscriptAttributeName;