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
    self.borderWidth = 10.0f;
    self.borderColor = [UIColor blueColor].CGColor;
    
    readyToDisplay = YES;
    
//    CATextLayer *layer = [CATextLayer layer];
//    
//    layer.wrapped = YES;
//    layer.string = @"C4 is a new Programming Framework";
//    
//    layer.backgroundColor = [UIColor blueColor].CGColor;
//    
//    layer.bounds = CGRectMake(10, 10, 100, 100);
//    
//    CTFontRef ctFont = CTFontCreateWithName(CFSTR("Futura-Medium"), 12.0f, NULL);        
//    
//    layer.font =  ctFont;
//    
//    layer.position = CGPointMake(250, 250);
//    C4Log(@"layer count:%d",[self.sublayers count]);
//    [self addSublayer:layer];
//    C4Log(@"layer count:%d",[self.sublayers count]);
//    [self setNeedsDisplay];
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

-(void)addTextLayer:(C4TextLayer *)newTextLayer {
    [self addSublayer:newTextLayer];
}

-(void)receiveTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)theEvent {
}

-(void)receiveTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)theEvent {
}

-(void)receiveTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)theEvent {
}

-(void)test {
    C4Log(@"test");
}
@end