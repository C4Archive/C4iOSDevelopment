//
//  C4Movie.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-19.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Object.h"

#import <AVFoundation/AVFoundation.h>

@interface C4Movie : UIView {
@private
    void *movieStatus, *playbackRate, *readyToDisplay;
}

-(id)initWithName:(NSString *)movieName andRect:(CGRect)rect;

-(void)play;
-(void)pause;
-(void)seekToTime:(CMTime)newTime;

-(CMTime)currentTime;
-(CMTime)duration;

@property (nonatomic) CGFloat rate, volume;
@property (nonatomic) BOOL muted;
@property(nonatomic, getter=isClosedCaptionDisplayEnabled) BOOL closedCaptionDisplayEnabled;

#pragma mark C4Object Methods & TimeStamp
-(void)setup;
-(void)listenFor:(NSString *)aNotification andRunMethod:(NSString *)aMethodName;
-(void)stopListeningFor:(NSString *)aMethodName;
-(void)postNotification:(NSString *)aNotification;

@property (nonatomic, strong) AVPlayer *player;
@property (strong) AVPlayerLayer *playerLayer;
@property (strong) UIActivityIndicatorView *loadingView;
@property (readwrite) CGRect movieRect;
@property (nonatomic, readwrite) NSTimeInterval timestamp;

@end
