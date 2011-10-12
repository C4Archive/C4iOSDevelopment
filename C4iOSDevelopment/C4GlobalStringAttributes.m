//
//  C4GlobalStringAttributes.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-09.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4GlobalStringAttributes.h"
static C4GlobalStringAttributes *sharedC4GlobalStringAttributes = nil;

@implementation C4GlobalStringAttributes
@synthesize kernWidth,underlineVisible,backgroundVisible,backgroundColor,foregroundVisible,foregroundColor,font,timestamp,strokeColor,strokeWidth,strokeVisible,underlineColor,underlineStyle;

#pragma mark Singleton

-(id) init
{
    if((self = [super init]))
    {
        self.font = [C4Font systemFontOfSize:16.0f];
        
        self.foregroundColor = [C4Color blueColor];
        self.foregroundVisible = YES;
        
        self.backgroundColor = [C4Color clearColor];
        self.backgroundVisible = NO;
        
        self.underlineStyle = kCTUnderlineStyleSingle | kCTUnderlinePatternSolid;
        self.underlineColor = [C4Color blackColor];
        self.underlineVisible = NO;
        
        self.strokeWidth = 0.0f;
        self.strokeColor = [C4Color blackColor];
        self.strokeVisible = NO;
        
        self.kernWidth = 0.0f;
    }
    
    return self;
}

+ (C4GlobalStringAttributes*)sharedManager
{
    if (sharedC4GlobalStringAttributes == nil) {
        static dispatch_once_t once;
        dispatch_once(&once, ^ { sharedC4GlobalStringAttributes = [[super allocWithZone:NULL] init]; 
        });
        return sharedC4GlobalStringAttributes;
    }
    return sharedC4GlobalStringAttributes;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedManager];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
@end
