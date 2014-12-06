//
//  ScrollViewController.h
//  gallery
//
//  Created by user26830 on 12/5/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryManager.h"

@interface ScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property NSInteger imageIndex;
@property (nonatomic, weak) GalleryManager* manager;

- (IBAction)close:(id)sender;
- (IBAction)share:(id)sender;

@end
