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
@property (nonatomic, strong) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) UIImageView *imageView;

@property NSInteger imageIndex;
@property CGPoint startPoint;
@property (nonatomic, weak) GalleryManager* manager;

- (IBAction)close:(id)sender;
- (IBAction)share:(id)sender;

- (CGRect) centerFrameFromImage:(UIImage*) image;

@end
