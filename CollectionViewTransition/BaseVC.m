
#import "BaseVC.h"
#import "APLTransitionLayout.h"
#import "CollectionCell.h"

#define USE_IMAGES   1  // if 1 images are used for each cell, if 0 we use varying UIColors swatches for each cell

#define MAX_COUNT    24
#define CELL_ID      @"CELL_ID"


#pragma mark -

@implementation BaseVC

- (id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout])
    {
        // make sure we know about our cell prototype so dequeueReusableCellWithReuseIdentifier can work
        [self.collectionView registerClass:[APLCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    
#if USE_IMAGES
    // set the cell to use an image
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sa%ld.jpg", (long)indexPath.item]];
#else
    // set the cell to use a color swatch
    CGFloat hue = ((CGFloat)indexPath.item)/MAX_COUNT;
    UIColor *cellColor = [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:1.0];
    cell.contentView.backgroundColor = cellColor;
#endif
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MAX_COUNT;
}

- (UICollectionViewController *)nextViewControllerAtPoint:(CGPoint)p
{
    return nil; // subclass must override this method
}

// return our own UICollectionViewTransitionLayout object subclass to help in the transition
// the cell positions based on gesture position
//
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout
{
    APLTransitionLayout *myCustomTransitionLayout =
        [[APLTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return myCustomTransitionLayout;
}

@end
