//
//  C4Image.h
//  C4iOSDevelopment
//
//  Created by Travis Kirton on 11-10-12.
//  Copyright (c) 2011 mediart. All rights reserved.
//

#import "C4Layer.h"
@class C4Color;

@interface C4Image : C4Layer {
@private
}

+(C4Image *)imageNamed:(NSString *)name;

-(id)initWithImage:(C4Image *)image;
-(id)initWithImageName:(NSString *)name;

@property (readwrite, strong, nonatomic) UIImage *originalImage;
@end
