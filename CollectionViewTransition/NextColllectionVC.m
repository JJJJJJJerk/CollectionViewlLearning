
#import "NextColllectionVC.h"
#import "DetailVC.h"
#import "CollectionCell.h"

@implementation NextColllectionVC

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // used tapped a collection view cell, navigate to a detail view controller showing that single photo
    CollectionCell *cell = (CollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.imageView.image != nil)
    {
        // we need to load the main storyboard because this view controller was created programmatically
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        DetailVC *detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
        detailViewController.image = cell.imageView.image;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

@end
