//
//  GalleryCommunicator.h
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#ifndef gallery_GalleryCommunicator_h
#define gallery_GalleryCommunicator_h



@protocol GalleryCommunicatorDelegate;

@interface GalleryCommunicator : NSObject
@property (weak, nonatomic) id<GalleryCommunicatorDelegate> delegate;

- (void)searchImages:(NSString*)what;
@end

#endif
