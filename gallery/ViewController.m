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

@interface ViewController () <UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GalleryManagerDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    GalleryManager *_manager;
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
    
    _searchBar.text = @"ios developer";
    
    _manager = [[GalleryManager alloc] init];
    _manager.communicator = [[GalleryCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    [_manager search:_searchBar.text];
}


- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark - search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
     NSLog(@"Search text did changed: %@", searchText);
     //[_manager search:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     NSLog(@"Search text button clicked: %@", searchBar.text);
     [_manager search:searchBar.text];
    
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
      [self.searchBar resignFirstResponder];
}

#pragma mark - GalleryManagerDelegate

- (void)didReceiveImages{
    [self.collectionView setContentOffset:CGPointZero animated:NO];
    [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
   
    
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
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        ScrollViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
       
        destViewController.imageIndex = indexPath.row;
        destViewController.manager = _manager;
    
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
