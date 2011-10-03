//
//  C4Canvas.m
//  C4iOS
//
//  Created by Travis Kirton on 11-08-23.
//  Copyright 2011 mediart. All rights reserved.
//

#import "C4Canvas.h"

@implementation C4Canvas

-(id)init {
    self = [super init];
    if(self) {
        readyToDisplay = NO;
    }
    return self;
}

-(void)setup {
    [self setOpaque:YES];
    readyToDisplay = YES;
}

-(void)display {
    if(readyToDisplay) {
        [super display]; 
    }
}

-(void)addShape:(C4Shape *)newShape {
    [self addSublayer:newShape];
}

-(void)removeAllShapes {
    for(CALayer *layer in self.sublayers) {
        [layer removeFromSuperlayer];
    }
}

-(void)addLayer:(C4Layer *)newLayer {
    [self addSublayer:newLayer];
}

-(void)receiveMovedTouches:(NSSet *)touches withEvent:(UIEvent *)theEvent {
    for(UITouch *touch in touches) {
        for(C4Shape *layer in self.sublayers) {
            CGPoint location = [touch locationInView:[touch view]];
            if([layer hitTest:location]) {
                layer.position = location;
                break;
            }
        }
    }
}
@end
