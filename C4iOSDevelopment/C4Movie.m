//
//  C4Movie.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-19.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Movie.h"

@interface C4Movie()
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
-(void)setUpPlaybackOfAsset:(AVAsset *)asset withKeys:(NSArray *)keys;
-(void)stopAndHideLoadingSpinner;
@end

@implementation C4Movie

@synthesize loadingView, movieRect, player, playerLayer;
@synthesize rate, volume, muted, closedCaptionDisplayEnabled;
@synthesize timestamp;

-(id)initWithName:(NSString *)movieName andRect:(CGRect)rect {
    self = [super init];
    if(self) {
        
        movieStatus = &movieStatus;
        playbackRate = &playbackRate;
        readyToDisplay = &readyToDisplay;
        
        self.player = [[AVPlayer alloc] init];
        self.movieRect = rect;
        
        // OSX uses CIFilters for changing color, but the following line suffices for iOS
        self.loadingView = [[UIActivityIndicatorView alloc] 
                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        self.loadingView.frame = movieRect;
        [self.loadingView sizeToFit];
        
        self.loadingView.hidesWhenStopped = YES;
        [self.loadingView startAnimating];
                
        NSArray *movieURLComponents = [movieName componentsSeparatedByString:@"."];
        NSURL *movieURL = [[NSBundle mainBundle] URLForResource:[movieURLComponents objectAtIndex:0] withExtension:[movieURLComponents objectAtIndex:1]];
        
        AVURLAsset *asset = [AVAsset assetWithURL:movieURL];
        NSArray *assetKeysToLoadAndTest = [NSArray arrayWithObjects:@"playable", @"hasProtectedContent", @"tracks", @"duration", nil];
        [asset loadValuesAsynchronouslyForKeys:assetKeysToLoadAndTest completionHandler:^(void) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self setUpPlaybackOfAsset:asset withKeys:assetKeysToLoadAndTest];
            });
            
        }];
    }
    
    [player play];
    return self;
}

#pragma mark C4Object Methods
-(void)setup {
    
}

-(void)listenFor:(NSString *)aNotification andRunMethod:(NSString *)aMethodName{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:NSSelectorFromString(aMethodName) name:aNotification object:nil];
}

-(void)stopListeningFor:(NSString *)aMethodName {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:aMethodName object:nil];
}

-(void)postNotification:(NSString *)aNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:aNotification object:self];
}

-(void)setTimestamp:(NSTimeInterval)_timestamp {
    if(self.timestamp == 0.0f)
        self.timestamp = _timestamp;
}

#pragma mark other methods
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if (context == movieStatus)
	{
		AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
		BOOL enable = NO;
		switch (status)
		{
			case AVPlayerItemStatusUnknown:
				break;
			case AVPlayerItemStatusReadyToPlay:
				enable = YES;
				break;
			case AVPlayerItemStatusFailed:
				[self stopAndHideLoadingSpinner];
                NSLog(@"AVPlayerItemStatusFailed");
				break;
		}
        /* options */
        //if(enable) { /* do stuff */ }
    }
	else if (context == readyToDisplay)
	{
		if ([[change objectForKey:NSKeyValueChangeNewKey] boolValue] == YES)
		{
			// The AVPlayerLayer is ready for display. Hide the loading spinner and show it.
			[self stopAndHideLoadingSpinner];
		}
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

-(void)setUpPlaybackOfAsset:(AVAsset *)asset withKeys:(NSArray *)keys {
	// This method is called when the AVAsset for our URL has completing the loading of the values of the specified array of keys.
    
	// We set up playback of the asset here.
	
	// First test whether the values of each of the keys we need have been successfully loaded.
	for (NSString *key in keys)
	{
		NSError *error = nil;
		
		if ([asset statusOfValueForKey:key error:&error] == AVKeyValueStatusFailed)
		{
			[self stopAndHideLoadingSpinner];
            NSLog(@"unplayable asset");
			return;
		}
	}
	
	if (![asset isPlayable] || [asset hasProtectedContent])
	{
		// We can't play this asset. Show the "Unplayable Asset" label.
		[self stopAndHideLoadingSpinner];
        NSLog(@"unplayable asset");
		return;
	}
	
	// We can play this asset.
	// Set up an AVPlayerLayer according to whether the asset contains video.
	if ([[asset tracksWithMediaType:AVMediaTypeVideo] count] != 0)
	{
		// Create an AVPlayerLayer and add it to the player view if there is video, but hide it until it's ready for display
        AVPlayerLayer *newPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:[self player]];
        newPlayerLayer.frame = self.movieRect;

        self.playerLayer = newPlayerLayer;
        
        [self addObserver:self forKeyPath:@"playerLayer.readyForDisplay" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:readyToDisplay];
	}
	else
	{
		// This asset has no video tracks. Show the "No Video" label.
		[self stopAndHideLoadingSpinner];
        NSLog(@"no video tracks");
	}
	
	// Create a new AVPlayerItem and make it our player's current item.
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
	[[self player] replaceCurrentItemWithPlayerItem:playerItem];
}

-(void)stopAndHideLoadingSpinner {
    [self.loadingView stopAnimating];
    [self.loadingView removeFromSuperview];
}

-(CMTime)currentTime {
    return player.currentTime;
}

-(CMTime)duration {
    return [player.currentItem duration];
}

-(void)play {
    [player play];
}

-(void)pause {
    [player pause];
}

-(void)seekToTime:(CMTime)newTime {
    [player seekToTime:newTime];
}

-(CGFloat)rate {
    return (CGFloat)player.rate;
}

-(void)setRate:(CGFloat)newRate {
    player.rate = (float)newRate;
}

-(BOOL)isClosedCaptionDisplayEnabled {
    return player.closedCaptionDisplayEnabled;
}

-(void)setCloseCaptionDisplayEnabled:(BOOL)newCloseCaptionDisplayEnabled {
    player.closedCaptionDisplayEnabled = newCloseCaptionDisplayEnabled;
}

@end
