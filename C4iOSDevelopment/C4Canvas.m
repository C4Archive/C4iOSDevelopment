//
//  C4Canvas.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-07.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Canvas.h"

@implementation C4Canvas

-(id)init {
    self = [super init];
    if(self) {
        readyToDisplay = NO;
        self.borderWidth = 0.0f;
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

-(void)addLayer:(C4Layer *)newLayer {
    [self addSublayer:newLayer];
}

-(void)receiveMovedTouches:(NSSet *)touches withEvent:(UIEvent *)theEvent {
    for(UITouch *touch in touches) {
        [self addShape:[C4Shape lineFrom:[touch previousLocationInView:[touch view]] to:[touch locationInView:[touch view]]]];
    }
}

@end