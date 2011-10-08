//
//  C4GlobalShapeAttributes.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"

@interface C4GlobalShapeAttributes : C4Object {
    
}
#pragma mark Singleton
+(C4GlobalShapeAttributes *)sharedManager;

@property (readwrite) CGFloat lineDashPhase;
@property (readwrite) CGFloat lineWidth;
@property (readwrite) CGFloat miterLimit;
@property (readwrite) CGFloat strokeEnd;
@property (readwrite) CGFloat strokeStart;
@property (readwrite, retain) UIColor *fillColor;
@property (readwrite, retain) NSString *fillRule;
@property (readwrite, retain) NSString *lineCap;
@property (readwrite, retain) NSArray *lineDashPattern;
@property (readwrite, retain) NSString *lineJoin;
@property (readwrite, retain) UIColor *strokeColor;

@end
