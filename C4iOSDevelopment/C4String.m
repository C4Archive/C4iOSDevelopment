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
        self = [(C4String *)aString copy];
    }
    else {
        C4Log(@"%@ is not C4String or NSString",[aString class]);
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
    
    if ([aString isKindOfClass:[NSString class]]) {
        CFStringRef newString = CFStringCreateCopy(kCFAllocatorDefault, (__bridge CFStringRef)aString);
        stringToAppend = CFAttributedStringCreate(kCFAllocatorDefault, newString, attributesToAppend);
    } else if ([aString isKindOfClass:[C4String class]]) {
        stringToAppend = ((C4String *)aString).stringRef;
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
    CFAttributedStringRef attributedSubstring = CFAttributedStringCreateWithSubstring(kCFAllocatorDefault, self.stringRef, range);
    
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
    return [self substringWithRange:CFRangeMake(index, CFAttributedStringGetLength(stringRef)-index)];
}


-(C4String *)substringToIndex:(NSInteger)index{
    return [self substringWithRange:CFRangeMake(0,index)];
}

-(C4String *)stringByReplacingOccurencesOfString:(id)aString withString:(id)bString{ 
    NSString *stringToFind = [[NSString alloc] init];
    if([aString isKindOfClass:[NSString class]]) {
        stringToFind = (NSString *)aString;
    } else if ([aString isKindOfClass:[C4String class]]) {
        stringToFind = ((C4String *)aString).string;
    }

    NSString *replacementString = [[NSString alloc] init];
    if([bString isKindOfClass:[NSString class]]) {
        replacementString = (NSString *)bString;
    } else if ([bString isKindOfClass:[C4String class]]) {
        replacementString = ((C4String *)bString).string;
    }

    NSString *newString = [[NSString alloc] init];
    
    newString = [self.string stringByReplacingOccurrencesOfString:stringToFind
                                                                 withString:replacementString 
                                                          options:NSCaseInsensitiveSearch
                                                            range:NSMakeRange(0, self.string.length)];
    C4String *newC4String = [C4String stringWithString:newString];

    newC4String.font = self.font;
    
    newC4String.foregroundColor = self.foregroundColor;
    newC4String.foregroundVisible = self.foregroundVisible;
    
    newC4String.backgroundColor = self.backgroundColor;
    newC4String.backgroundVisible = self.backgroundVisible;
    
    newC4String.underlineStyle = self.underlineStyle;
    newC4String.underlineColor = self.underlineColor;
    newC4String.underlineVisible = self.underlineVisible;
    
    newC4String.strokeWidth = self.strokeWidth;
    newC4String.strokeColor = self.strokeColor;
    newC4String.strokeVisible = self.strokeVisible;
    
    newC4String.kernWidth = self.kernWidth;
    return newC4String;
}

#pragma mark Style Methods
-(void)setFont:(C4Font *)_font {
    font = _font;
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTFontAttributeName, self.font.ctFont);
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

-(void)setUnderlineColor:(C4Color *)_underlineColor {
    underlineColor = _underlineColor;
    CFAttributedStringBeginEditing(stringRef);
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTUnderlineColorAttributeName, underlineColor.cgColor);
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

-(void)setStrokeColor:(C4Color *)_strokeColor {
    strokeColor = _strokeColor;
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTStrokeColorAttributeName, strokeColor.cgColor);
    CFAttributedStringEndEditing(stringRef);
}

-(void)setForegroundColor:(C4Color *)_foregroundColor {
    foregroundColor = _foregroundColor;
    CGColorRef cgForegroundColor = CGColorCreateCopy(foregroundColor.cgColor);
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTForegroundColorAttributeName, cgForegroundColor);
    CFAttributedStringEndEditing(stringRef);
}

