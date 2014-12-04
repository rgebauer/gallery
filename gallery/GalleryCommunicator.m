//
//  GalleryCommunicator.m
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GalleryCommunicator.h"
#import "GalleryCommunicatorDelegate.h"

@implementation GalleryCommunicator : NSObject

- (void)searchImages:(NSString*)what
{
    int _step = 20;
    int _from = 21;
    
    //TODO set from, step, convert what to GET URL string
    NSString *str_url = [NSString stringWithFormat:@"http://obrazky.cz/searchAjax?q=%@&s=&step=%d&size=any&color=any&filter=true&from=%d", what, _step, _from];
    NSLog(@"%@", str_url);
    
    NSURL *url = [[NSURL alloc] initWithString:str_url];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url]
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (error)
                               {
                                   [self.delegate receiveFailedWithError:error];
                               }
                               else
                               {
                                   [self.delegate receiveFinished:data];
                               }
                           }];
}

@end