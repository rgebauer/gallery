//
//  MasterViewController.h
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "Image.h"
#import "GalleryManager.h"
#import "GalleryCommunicator.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <GalleryManagerDelegate> {
    NSArray *_images;
    GalleryManager *_manager;
}

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

