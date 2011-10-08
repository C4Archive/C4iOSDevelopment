//
//  C4GlobalShapeAttributes.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4GlobalShapeAttributes.h"

static C4GlobalShapeAttributes* sharedC4GlobalShapeAttributes = nil;

@interface C4GlobalShapeAttributes ()
-(void)setupShapeAttributes;
@end

@implementation C4GlobalShapeAttributes

@synthesize lineDashPhase, lineWidth, miterLimit, strokeEnd, strokeStart;
@synthesize fillRule, fillColor, lineCap, lineJoin, lineDashPattern, strokeColor;

- (id)init
{
    self = [super init];
    if (self) {
        [self setupShapeAttributes];
    }
    
    return self;
}

+(C4GlobalShapeAttributes *)sharedManager {
    if (sharedC4GlobalShapeAttributes == nil) {
        static dispatch_once_t once;
        dispatch_once(&once, ^ { sharedC4GlobalShapeAttributes = [[super allocWithZone:NULL] init]; });
        return sharedC4GlobalShapeAttributes;
        
    }
    return sharedC4GlobalShapeAttributes;
}

-(void)setupShapeAttributes {
    self.fillColor = [UIColor blackColor];
//    self.fillRule = kCAFillRuleNonZero;
//    self.lineCap = kCALineCapButt;
    self.lineDashPattern = nil;
    self.lineDashPhase = 0.0f;
//    self.lineJoin = kCALineJoinMiter;
    self.lineWidth = 2.0f;
    self.miterLimit = 10.0f;
    self.strokeColor = nil;
    self.strokeEnd = 1.0f;
    self.strokeStart = 0.0f;
}
@end
