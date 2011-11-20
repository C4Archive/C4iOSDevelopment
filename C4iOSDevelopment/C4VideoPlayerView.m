//
//  C4VideoPlayerView.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-19.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4VideoPlayerView.h"

@implementation C4VideoPlayerView
@synthesize playerLayer;

+ (Class)layerClass
{
	return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer
{
	return (AVPlayerLayer *)self.layer;
}

- (void)setPlayer:(AVPlayer*)player
{
	[(AVPlayerLayer*)[self layer] setPlayer:player];
}

/* Specifies how the video is displayed within a player layer’s bounds. */
- (void)setVideoFillMode:(NSString *)fillMode
{
	self.playerLayer.videoGravity = fillMode;
}

@end
