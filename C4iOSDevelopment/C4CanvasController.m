//
//  ViewController.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4CanvasController.h"
#import "C4VideoPlayerController.h"
#import "C4VideoPlayerView.h"

@interface C4CanvasController()
@property (readwrite, strong) C4VideoPlayerController *inceptionMovieController;
-(void)pan:(id)sender;
-(void)togglePlayback:(id)sender;
-(void)resetPlayhead:(id)sender;
@end

@implementation C4CanvasController

@synthesize canvas, inceptionMovieController;

-(void)setup {
    self.inceptionMovieController = [[C4VideoPlayerController alloc] init];
    [self.inceptionMovieController loadMovieWithName:@"inception.m4v"];
    [self.inceptionMovieController setMovieFrame:CGRectMake(100, 100, 320, 200)];
//    [self.view addSubview:self.inceptionMovieController.videoPlayerView];
    [canvas addSublayer:self.inceptionMovieController.videoPlayerView.playerLayer];
    [self.inceptionMovieController play];
    
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
    self.inceptionMovieController.videoPlayerView.playerLayer.position = [sender locationInView:self.view];
}

-(void)togglePlayback:(id)sender {
    if([inceptionMovieController.player rate] > 0.f){
        [inceptionMovieController pause];
    } else {
        [inceptionMovieController play];
    }
}

-(void)resetPlayhead:(id)sender {
    [inceptionMovieController.player seekToTime:kCMTimeZero];
}

@end
