//
//  GalleryManager.h
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#ifndef gallery_GalleryManager_h
#define gallery_GalleryManager_h

#import <Foundation/Foundation.h>
#import "GalleryManagerDelegate.h"
#import "GalleryCommunicatorDelegate.h"

@class GalleryCommunicator;

@interface GalleryManager : NSObject<GalleryCommunicatorDelegate>

@property (strong, nonatomic) GalleryCommunicator *communicator;
@property (weak, nonatomic) id<GalleryManagerDelegate> delegate;

- (void)search:(NSString*)what;
@end

#endif
