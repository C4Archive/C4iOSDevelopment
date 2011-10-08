//
//  C4Shape.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Shape.h"
#import "C4GlobalShapeAttributes.h"

@interface C4Shape ()
-(void)setupShapeAttributes;
-(CAShapeLayer *)applyAttributesToShapeLayer:(CAShapeLayer *)shapeLayer;
-(void)addPath:(UIBezierPath *)path;
-(void)addPoint:(UIBezierPath *)path;
@end

@implementation C4Shape
@synthesize lineDashPhase, lineWidth, miterLimit, strokeEnd, strokeStart;
@synthesize fillRule, fillColor, lineCap, lineJoin, lineDashPattern, strokeColor; 
@synthesize usesGlobalAttributes;

- (id)init
{
    self = [super init];
    if (self) {
#ifdef VERBOSE
        C4Log(@"%@ init",[self class]);
#endif
        [self setupShapeAttributes];
        self.usesGlobalAttributes = YES;
    }
    
    return self;
}

+(C4Shape *)rectAt:(CGPoint)origin size:(CGSize)size {
    C4Shape *newRect = [[C4Shape alloc] init];
    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    [newRect addPath:rectPath];
    newRect.bounds = rectPath.bounds;
    newRect.position = origin;
    return newRect;
}

+(C4Shape *)circleAt:(CGPoint)origin radius:(CGFloat)radius {
    C4Shape *newCircle = [[C4Shape alloc] init];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-radius, -radius,radius*2.0f,radius*2.0f)];
    [newCircle addPath:circlePath];
    newCircle.position = origin;
    return newCircle;
}

+(C4Shape *)ellipseAt:(CGPoint)origin size:(CGSize)size {
    
    C4Shape *newEllipse = [[C4Shape alloc] init];
    CGRect ellipseRect = CGRectZero;
    ellipseRect.size = size;
    
    UIBezierPath *ellipsePath = [UIBezierPath bezierPathWithOvalInRect:ellipseRect];
    
    [newEllipse addPath:ellipsePath];
    
    newEllipse.position = origin;
    
    return newEllipse;
}

+(C4Shape *)lineFrom:(CGPoint)origin to:(CGPoint)end {
    C4Shape *newLine = [[C4Shape alloc] init];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    end.x -= origin.x;
    end.y -= origin.y;
    
    [linePath moveToPoint:CGPointZero];
    [linePath addLineToPoint:end];
    [newLine addPath:linePath];
    newLine.position = origin;
    return newLine;
}

+(C4Shape *)triangleFrom:(CGPoint)pointA to:(CGPoint)pointB to:(CGPoint)pointC {
    C4Shape *newTriangle = [[C4Shape alloc] init];
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    
    pointB.x -= pointA.x;
    pointB.y -= pointA.y;
    pointC.x -= pointA.x;
    pointC.y -= pointA.y;
    
    [trianglePath moveToPoint:CGPointZero];
    [trianglePath addLineToPoint:pointB];
    [trianglePath addLineToPoint:pointC];
    [trianglePath closePath];
    [newTriangle addPath:trianglePath];
    
    newTriangle.position = pointA;
    
    /*
     APPARENTLY ANCHOR POINT DOESN'T WORK...
     //adjust anchorpoint to pointA
     CGRect triangleBounds = [trianglePath bounds];
     
     CGFloat anchorPointX = 0.0f;
     anchorPointX += fabsf(triangleBounds.origin.x);
     anchorPointX /= fabsf(triangleBounds.size.width);
     if(triangleBounds.origin.x > 0.0f) anchorPointX *= -1;
     
     CGFloat anchorPointY = 0.0f;
     anchorPointY += fabsf(triangleBounds.origin.y);
     anchorPointY /= fabsf(triangleBounds.size.height);
     if(triangleBounds.origin.y > 0.0f) anchorPointY *= -1;
     
     newTriangle.anchorPoint = CGPointMake(anchorPointX, anchorPointY);
     */
    return newTriangle;
}

