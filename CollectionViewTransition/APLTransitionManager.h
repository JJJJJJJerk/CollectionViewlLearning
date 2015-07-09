@import UIKit;

@protocol APLTransitionManagerDelegate <NSObject>
- (void)interactionBeganAtPoint:(CGPoint)p;
@end

#pragma mark -

@interface APLTransitionManager : NSObject
    <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic) id <APLTransitionManagerDelegate> delegate;
@property (nonatomic) BOOL hasActiveInteraction;
@property (nonatomic) UINavigationControllerOperation navigationOperation;
@property (nonatomic) UICollectionView *collectionView;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end
