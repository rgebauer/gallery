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

+(NSArray *)imagesFromJSON:(NSData *)data error:(NSError **)error
{
    NSString *unformattedData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"%@", unformattedData);
    
    NSLog(@"%d", [NSJSONSerialization isValidJSONObject:data]);
    
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    
    //TODO HACK for UNFORMATTED RESPONSE DATA INVALID JSON !!!!
    NSRange searchRange = NSMakeRange(0,unformattedData.length);
    NSRange foundRange;
    
    dispatch_group_t group = dispatch_group_create();
    
    while (searchRange.location < unformattedData.length)
    {
        searchRange.length = unformattedData.length-searchRange.location;
        foundRange = [unformattedData rangeOfString:@"data-dot=" options:nil range:searchRange];
        if (foundRange.location != NSNotFound)
        {
            searchRange.location = foundRange.location+foundRange.length+2;
            
            NSString *substr = [unformattedData substringFromIndex:searchRange.location];
            //NSLog(@"%@", substr);
            NSRange r2 = [substr rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString:@"\""]];
            NSString *s1 = [substr substringToIndex:r2.location-1];
            
            NSLog(@"%@", s1);
            
            Image *image = [[Image alloc] init];
            image.url = s1;
            
            //load images
            NSURL *imageURL = [NSURL URLWithString:image.url];
            
            dispatch_group_enter(group);
           
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    image.uiImage = [UIImage imageWithData:imageData]; //image.uiImage = [UIImage imageNamed:@"photo-frame-2"];
                    
                    [ret addObject:image];
                    dispatch_group_leave(group);
                });
            });
            
            
        }
        else
        {
            break;
        }
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    /*
    Domain=NSCocoaErrorDomain Code=3840 "The operation couldn’t be completed. (Cocoa error 3840.)" (Invalid escape sequence around character 863.) UserInfo=0x7fbadac60690 {NSDebugDescription=Invalid escape sequence around character 863.}; The operation couldn’t be completed. (Cocoa error 3840.)    
     
    NSError *_error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&_error];
    
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
    */
    
    return ret;
}

@end