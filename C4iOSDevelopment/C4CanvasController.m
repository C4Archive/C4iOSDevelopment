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
@property (readwrite, strong) C4Movie *movieA, *movieB, *movieC;
-(void)pan:(id)sender;
-(void)togglePlayback:(id)sender;
-(void)resetPlayhead:(id)sender;
-(void)seekTimes:(id)sender;
-(void)addMovie:(C4Movie *)newMovie;
@end

@implementation C4CanvasController

@synthesize canvas, movieA, movieB, movieC;

-(void)setup {
    canvas.backgroundColor = [[UIColor blackColor] CGColor];
    
    self.movieA = [[C4Movie alloc] initWithMovieName:@"inception.m4v"
                                            andFrame:CGRectMake(0, 0, 768, 341)];
    self.movieB = [[C4Movie alloc] initWithMovieName:@"inception.m4v"
                                            andFrame:CGRectMake(0, 341, 768, 341)];
    self.movieC = [[C4Movie alloc] initWithMovieName:@"inception.m4v"
                                            andFrame:CGRectMake(0, 682, 768, 341)];
    
    [self addMovie:movieA];
    [self addMovie:movieB];
    [self addMovie:movieC];
     
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

    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seekTimes:)];
    tripleTap.numberOfTapsRequired = 1;
    tripleTap.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:tripleTap];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self togglePlayback:nil];
    [self seekTimes:nil];
}

-(void)pan:(id)sender {
}

-(void)togglePlayback:(id)sender {
    if(movieA.rate > 0.){
        [self.movieA pause];
        [self.movieB pause];
        [self.movieC pause];
    } else {
        [self.movieA play];
        [self.movieB play];
        [self.movieC play];
    }
}

-(void)resetPlayhead:(id)sender {
}

-(void)seekTimes:(id)sender {
    [self.movieA seekToTime:CMTimeMakeWithSeconds(0, 1)];
    [self.movieB seekToTime:CMTimeMakeWithSeconds(2, 1)];
    [self.movieC seekToTime:CMTimeMakeWithSeconds(4, 1)];
}

-(void)addMovie:(C4Movie *)newMovie {
    [canvas addSublayer:[newMovie movieLayer]];
}
@end
