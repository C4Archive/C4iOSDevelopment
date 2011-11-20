//
//  C4Movie.m
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-20.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Movie.h"

@interface C4Movie()
- (CMTime)playerItemDuration;
- (BOOL)isPlaying;
- (void)assetFailedToPrepareForPlayback:(NSError *)error;
- (void)prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys;

@property (strong) C4VideoPlayerView *videoPlayerView;
@property (strong) AVPlayer *player;
@property (strong) AVPlayerItem *playerItem;
@end

@implementation C4Movie
@synthesize player, playerItem, rate, videoPlayerView, frame, position;

-(id)initWithMovieName:(NSString *)movieName andFrame:(CGRect)movieFrame {
    self = [super init];
    if(self != nil) {
        videoPlayerView = [[C4VideoPlayerView alloc] initWithFrame:movieFrame];
        
        NSArray *movieNameComponents = [movieName componentsSeparatedByString:@"."];
        movieURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:[movieNameComponents objectAtIndex:0]
                                                                                      ofType:[movieNameComponents objectAtIndex:1]]];
        if([movieURL scheme]) {
            AVURLAsset *asset = [AVURLAsset URLAssetWithURL:movieURL options:nil];
            NSArray *requestedKeys = [NSArray arrayWithObjects:@"duration", @"playable", nil];
            [asset loadValuesAsynchronouslyForKeys:requestedKeys completionHandler: ^(void) {		 
                dispatch_async( dispatch_get_main_queue(), ^(void) {
                    [self prepareToPlayAsset:asset withKeys:requestedKeys];
                });
            }];
        }
    }
    return self;
}

-(void)setMovieFrame:(CGRect)newRect {
    videoPlayerView.frame = newRect;
}

- (CMTime)playerItemDuration
{
	AVPlayerItem *thePlayerItem = [player currentItem];
	if (thePlayerItem.status == AVPlayerItemStatusReadyToPlay)
	{                
		return(playerItem.duration);
	}
    
	return(kCMTimeInvalid);
}

- (BOOL)isPlaying
{
	return (player.rate != 0.f);
}

-(void)assetFailedToPrepareForPlayback:(NSError *)error
{
    /* Display the error. */
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
														message:[error localizedFailureReason]
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
	[alertView show];
}

- (void)prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys
{
    rateContext = &rateContext;
    currentItemContext = &currentItemContext;
    playerItemStatusContext = &playerItemStatusContext;
    
    /* Make sure that the value of each key has loaded successfully. */
	for (NSString *thisKey in requestedKeys)
	{
		NSError *error = nil;
		AVKeyValueStatus keyStatus = [asset statusOfValueForKey:thisKey error:&error];
		if (keyStatus == AVKeyValueStatusFailed)
		{
            C4Log(@"assetFailedToPrepareForPlayback");
			[self assetFailedToPrepareForPlayback:error];
			return;
		}
		/* If you are also implementing the use of -[AVAsset cancelLoading], add your code here to bail 
         out properly in the case of cancellation. */
	}
    
    /* Use the AVAsset playable property to detect whether the asset can be played. */
    if (!asset.playable) 
    {
        /* Generate an error describing the failure. */
		NSString *localizedDescription = NSLocalizedString(@"Item cannot be played", @"Item cannot be played description");
		NSString *localizedFailureReason = NSLocalizedString(@"The assets tracks were loaded, but could not be made playable.", @"Item cannot be played failure reason");
		NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
								   localizedDescription, NSLocalizedDescriptionKey, 
								   localizedFailureReason, NSLocalizedFailureReasonErrorKey, 
								   nil];
		NSError *assetCannotBePlayedError = [NSError errorWithDomain:@"C4VideoPlayerController" code:0 userInfo:errorDict];
        
        /* Display the error to the user. */
        [self assetFailedToPrepareForPlayback:assetCannotBePlayedError];
        
        return;
    }
	
	/* At this point we're ready to set up for playback of the asset. */	
    /* Stop observing our prior AVPlayerItem, if we have one. */
    if (self.playerItem)
    {
        /* Remove existing player item key value observers and notifications. */
        
        [self.playerItem removeObserver:self forKeyPath:@"status"];            
		
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:self.playerItem];
    }
	
    /* Create a new instance of AVPlayerItem from the now successfully loaded AVAsset. */
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    /* Observe the player item "status" key to determine when it is ready to play. */
    [self.playerItem addObserver:self 
                      forKeyPath:@"status" 
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:playerItemStatusContext];
	
    /* When the player item has played to its end time we'll toggle
     the movie controller Pause button to be the Play button */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.playerItem];
    
    /* Create new player, if we don't already have one. */
    if (![self player])
    {
        /* Get a new AVPlayer initialized to play the specified player item. */
        [self setPlayer:[AVPlayer playerWithPlayerItem:self.playerItem]];	
		
        /* Observe the AVPlayer "currentItem" property to find out when any 
         AVPlayer replaceCurrentItemWithPlayerItem: replacement will/did 
         occur.*/
        [self.player addObserver:self 
                      forKeyPath:@"currentItem" 
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:currentItemContext];
    }
    
    /* Make our new AVPlayerItem the AVPlayer's current item. */
    if (self.player.currentItem != self.playerItem)
    {
        /* Replace the player item with a new player item. The item replacement occurs 
         asynchronously; observe the currentItem property to find out when the 
         replacement will/did occur*/
        C4Log(@"replaceCurrentItemWithPlayerItem");
        [[self player] replaceCurrentItemWithPlayerItem:self.playerItem];
    }
}

