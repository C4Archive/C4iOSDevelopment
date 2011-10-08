//
//  C4Shape.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Layer.h"
#import "C4GlobalShapeAttributes.h"

@interface C4Shape : C4Layer {
@private
    BOOL shouldDrawShapeLayers;
    NSMutableArray *shapeArray;
}

+(C4Shape *)rectAt:(CGPoint)origin size:(CGSize)size;
+(C4Shape *)circleAt:(CGPoint)origin radius:(CGFloat)radius;
+(C4Shape *)ellipseAt:(CGPoint)origin size:(CGSize)size;
+(C4Shape *)lineFrom:(CGPoint)origin to:(CGPoint)end;
+(C4Shape *)triangleFrom:(CGPoint)pointA to:(CGPoint)pointB to:(CGPoint)pointC;
+(C4Shape *)polygonWith:(CGPoint *)points;
+(C4Shape *)pointAt:(CGPoint)origin;
+(C4Shape *)arcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
+(C4Shape *)pieSliceWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

+(void)setLineDashPhase:(CGFloat)lineDashPhase;
+(void)setLineWidth:(CGFloat)lineWidth;
+(void)setMiterLimit:(CGFloat)miterLimit;
+(void)setStrokeEnd:(CGFloat)strokeEnd;
+(void)setStrokeStart:(CGFloat)strokeStart;
+(void)setFillColor:(UIColor *)fillColor;
+(void)setFillRule:(NSString *)fillRule;
+(void)setLineCap:(NSString *)lineCap;
+(void)setLineDashPattern:(NSArray *)lineDashPattern;
+(void)setLineJoin:(NSString *)lineJoin;
+(void)setStrokeColor:(UIColor *)strokeColor;

@property (nonatomic, readwrite) CGFloat lineDashPhase;
@property (nonatomic, readwrite) CGFloat lineWidth;
@property (nonatomic, readwrite) CGFloat miterLimit;
@property (nonatomic, readwrite) CGFloat strokeEnd;
@property (nonatomic, readwrite) CGFloat strokeStart;
@property (nonatomic, readwrite, retain) UIColor *fillColor;
@property (nonatomic, readwrite, retain) NSString *fillRule;
@property (nonatomic, readwrite, retain) NSString *lineCap;
@property (nonatomic, readwrite, retain) NSArray *lineDashPattern;
@property (nonatomic, readwrite, retain) NSString *lineJoin;
@property (nonatomic, readwrite, retain) UIColor *strokeColor;
@property (nonatomic, readwrite,nonatomic) BOOL usesGlobalAttributes;
@end