+(C4Shape *)polygonWith:(CGPoint *)points {
    NSInteger pointCount = sizeof(points);
    
    if(pointCount > 1) {
        
        C4Shape *newPolygon = [[C4Shape alloc] init];
        UIBezierPath *polygonPath = [UIBezierPath bezierPath];
        
        [polygonPath moveToPoint:CGPointZero];
        
        for(int i = 1; i < pointCount; i++) {
            points[i].x -= points[0].x;
            points[i].y -= points[0].y;
            
            [polygonPath addLineToPoint:points[i]];
        }
        
        [newPolygon addPath:polygonPath];
        
        newPolygon.position = points[0];
        
        /*
         APPARENTLY ANCHOR POINT DOESN'T WORK...
         //adjust anchorpoint to points[0]
         CGRect polygonBounds = [polygonPath bounds];
         
         CGFloat anchorPointX = 0.0f;
         anchorPointX += fabsf(polygonBounds.origin.x);
         anchorPointX /= fabsf(polygonBounds.size.width);
         if(polygonBounds.origin.x > 0.0f) anchorPointX *= -1;
         
         CGFloat anchorPointY = 0.0f;
         anchorPointY += fabsf(polygonBounds.origin.y);
         anchorPointY /= fabsf(polygonBounds.size.height);
         if(polygonBounds.origin.y > 0.0f) anchorPointY *= -1;
         
         newPolygon.anchorPoint = CGPointMake(anchorPointX, anchorPointY);
         */
        return newPolygon;
    }
    return nil;
}

+(C4Shape *)pointAt:(CGPoint)origin {
    C4Shape *newPoint = [[C4Shape alloc] init];
    
    UIBezierPath *pointPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, 1)];
    [newPoint addPoint:pointPath];
    newPoint.position = origin;
    return newPoint;
}

+(C4Shape *)arcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise {
    C4Shape *newArc = [[C4Shape alloc] init];
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    [newArc addPath:arcPath];
    
    newArc.position = center;
    return newArc;
}

+(C4Shape *)pieSliceWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise {
    C4Shape *newArc = [[C4Shape alloc] init];
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointZero radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    [arcPath addLineToPoint:CGPointZero];
    [arcPath closePath];
    [newArc addPath:arcPath];
    
    newArc.position = center;
    return newArc;
}

