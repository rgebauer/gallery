//
//  GalleryManager.m
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import "GalleryManager.h"

#import <Foundation/Foundation.h>

#import "ImageBuilder.h"
#import "GalleryCommunicator.h"

@implementation GalleryManager

- (void)search:(NSString*)what
{
    [self.communicator searchImages:what];
}

#pragma mark - GalleryCommunicatorDelegate

- (void)receiveFinished:(NSData *)data
{
    NSError *_error = nil;
    _images = [ImageBuilder imagesFromJSON:data error:&_error];
    
    if (_error != nil) {
        [self.delegate fetchingImagesFailedWithError:_error];
        
    }
    else
    {
        [self.delegate didReceiveImages];
    }
}

- (void)receiveFailedWithError:(NSError *)error
{
   [self.delegate fetchingImagesFailedWithError:error];
}


@end