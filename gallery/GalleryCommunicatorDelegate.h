//
//  GalleryCommunicatorDelegate.h
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GalleryCommunicatorDelegate <NSObject>

- (void)receiveFinished:(NSData *)data;
- (void)receiveFailedWithError:(NSError *)error;

@end
