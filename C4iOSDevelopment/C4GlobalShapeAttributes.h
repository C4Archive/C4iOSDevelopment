//
//  C4GlobalShapeAttributes.h
//  C4iOS
//
//  Created by Travis Kirton on 11-08-25.
//  Copyright 2011 mediart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C4GlobalShapeAttributes : NSObject {
}

+(C4GlobalShapeAttributes *)sharedClass;

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
