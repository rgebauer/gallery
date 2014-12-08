//
//  ViewController.m
//  TEST
//
//  Created by user26830 on 12/5/14.
//  Copyright (c) 2014 user26830. All rights reserved.
//

#import "ViewController.h"

#import <Foundation/Foundation.h>

#import "Image.h"
#import "GalleryManager.h"
#import "GalleryCommunicator.h"
#import "ViewController.h"
#import "ImageCell.h"
#import "ScrollViewController.h"
#import "CustomSegue.h"

@interface ViewController () <UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GalleryManagerDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    GalleryManager *_manager;
    NSInteger fromIndex;
}

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, weak) IBOutlet UISearchBar *searchBar;
@end

@implementation ViewController


- (void)viewDidLoad
{
    /*
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
     */
    
    [super viewDidLoad];
    
    [self.activityIndicator stopAnimating];
    //_searchBar.text = @"ios developer";
    fromIndex = 1;
    
    _manager = [[GalleryManager alloc] init];
    _manager.communicator = [[GalleryCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    
    //[_manager search:_searchBar.text];
}


#pragma mark - search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
     //NSLog(@"Search text did changed: %@", searchText);
     //[_manager search:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     //NSLog(@"Search text button clicked: %@", searchBar.text);
    fromIndex = 1;
    [self.activityIndicator startAnimating];
    [_manager search:searchBar.text from:fromIndex];
    
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

#pragma mark - GalleryManagerDelegate

- (void)didReceiveImages{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView setContentOffset:CGPointZero animated:NO];
        [self.collectionView reloadData];
        [self.activityIndicator stopAnimating];
        
    });
}

- (void)fetchingImagesFailedWithError:(NSError *)error {
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}
#pragma mark - collection view data source

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _manager.images.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    Image *image = _manager.images[indexPath.row];
    [cell setImage:image];
    
    cell.contentMode = UIViewContentModeScaleAspectFill;
    cell.clipsToBounds = YES;
    
    //TODO do infinite scrolling one direction (range offsets from 1-10000,...) + remove previous image items
    if (indexPath.item == _manager.images.count- 1 && fromIndex < 9980)
    {
        fromIndex += 20;
        [self.activityIndicator startAnimating];
        [_manager search:_searchBar.text from:fromIndex];
    }
   
    
    return cell;
}


- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark - collection view delegate

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showImage"])
    {
        /*
        if([segue isKindOfClass:[CustomSegue class]]) {
            ImageCell* imageCell = (ImageCell*)sender;
            ((CustomSegue *)segue).startPoint = imageCell.center;
        }
         */
        
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        ScrollViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
       
        destViewController.imageIndex = indexPath.row;
        destViewController.startPoint =[(ImageCell*)sender center];
        destViewController.manager = _manager;
    
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
