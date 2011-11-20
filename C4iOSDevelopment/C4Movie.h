//
//  C4Movie.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-20.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "C4VideoPlayerView.h"

@class AVPlayer;
@class AVPlayerItem;

@interface C4Movie : UIViewController {
@private
    NSURL *movieURL;
    void *rateContext, *currentItemContext, *playerItemStatusContext;
}

-(id)initWithMovieName:(NSString *)movieName andFrame:(CGRect)movieFrame;
-(void)play;
-(void)pause;
-(void)setMovieFrame:(CGRect)newRect;
-(void)seekToTime:(CMTime)newTime;
-(AVPlayerLayer *)movieLayer;

@property (nonatomic) CGFloat rate;
@property (nonatomic) CGPoint position;
@property (nonatomic) CGRect  frame;
@end
