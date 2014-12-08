//
//  CustomSegue.m
//  gallery
//
//  Created by user26830 on 12/7/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import "CustomSegue.h"
#import "ViewController.h"
#import "ScrollViewController.h"

@implementation CustomSegue

- (void)perform {
    ViewController *sourceViewController = self.sourceViewController;
    ScrollViewController *destinationViewController = self.destinationViewController;
    
    [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL];
}

@end
