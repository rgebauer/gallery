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

@implementation NSString (NSString_Extended)

- (NSString *)urlencode
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i)
    {
        const unsigned char thisChar = source[i];
        if (thisChar == ' ')
        {
            [output appendString:@"%20"];
        }
        else
        {
            [output appendFormat:@"%c", thisChar];
        }
        
    }
    return output;
}
@end

@implementation GalleryCommunicator : NSObject

- (void)searchImages:(NSString*)what
{
    int _step = 10;
    int _from = 1;
    
    //TODO set from, step, convert what to GET URL string
    NSString *str_url = [[NSString stringWithFormat:@"http://obrazky.cz/searchAjax?q=%@&s=&step=%d&size=small&color=any&filter=true&from=%d", what, _step, _from] urlencode];
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