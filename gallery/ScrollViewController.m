//
//  ScrollViewController.m
//  gallery
//
//  Created by user26830 on 12/5/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import "ScrollViewController.h"
#import <CoreGraphics/CoreGraphics.h>

#import "Image.h"

@interface ScrollViewController () {
   
}

- (void)centerScrollViewContents;
- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer;
- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer;
@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1
    Image* img = _manager.images[self.imageIndex];
    UIImage *image = img.uiImage;
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = [self centerFrameFromImage:image];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.scrollView addSubview:self.imageView];
    [self.scrollView setZoomScale:1.0f animated:YES];
    
    // 2
    self.navigationBar.alpha = 0.f;
    
    NSLog(@"viewDidLoad image.size: width %f height %f", image.size.width, image.size.height);
    
    // 3
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftFrom:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.scrollView addGestureRecognizer:swipeLeftGestureRecognizer];
    
    UISwipeGestureRecognizer* swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightFrom:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.scrollView addGestureRecognizer:swipeRightGestureRecognizer];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
    self.navigationBar.alpha = 0.f;
    
    self.scrollView.minimumZoomScale = 1.0f;
    self.scrollView.maximumZoomScale = 4.0f;
    self.scrollView.zoomScale = 1;
    [self centerScrollViewContents];
    
    
    //CGRect windowBounds = [[UIScreen mainScreen] bounds];
    
    CGRect newFrame;
    newFrame.origin = _startPoint; // CGPointMake(windowBounds.size.width/2.0f, windowBounds.size.height/2.0f);
    newFrame.size = CGSizeMake(100.0f, 100.0f);
    
    _imageView.frame = newFrame;
    _imageView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.5f delay:0.0f options:0 animations:^{
        _imageView.frame = [self centerFrameFromImage:_imageView.image];
       _imageView.alpha = 1.0f;
        CGAffineTransform transf = CGAffineTransformIdentity;
        _imageView.transform = CGAffineTransformScale(transf, 1.0f, 1.0f);
        
    } completion:^(BOOL finished) {
        [self showNavigationBar];
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideNavigationBar];
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    NSLog(@"centerScrollViewContents boundsSize: width %f height %f", boundsSize.width, boundsSize.height);
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
    
    NSLog(@"centerScrollViewContents self.imageView.frame: x %f y %f width %f height %f", self.imageView.frame.origin.x, self.imageView.frame.origin.y,self.imageView.frame.size.width, self.imageView.frame.size.height);
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    // 1
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // 2
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // 3
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    // 4
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (void)handleSwipeLeftFrom:(UISwipeGestureRecognizer*)recognizer {
   
    if ((self.imageIndex + 1) < _manager.images.count)
    {
        self.imageIndex ++;
        Image* img = _manager.images[self.imageIndex];
        UIImage *image = img.uiImage;
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.frame = [self centerFrameFromImage:image];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.scrollView addSubview:self.imageView];
        [self.scrollView setZoomScale:1.0f animated:YES];
    }
}

- (void)handleSwipeRightFrom:(UISwipeGestureRecognizer*)recognizer {
    if (self.imageIndex > 0)
    {
        self.imageIndex --;
        Image* img = _manager.images[self.imageIndex];
        UIImage *image = img.uiImage;
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.frame = [self centerFrameFromImage:image];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.scrollView addSubview:self.imageView];
        [self.scrollView setZoomScale:1.0f animated:YES];
    }
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //[self showNavigationBar];
    [self centerScrollViewContents];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
}
#pragma mark - Hide and show Navigation bar
- (void) hideNavigationBar {
   _navigationBar.alpha = 0.8f;
   [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
       _navigationBar.alpha = 0.0f;
   } completion:^(BOOL finished) {
       //[_navigationBar removeFromSuperview];
   }];
}

- (void) showNavigationBar {
    _navigationBar.alpha = 0.0f;
    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _navigationBar.alpha = 0.8f;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark Helpers
- (CGRect) centerFrameFromImage:(UIImage*) image {
    if(!image) return CGRectZero;
    
    CGRect windowBounds = self.view.bounds;
    
    NSLog(@"centerFrameFromImage windowBounds: width %f height %f", windowBounds.size.width, windowBounds.size.height);
    
    CGSize newImageSize = [self imageResizeBaseOnWidth:windowBounds
                           .size.width oldWidth:image
                           .size.width oldHeight:image.size.height];
    
    newImageSize.height = MIN(windowBounds.size.height,newImageSize.height);
    return CGRectMake(0.0f, windowBounds.size.height/2 - newImageSize.height/2, newImageSize.width, newImageSize.height);
}

- (CGSize)imageResizeBaseOnWidth:(CGFloat) newWidth oldWidth:(CGFloat) oldWidth oldHeight:(CGFloat)oldHeight {
    CGFloat scaleFactor = newWidth / oldWidth;
    CGFloat newHeight = oldHeight * scaleFactor;
    return CGSizeMake(newWidth, newHeight);
}

- (IBAction)close:(id)sender {
    
    CGRect newFrame;
    newFrame.origin = _startPoint; // CGPointMake(windowBounds.size.width/2.0f, windowBounds.size.height/2.0f);
    newFrame.size = CGSizeMake(100.0f, 100.0f);
   
    [UIView animateWithDuration:0.5f delay:0.0f options:0 animations:^{
        _imageView.frame = newFrame;
        _imageView.alpha = 0.0f;
        CGAffineTransform transf = CGAffineTransformIdentity;
        _imageView.transform = CGAffineTransformScale(transf, 0.1f, 0.1f);
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:NULL];
    }];

}

- (IBAction)share:(id)sender {
    if (self.imageIndex >= _manager.images.count || self.imageIndex < 0)
        return;
    
    Image* image = _manager.images[self.imageIndex];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[image.uiImage] applicationActivities:nil];
    
    [self presentViewController:controller animated:YES completion:nil];
}
@end
