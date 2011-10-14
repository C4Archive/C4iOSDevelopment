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
    
    C4String *temp = [C4String stringWithString:@"stopped"];
    temp.font = [C4Font fontWithName:@"Futura" size:30.0f];
    playerStateLayer = [C4TextLayer layerWithString:temp];
    playerStateLayer.position = CGPointMake(100, 100);
    [canvas addTextLayer:playerStateLayer];
}

-(void)singleTap:(id)sender {
    [audioPlayer play];
    C4String *temp = [C4String stringWithString:@"playing"];
    playerStateLayer.string = temp;
    playerStateLayer.position = CGPointMake(100, 100);
}

-(void)doubleTap:(id)sender {
    [audioPlayer stop];
    C4String *temp = [C4String stringWithString:@"stopped"];
    playerStateLayer.string = temp;
    playerStateLayer.position = CGPointMake(100, 100);
}

-(void)tripleTap:(id)sender {
    [audioPlayer pause];
    C4String *temp = [C4String stringWithString:@"paused"];
    playerStateLayer.string = temp;
    playerStateLayer.position = CGPointMake(100, 100);
}

@end
