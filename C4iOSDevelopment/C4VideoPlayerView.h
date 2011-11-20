//
//  C4VideoPlayerView.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-11-19.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayerLayer;

@interface C4VideoPlayerView : UIView

@property (nonatomic, strong, readonly) AVPlayerLayer *playerLayer;
- (void)setVideoFillMode:(NSString *)fillMode;
@end
