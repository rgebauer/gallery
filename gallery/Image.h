//
//  Image.h
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#ifndef gallery_Image_h
#define gallery_Image_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Image : NSObject

@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) UIImage* uiImage;
@property (strong, nonatomic) NSString* altText;

@end
#endif
