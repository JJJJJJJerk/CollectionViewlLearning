
@import UIKit;

// we implement our own subclass of UICollectionViewTransitionLayout to help in the transition
// of the cell positions based on gesture position
//
@interface APLTransitionLayout : UICollectionViewTransitionLayout

@property (nonatomic) UIOffset offset;

@end
