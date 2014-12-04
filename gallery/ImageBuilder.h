//
//  ImageBuilder.h
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#ifndef gallery_ImageBuilder_h
#define gallery_ImageBuilder_h

#import <Foundation/Foundation.h>

@interface ImageBuilder : NSObject

+ (NSArray *)imagesFromJSON:(NSData *)data error:(NSError **)error;

@end


#endif
