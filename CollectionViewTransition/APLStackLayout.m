
#import "APLStackLayout.h"

@interface APLStackLayout ()

@property (nonatomic, readwrite) NSInteger stackCount;
@property (nonatomic, readwrite) CGSize itemSize;
@property (nonatomic, readwrite) NSMutableArray *angles;
@property (nonatomic, readwrite) NSMutableArray *attributesArray;

@end

#pragma mark -

@implementation APLStackLayout

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _stackCount = 5;
        _itemSize = CGSizeMake(150.0, 200.0);
        _angles = [[NSMutableArray alloc] initWithCapacity:self.stackCount * 10];
    }
    return self;
}

- (void)prepareLayout
{
    // Compute the angles for each photo in the stack layout
    //
    // Keep in mind we only display one section in this layout.
    //
    // We use rand() to generate the varying angles, but with always the same seed value
    // so we have consistent angles when calling this method.
    //
    srand(42);
    
    CGSize size = self.collectionView.bounds.size;
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);

    // we only display one section in this layout
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];

    // remove all the old attributes
    [self.angles removeAllObjects];

    CGFloat maxAngle = M_1_PI / 3.0;
    CGFloat minAngle = - M_1_PI / 3.0;
    CGFloat diff = maxAngle - minAngle;

    // compute and add the necessary angles for each photo
    [_angles addObject:@0.0];
    for (NSInteger i = 1; i < self.stackCount * 10; i++)
    {
        CGFloat currentAngle = ((((CGFloat)rand()) / RAND_MAX) * diff) + minAngle;
        [self.angles addObject:[NSNumber numberWithFloat:currentAngle]];
    }

    if (self.attributesArray == nil)
    {
        _attributesArray = [[NSMutableArray alloc] initWithCapacity:itemCount];
    }
    // generate the new attributes array for each photo in the stack
    for (NSInteger i = 0; i < itemCount; i++)
    {
        NSInteger angleIndex = i % (self.stackCount * 10);

        NSNumber *angleNumber = self.angles[angleIndex];
        
        CGFloat angle = angleNumber.floatValue;

        UICollectionViewLayoutAttributes *attributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attributes.size = self.itemSize;
        attributes.center = center;
        attributes.transform = CGAffineTransformMakeRotation(angle);

        if (i > self.stackCount)
        {
            attributes.alpha = 0.0;
        }
        else
        {
            attributes.alpha = 1.0;
        }
        attributes.zIndex = (itemCount - i);

        [self.attributesArray addObject:attributes];
    }
}

- (void)invalidateLayout
{
    [super invalidateLayout];
    _attributesArray = nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect bounds = self.collectionView.bounds;
    return ((CGRectGetWidth(newBounds) != CGRectGetWidth(bounds) ||
            (CGRectGetHeight(newBounds) != CGRectGetHeight(bounds))));
}

- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.attributesArray[indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArray;
}

@end
