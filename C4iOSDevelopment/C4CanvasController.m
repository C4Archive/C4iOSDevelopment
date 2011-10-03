//
//  C4CanvasController.m
//  C4iOS
//
//  Created by Travis Kirton on 11-08-24.
//  Copyright 2011 mediart. All rights reserved.
//

#import "C4CanvasController.h"

@implementation C4CanvasController
@synthesize canvas;

-(void)setup {
    [canvas setBackgroundColor:[[UIColor whiteColor] CGColor]];
    [canvas setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [canvas setBorderWidth:3];
    
    [self reset];
}

-(void)reset {
    C4Log(@"controller reset");
    [canvas removeAllShapes];
    [C4Shape setFillColor:[UIColor colorWithRed:1.0f green:0.2f blue:0.2f alpha:1.0f]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(334, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(234, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(134, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(134, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(134, 412) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(134, 312) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(234, 312) size:CGSizeMake(100, 100)]];
    
    [C4Shape setFillColor:[UIColor colorWithRed:0.2 green:0.4 blue:1.0f alpha:1.0f]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(534, 312) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(534, 412) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(534, 612) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(634, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(534, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(434, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(334, 512) size:CGSizeMake(100, 100)]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(334, 412) size:CGSizeMake(100, 100)]];
    
    [C4Shape setFillColor:[UIColor colorWithWhite:0.13 alpha:1.0f]];
    [canvas addShape:[C4Shape rectAt:CGPointMake(334, 312) size:CGSizeMake(100, 100)]];
    
    for(C4Shape *shape in canvas.sublayers) {
        shape.shadowOpacity = 1.0f;
        shape.shadowRadius = 10.0f;
        shape.shadowOffset = CGSizeMake(0.0f, 5.0f);
    }
}
@end
