//
//  DetailViewController.h
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

