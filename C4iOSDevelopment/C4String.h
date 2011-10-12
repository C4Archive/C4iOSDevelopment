//
//  C4String.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-10.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"
@class C4Font;

#define NOLIGATURES 0
#define BASICLIGATURES 1
#define ALLLIGATURES 2

@interface C4String : C4Object {
@private 
    CFMutableAttributedStringRef stringRef;
    CFNumberRef underlineStyleRef, strokeWidthRef, kernWidthRef;
}

-(id)initWithString:(id)aString;
-(id)initWithFormat:(NSString *)aFormatString, ...;
-(void)appendString:(id)aString;
-(C4String *)stringByAppendingString:(id)aString;
-(C4String *)stringByAppendingFormat:(NSString *)aFormatString, ...;
-(C4String *)substringWithRange:(CFRange)range;
-(C4String *)substringFromIndex:(NSInteger)index;
-(C4String *)substringToIndex:(NSInteger)index;
-(C4String *)stringByReplacingOccurencesOfString:(id)aString withString:(id)bString;
+(C4String *)stringWithString:(id)aString;
+(C4String *)stringWithFormat:(NSString *)aFormatString, ...;
-(NSArray *)componentsSeparatedByString:(id)aString;
-(void)trimStringToRange:(CFRange)range;

-(BOOL)hasPrefix:(id)aString;
-(BOOL)hasSuffix:(id)aString;
-(void)capitalizedString;
-(void)lowercaseString;
-(void)uppercaseString;

-(NSInteger) length;

-(double)doubleValue;
-(float)floatValue;
-(NSInteger)intValue;
-(NSInteger)integerValue;
-(BOOL)boolValue;

+(NSString *)nsStringFromObject:(id)object;

-(NSString *)string;
-(CFStringRef)cfString;
-(CFMutableAttributedStringRef)stringRef;

-(CGSize)sizeWithFont:(C4Font *)_font;

@property (readwrite, strong, nonatomic) C4Font *font;
@property (readwrite, strong, nonatomic) C4Color *underlineColor, *strokeColor, *foregroundColor, *backgroundColor;
@property (readwrite, nonatomic) CGFloat strokeWidth, kernWidth;
@property (readwrite, nonatomic) int32_t underlineStyle;
@property (readwrite, nonatomic) BOOL foregroundVisible, backgroundVisible, strokeVisible, underlineVisible;
@end

@interface C4String (private)
-(void)setString:(CFMutableAttributedStringRef)str;
@end