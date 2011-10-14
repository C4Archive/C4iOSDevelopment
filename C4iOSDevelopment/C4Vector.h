//
//  C4Vector.h
//  Build
//
//  Created by Travis Kirton on 11-02-12.
//  Copyright 2011 Travis Kirton. All rights reserved.
//

#import <Accelerate/Accelerate.h>

@interface C4Vector : C4Object {
@private
	CGFloat vec3[3];
	CGFloat pVec3[3];
	CGFloat *vec;
    CGFloat pDisplacedHeading;
}

+(CGFloat)distanceBetweenA:(CGPoint)pointA andB:(CGPoint)pointB;
+(CGFloat)angleBetweenA:(CGPoint)pointA andB:(CGPoint)pointB;

+(C4Vector *)vectorWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
-(id)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
-(void)setX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
-(void)update;
-(void)add:(C4Vector *)aVec;
-(void)addScalar:(float)scalar;
-(void)divide:(C4Vector *)aVec;
-(void)divideScalar:(float)scalar;
-(void)multiply:(C4Vector *)aVec;
-(void)multiplyScalar:(float)scalar;
-(void)subtract:(C4Vector *)aVec;
-(void)subtractScalar:(float)scalar;
-(CGFloat)distance:(C4Vector *)aVec;
-(CGFloat)dot:(C4Vector *)aVec;
-(CGFloat)magnitude;
-(CGFloat)angleBetween:(C4Vector *)aVec;
-(void)cross:(C4Vector *)aVec;
-(void)normalize;
-(void)limit:(CGFloat)max;
-(CGPoint)point2D;
-(CGFloat)heading;
-(CGFloat)displacedHeading;
-(CGFloat)headingBasedOn:(CGPoint)p;
-(CGFloat)x;
-(CGFloat)y;
-(CGFloat)z;
-(void)setX:(CGFloat)newX;
-(void)setY:(CGFloat)newY;
-(void)setZ:(CGFloat)newZ;

@property (readonly) float *vec;
@end
