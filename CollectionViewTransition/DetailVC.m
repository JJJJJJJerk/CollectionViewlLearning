
#import "DetailVC.h"

@interface DetailVC ()
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@end

#pragma mark -

@implementation DetailVC

- (void)viewWillAppear:(BOOL)animated
{
    // setup our image view if an image was set to this view controller
    self.imageView.image = self.image;
}

@end
