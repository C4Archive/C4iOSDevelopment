//
//  ViewController.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4CanvasController.h"
#import "C4Movie.h"

@interface C4CanvasController()
@property (readwrite, strong) C4Movie *inceptionMovie;
-(void)pan:(id)sender;
-(void)togglePlayback:(id)sender;
-(void)resetPlayhead:(id)sender;
-(void)addMovie:(C4Movie *)newMovie;
@end

@implementation C4CanvasController

@synthesize canvas, inceptionMovie;

-(void)setup {
    self.inceptionMovie = [[C4Movie alloc] initWithMovieName:@"inception.m4v"
                                                    andFrame:CGRectMake(100, 100, 320, 200)];
    [self addMovie:inceptionMovie];
    [self.inceptionMovie play];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:pan];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(togglePlayback:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetPlayhead:)];
    doubleTap.numberOfTapsRequired = 1;
    doubleTap.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
}

-(void)pan:(id)sender {
    inceptionMovie.position = [sender locationInView:self.view];
}

-(void)togglePlayback:(id)sender {
    if(inceptionMovie.rate > 0.){
        [inceptionMovie pause];
    } else {
        [inceptionMovie play];
    }
}

-(void)resetPlayhead:(id)sender {
    [inceptionMovie seekToTime:kCMTimeZero];
}

-(void)addMovie:(C4Movie *)newMovie {
    [canvas addSublayer:[newMovie movieLayer]];
}
@end
