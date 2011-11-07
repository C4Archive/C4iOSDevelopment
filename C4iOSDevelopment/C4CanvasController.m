//
//  ViewController.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-06.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4CanvasController.h"

#define INFINITE -1
C4AudioPlayer *audioPlayer;
C4TextLayer *playerStateLayer;
C4String *playing, *paused, *stopped;

@implementation C4CanvasController

@synthesize canvas;

-(void)setup {
    audioPlayer = [[C4AudioPlayer alloc] initWithFileNamed:@"C4Loop.aif"];
    audioPlayer.numberOfLoops = INFINITE;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    tap2.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tripleTap:)];
    tap3.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:tap3];
    
    [C4GlobalStringAttributes sharedManager].font = [C4Font fontWithName:@"Futura" size:30.0f];

    playing = [C4String stringWithString:[C4DateTime hourString]];
    paused = [C4String stringWithString:@"paused"];
    stopped = [C4String stringWithString:@"stopped"];
  
    playerStateLayer = [C4TextLayer layerWithString:stopped];
    playerStateLayer.position = CGPointMake(100, 100);
    [canvas addTextLayer:playerStateLayer];
}

-(void)singleTap:(id)sender {
    [audioPlayer play];
    playerStateLayer.c4String = playing;
    playerStateLayer.position = CGPointMake(100, 100);
}

-(void)doubleTap:(id)sender {
    [audioPlayer stop];
    playerStateLayer.c4String = stopped;
    playerStateLayer.position = CGPointMake(100, 100);
}

-(void)tripleTap:(id)sender {
    [audioPlayer pause];
    playerStateLayer.c4String = paused;
    playerStateLayer.position = CGPointMake(100, 100);
}

@end
