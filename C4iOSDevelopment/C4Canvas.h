//
//  C4Canvas.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Layer.h"
@class C4Image;
@class C4Shape;
@class C4TextLayer;

@interface C4Canvas : C4Layer {
@private
    BOOL readyToDisplay;
    NSMutableArray *currentShapeArray;
}

-(void)addImage:(C4Image *)newImage;
-(void)addShape:(C4Shape *)newShape;
-(void)addLayer:(C4Layer *)newLayer;
-(void)addTextLayer:(C4TextLayer *)newLayer;
-(void)receiveTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)theEvent;
-(void)receiveTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)theEvent;
-(void)test;
@end
