//
//  ViewController.m
//  TEST
//
//  Created by user26830 on 12/5/14.
//  Copyright (c) 2014 user26830. All rights reserved.

#import "ImageCell.h"


@interface ImageCell ()
@property(nonatomic, weak) IBOutlet UIImageView *imageView;
@property(nonatomic, weak) IBOutlet UILabel *detailText;

@end

@implementation ImageCell

- (void) setImage:(Image *)image
{
    _image = image;
    self.imageView.image = _image.uiImage;
    self.detailText.text = _image.altText;
}

@end