-(void)addPath:(UIBezierPath *)path {
    if(shapeArray == nil) {
        shapeArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = [path CGPath];
    
    [self addSublayer:[self applyAttributesToShapeLayer:shapeLayer]];
}

-(void)addPoint:(UIBezierPath *)path {
    if(shapeArray == nil) {
        shapeArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = nil;
    if (self.usesGlobalAttributes) {
        shapeLayer.fillColor = [[C4GlobalShapeAttributes sharedManager].fillColor CGColor];
    } else {
        shapeLayer.fillColor = [self.fillColor CGColor];
    }
    [shapeArray addObject:path];
    
    [self addSublayer:shapeLayer];
}

-(void)setLineDashPhase:(CGFloat)_lineDashPhase {
    lineDashPhase = _lineDashPhase;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setLineWidth:(CGFloat)_lineWidth {
    lineWidth = _lineWidth;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setMiterLimit:(CGFloat)_miterLimit {
    miterLimit = _miterLimit;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setStrokeEnd:(CGFloat)_strokeEnd {
    strokeEnd = _strokeEnd;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setStrokeStart:(CGFloat)_strokeStart {
    strokeStart = _strokeStart;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setFillColor:(UIColor *)_fillColor {
    fillColor = nil;
    fillColor = _fillColor;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setFillRule:(NSString *)_fillRule {
    fillRule = _fillRule;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setLineCap:(NSString *)_lineCap {
    lineCap = _lineCap;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setLineDashPattern:(NSArray *)_lineDashPattern {
    lineDashPattern = nil;
    lineDashPattern = [NSArray arrayWithArray:_lineDashPattern];
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setLineJoin:(NSString *)_lineJoin {
    lineJoin = _lineJoin;
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

-(void)setStrokeColor:(UIColor *)_strokeColor {
    strokeColor = nil;
    strokeColor = [UIColor colorWithCGColor:[_strokeColor CGColor]];
    self.usesGlobalAttributes = NO;
    for(CAShapeLayer *shape in self.sublayers) {
        [self applyAttributesToShapeLayer:shape];
    }
}

+(void)setLineDashPhase:(CGFloat)lineDashPhase {
    [C4GlobalShapeAttributes sharedManager].lineDashPhase = lineDashPhase;
}

+(void)setLineWidth:(CGFloat)lineWidth {
    [C4GlobalShapeAttributes sharedManager].lineWidth = lineWidth;
}

+(void)setMiterLimit:(CGFloat)miterLimit {
    [C4GlobalShapeAttributes sharedManager].miterLimit = miterLimit;
}

+(void)setStrokeEnd:(CGFloat)strokeEnd {
    [C4GlobalShapeAttributes sharedManager].strokeEnd = strokeEnd;
}

+(void)setStrokeStart:(CGFloat)strokeStart {
    [C4GlobalShapeAttributes sharedManager].strokeStart = strokeStart;
}

+(void)setFillColor:(UIColor *)fillColor {
    [C4GlobalShapeAttributes sharedManager].fillColor = fillColor;
}

+(void)setFillRule:(NSString *)fillRule {
    [C4GlobalShapeAttributes sharedManager].fillRule = fillRule;
}

+(void)setLineCap:(NSString *)lineCap {
    [C4GlobalShapeAttributes sharedManager].lineCap = lineCap;
}

+(void)setLineDashPattern:(NSArray *)lineDashPattern {
    [C4GlobalShapeAttributes sharedManager].lineDashPattern = lineDashPattern;
}

+(void)setLineJoin:(NSString *)lineJoin {
    [C4GlobalShapeAttributes sharedManager].lineJoin = lineJoin;
}

+(void)setStrokeColor:(UIColor *)strokeColor {
    [C4GlobalShapeAttributes sharedManager].strokeColor = strokeColor;
}

-(void)setUsesGlobalAttributes:(BOOL)_usesGlobalAttributes {
    usesGlobalAttributes = _usesGlobalAttributes;
    for(CAShapeLayer *shape in self.sublayers){
        [self applyAttributesToShapeLayer:shape];
    }
}

-(CAShapeLayer *)applyAttributesToShapeLayer:(CAShapeLayer *)shapeLayer {
    if(self.usesGlobalAttributes == YES) {
        shapeLayer.fillColor = [[C4GlobalShapeAttributes sharedManager].fillColor CGColor];
        shapeLayer.fillRule = [C4GlobalShapeAttributes sharedManager].fillRule;
        shapeLayer.lineCap = [C4GlobalShapeAttributes sharedManager].lineCap;
        shapeLayer.lineDashPattern = [C4GlobalShapeAttributes sharedManager].lineDashPattern;
        shapeLayer.lineDashPhase = [C4GlobalShapeAttributes sharedManager].lineDashPhase;
        shapeLayer.lineJoin = [C4GlobalShapeAttributes sharedManager].lineJoin;
        shapeLayer.lineWidth = [C4GlobalShapeAttributes sharedManager].lineWidth;
        shapeLayer.miterLimit = [C4GlobalShapeAttributes sharedManager].miterLimit;
        shapeLayer.strokeColor = [[C4GlobalShapeAttributes sharedManager].strokeColor CGColor];
        shapeLayer.strokeStart = [C4GlobalShapeAttributes sharedManager].strokeStart;
        shapeLayer.strokeEnd = [C4GlobalShapeAttributes sharedManager].strokeEnd;
    } else {
        shapeLayer.fillColor = [self.fillColor CGColor];
        shapeLayer.fillRule = self.fillRule;
        shapeLayer.lineCap = self.lineCap;
        shapeLayer.lineDashPattern = self.lineDashPattern;
        shapeLayer.lineDashPhase = self.lineDashPhase;
        shapeLayer.lineJoin = self.lineJoin;
        shapeLayer.lineWidth = self.lineWidth;
        shapeLayer.miterLimit = self.miterLimit;
        shapeLayer.strokeColor = [self.strokeColor CGColor];
        shapeLayer.strokeStart = self.strokeStart;
        shapeLayer.strokeEnd = self.strokeEnd;
    }
    return shapeLayer;
}

-(void)setupShapeAttributes {
    self.shadowOffset = CGSizeMake(5.0f, 5.0f);
    self.fillColor = nil;
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
