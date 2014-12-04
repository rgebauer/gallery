//
//  ImageBuilder.m
//  gallery
//
//  Created by user26830 on 12/4/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import "ImageBuilder.h"
#import "Image.h"

@implementation ImageBuilder

+ (NSArray *)imagesFromJSON:(NSData *)data error:(NSError **)error
{
    NSError *_error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&_error];
    
    if (_error != nil)
    {
        *error = _error;
        return nil;
    }
    
    NSArray *results = [json valueForKey:@"results"];
    NSLog(@"Count %d", results.count);
    
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    for (NSDictionary *images in results)
    {
        Image *image = [[Image alloc] init];
        
        for (NSString *key in images)
        {
            if ([image respondsToSelector:NSSelectorFromString(key)])
            {
                [image setValue:[images valueForKey:key] forKey:key];
            }
        }
        
        [ret addObject:image];
    }
    
    return ret;
}

@end