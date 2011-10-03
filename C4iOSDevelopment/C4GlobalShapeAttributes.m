//
//  C4GlobalShapeAttributes.m
//  C4iOS
//
//  Created by Travis Kirton on 11-08-25.
//  Copyright 2011 mediart. All rights reserved.
//

#import "C4GlobalShapeAttributes.h"

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

+(C4GlobalShapeAttributes *)sharedClass {
    static dispatch_once_t once;
    static C4GlobalShapeAttributes *myClass;
    dispatch_once(&once, ^ { myClass = [[self alloc] init]; });
    return myClass;
}

-(void)setupShapeAttributes {
    self.fillColor = [UIColor blackColor];
    self.fillRule = kCAFillRuleNonZero;
    self.lineCap = kCALineCapButt;
    self.lineDashPattern = nil;
    self.lineDashPhase = 0.0f;
    self.lineJoin = kCALineJoinMiter;
    self.lineWidth = 2.0f;
    self.miterLimit = 10.0f;
    self.strokeColor = nil;
    self.strokeEnd = 1.0f;
    self.strokeStart = 0.0f;
}
@end
