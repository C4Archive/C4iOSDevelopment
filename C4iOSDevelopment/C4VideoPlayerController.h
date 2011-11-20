//
//  C4VideoPlayerController.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-19.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "C4VideoPlayerView.h"

@class AVPlayer;
@class AVPlayerItem;
@class C4VideoPlayerView;

@interface C4VideoPlayerController : UIViewController {
    @private
    NSURL *movieURL;
    void *rateContext, *currentItemContext, *playerItemStatusContext;
}

@property (strong) C4VideoPlayerView *videoPlayerView;
@property (strong) AVPlayer *player;
@property (strong) AVPlayerItem *playerItem;

-(void)loadMovieWithName:(NSString *)movieName;
-(void)play;
-(void)pause;
-(void)setMovieFrame:(CGRect)newRect;

@end
