//
//  VideosViewController.h
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface VideosViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *main;
    UINavigationController *nc;
}
@property (nonatomic, retain) IBOutlet UIScrollView *main;
@property (nonatomic, retain) UINavigationController *nc;
@property (nonatomic, retain) IBOutlet UIWebView* site;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andNC:(UINavigationController *)navCtl;
- (void)showDialog;

@end