- (void)observeValueForKeyPath:(NSString*) path 
                      ofObject:(id)object 
                        change:(NSDictionary*)change 
                       context:(void*)context
{
	/* AVPlayerItem "status" property value observer. */
	if (context == playerItemStatusContext)
	{
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status)
        {
                /* Indicates that the status of the player is not yet known because 
                 it has not tried to load new media resources for playback */
            case AVPlayerStatusUnknown:
                C4Log(@"AVPlayerStatusUnknown");
                break;
                
            case AVPlayerStatusReadyToPlay:
            {
                /* Once the AVPlayerItem becomes ready to play, i.e. 
                 [playerItem status] == AVPlayerItemStatusReadyToPlay,
                 its duration can be fetched from the item. */
                C4Log(@"AVPlayerStatusReadyToPlay");
                videoPlayerView.playerLayer.hidden = NO;
                videoPlayerView.playerLayer.backgroundColor = [[UIColor clearColor] CGColor];
                
                /* Set the AVPlayerLayer on the view to allow the AVPlayer object to display
                 its content. */	
                [videoPlayerView.playerLayer setPlayer:player];
                [self play];
            }
                break;
                
            case AVPlayerStatusFailed:
            {
                C4Log(@"AVPlayerStatusFailed");
                AVPlayerItem *thePlayerItem = (AVPlayerItem *)object;
                [self assetFailedToPrepareForPlayback:thePlayerItem.error];
            }
                break;
        }
	}
	/* AVPlayer "currentItem" property observer. 
     Called when the AVPlayer replaceCurrentItemWithPlayerItem: 
     replacement will/did occur. */
	else if (context == currentItemContext)
	{
        AVPlayerItem *newPlayerItem = [change objectForKey:NSKeyValueChangeNewKey];
        C4Log(@"currentItemContext");
        
        /* New player item null? */
        if (newPlayerItem == (id)[NSNull null])
        {
        }
        else /* Replacement of player currentItem has occurred */
        {
            /* Set the AVPlayer for which the player layer displays visual output. */
            [videoPlayerView.playerLayer setPlayer:self.player];
            
            /* Specifies that the player should preserve the video’s aspect ratio and 
             fit the video within the layer’s bounds. */
            [videoPlayerView setVideoFillMode:AVLayerVideoGravityResizeAspect];
        }
	}
	else
	{
        C4Log(@"else");
		[super observeValueForKeyPath:path ofObject:object change:change context:context];
	}
    
    return;
}

- (void) playerItemDidReachEnd:(NSNotification*) aNotification 
{
    C4Log(@"end");
    [playerItem seekToTime:kCMTimeZero];
}

- (void)play {
    [player play];
}

- (void)pause {
    [player pause];
}

-(CGFloat)rate {
    return player.rate;
}

-(void)setRate:(CGFloat)newRate {
    player.rate = (float)newRate;
}

-(AVPlayerLayer *)movieLayer {
    return videoPlayerView.playerLayer;
}

-(CGRect)frame {
    return videoPlayerView.frame;
}

-(void)setFrame:(CGRect)newFrame {
    videoPlayerView.frame = newFrame;
}

-(CGPoint)position {
    return videoPlayerView.playerLayer.position;
}

-(void)setPosition:(CGPoint)newPosition {
    videoPlayerView.playerLayer.position = newPosition;
}

-(void)seekToTime:(CMTime)newTime {
    [player seekToTime:newTime];
}
@end
