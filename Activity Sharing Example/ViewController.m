//
//  ViewController.m
//  Activity Sharing Example
//
//  Created by David Wilson on 4/01/21.
//

#import "ViewController.h"
#import <LinkPresentation/LPLinkMetadata.h>

@interface ViewController () <UIActivityItemSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)shareAllTheThings:(id)sender
{
//    NSString * text = @"Your text here";
//    NSURL *url = [NSURL URLWithString:@"https://www.apple.com"];
    UIImage * justAnImage = [UIImage imageNamed:@"JustAnImage"];
    
//    NSArray * theItems = @[self, justAnImage, text, url];
    NSArray * theItems = @[self, justAnImage];                   // SELF - big clue, because the protocol UIActivityItemSource is declared in the @interface this now means the protocol procedures are invoked, for example - activityViewController:itemForActivityType: - they are only invoked if SELF is passed into theItems Array.

    UIActivityViewController *controller = [[UIActivityViewController alloc]
                                                    initWithActivityItems:theItems
                                                    applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypeAssignToContact,
                                         UIActivityTypeOpenInIBooks,
                                         UIActivityTypeAddToReadingList];
    
//    controller.popoverPresentationController.barButtonItem = self.theShareButton;
    controller.popoverPresentationController.sourceView = sender;
    controller.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    [self presentViewController:controller animated:YES completion:^{}];
}

#pragma mark UIActivityItemSource protocol procedures to support sharesheet

/// called to fetch data after an activity is selected. you can return nil.
- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

    NSMutableString *text = [NSMutableString stringWithString:@""];
    UIImage * justAnImage = [UIImage imageNamed:@"JustAnImage"];
    NSURL *url = [NSURL URLWithString:@"https://www.apple.com"];
    
    if (activityType == UIActivityTypeAirDrop) {
        return justAnImage;
    } else if (activityType == UIActivityTypeMessage) {
        [text appendFormat:@"#SharingIsCaring The Image you asked for %@ - only for iMessage", url];
        return text;
    } else if (activityType == UIActivityTypeMail) {
        [text appendFormat:@"#SharingIsCaring The Image you asked for %@ - only for Mail", url];
        return text;
    } else if (activityType == UIActivityTypePostToTwitter) {
        [text appendFormat:@"#SharingIsCaring The Image you asked for %@ - only for Twitter", url];
        return text;
    } else
    {
        [text appendFormat:@"#SharingIsCaring DEFAULT The Image you asked for %@", url];
    }
    
    return text;
}

/// called to determine data type. only the class of the return type is consulted. it should match what -itemForActivityType: returns later
- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

    return @"placeholder text - called to determine data type. only the class of the return type is consulted. it should match what -itemForActivityType: returns later";
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType
{
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    if (activityType == UIActivityTypeAirDrop) {
        return @"";
    }
    return @"In caring we share - please accept this gift";
}

- (UIImage *)activityViewController:(UIActivityViewController *)activityViewController
      thumbnailImageForActivityType:(UIActivityType)activityType
                      suggestedSize:(CGSize)size
{
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    if (activityType == UIActivityTypeAirDrop) {
        return nil;
//    } else if (activityType == UIActivityTypeMessage) {
//        return [UIImage imageNamed: @"AppIcon"];
//    } else if (activityType == UIActivityTypeMail) {
//        return [UIImage imageNamed: @"AppIcon"];
//    } else if (activityType == UIActivityTypePostToTwitter) {
//        return [UIImage imageNamed: @"AppIcon"];
//    } else if (activityType == UIActivityTypePostToFacebook) {
//        return [UIImage imageNamed: @"AppIcon"];
    }
    return [UIImage imageNamed: @"AppIcon"];
}

- (LPLinkMetadata *)activityViewControllerLinkMetadata:(UIActivityViewController *)activityViewController API_AVAILABLE(ios(13.0))
{
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));

    UIImage * justAnImage = [UIImage imageNamed:@"JustAnImage"];
    UIImage * theImage = [UIImage imageNamed: @"AppIcon"];
    NSItemProvider * iconProvider = [[NSItemProvider alloc] initWithObject:theImage];
//    NSItemProvider * iconProvider = [[NSItemProvider alloc] initWithObject:justAnImage];
    NSItemProvider * imageProvider = [[NSItemProvider alloc] initWithObject:justAnImage];
    LPLinkMetadata * metaData = [[LPLinkMetadata alloc] init];
    metaData.title = @"This title shows we care";
//    metaData.originalURL = [NSURL URLWithString:@"https://www.apple.com"];
//    metaData.URL = [NSURL URLWithString:@"https://www.apple.com"];
    metaData.iconProvider = iconProvider;
    metaData.imageProvider = imageProvider;

    return metaData;
}





@end