-(void)setForegroundVisible:(BOOL)_foregroundVisible {
    foregroundVisible = _foregroundVisible;
    CFAttributedStringBeginEditing(stringRef);
    if(foregroundVisible == YES) {
        CFAttributedStringSetAttribute(stringRef, CFRangeMake(0, self.length), kCTForegroundColorAttributeName, foregroundColor.cgColor);
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

-(NSArray *)componentsSeparatedByString:(id)aString{ 
    NSArray *components;
    if([aString isKindOfClass:[NSString class]]) {
        components = [[NSArray alloc] initWithArray:[self.string componentsSeparatedByString:(NSString *)aString]];
    } else if ([aString isKindOfClass:[C4String class]]) {
        components = [[NSArray alloc] initWithArray:[self.string componentsSeparatedByString:((C4String *)aString).string]];
    }
    return components;
}

/*
 if([aString isKindOfClass:[NSString class]]) {
 } else if ([aString isKindOfClass:[C4String class]]) {
 }
*/

-(BOOL)hasPrefix:(id)aString{ 
    if([aString isKindOfClass:[NSString class]]) {
        return [self.string hasPrefix:(NSString *)aString];
    } else if ([aString isKindOfClass:[C4String class]]) {
        return [self.string hasPrefix:((C4String *)aString).string];
    }
    return NO; 
}

-(BOOL)hasSuffix:(id)aString{ 
    if([aString isKindOfClass:[NSString class]]) {
        return [self.string hasSuffix:(NSString *)aString];
    } else if ([aString isKindOfClass:[C4String class]]) {
        return [self.string hasSuffix:((C4String *)aString).string];
    }
    return NO;
}

-(void)capitalizedString {
    CFAttributedStringRef stringToAppend;
    CFDictionaryRef attributesToAppend = CFAttributedStringGetAttributes(stringRef,0,NULL);
    
    NSString *newCapitalizedString = [self.string capitalizedString];
    CFStringRef newString = CFStringCreateCopy(kCFAllocatorDefault, (__bridge CFStringRef)newCapitalizedString);
    stringToAppend = CFAttributedStringCreate(kCFAllocatorDefault, newString, attributesToAppend);
    
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringReplaceAttributedString(stringRef, CFRangeMake(0,CFAttributedStringGetLength(stringRef)), stringToAppend);
    CFAttributedStringEndEditing(stringRef);
}

-(void)lowercaseString {
    CFAttributedStringRef stringToAppend;
    CFDictionaryRef attributesToAppend = CFAttributedStringGetAttributes(stringRef,0,NULL);
    
    NSString *newLowercaseString = [self.string lowercaseString];
    CFStringRef newString = CFStringCreateCopy(kCFAllocatorDefault, (__bridge CFStringRef)newLowercaseString);
    stringToAppend = CFAttributedStringCreate(kCFAllocatorDefault, newString, attributesToAppend);
    
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringReplaceAttributedString(stringRef, CFRangeMake(0,CFAttributedStringGetLength(stringRef)), stringToAppend);
    CFAttributedStringEndEditing(stringRef);
}

-(void)uppercaseString {
    CFAttributedStringRef stringToAppend;
    CFDictionaryRef attributesToAppend = CFAttributedStringGetAttributes(stringRef,0,NULL);
    
    NSString *newUppercaseString = [self.string uppercaseString];
    CFStringRef newString = CFStringCreateCopy(kCFAllocatorDefault, (__bridge CFStringRef)newUppercaseString);
    stringToAppend = CFAttributedStringCreate(kCFAllocatorDefault, newString, attributesToAppend);
    
    CFAttributedStringBeginEditing(stringRef);
    CFAttributedStringReplaceAttributedString(stringRef, CFRangeMake(0,CFAttributedStringGetLength(stringRef)), stringToAppend);
    CFAttributedStringEndEditing(stringRef);
}

-(NSInteger) length{
    return CFAttributedStringGetLength(stringRef);
}

-(double)doubleValue{ return 0; }
-(float)floatValue{ return 0.0f; }
-(NSInteger)intValue{ return 0; }
-(NSInteger)integerValue{ return 0; }
-(BOOL)boolValue{ return NO; }

+(NSString *)nsStringFromObject:(id)object{ 
     if([object isKindOfClass:[NSString class]]) {
         return (NSString *)object;
     } else if ([object isKindOfClass:[C4String class]]) {
         return ((C4String *)object).string;
     }
    return nil;
}

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

-(CGSize)sizeWithFont:(C4Font *)_font {
    return [self.string sizeWithFont:_font.uiFont];
}

-(void)setString:(CFMutableAttributedStringRef)str {
    stringRef = str;
}
@end