//
//  Recipes_ViewController.h
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define BASE_FONT @"SegoePrint"
#define BASE_FONT_BOLD @"SegoePrint-Bold"

@interface Recipes_ViewController : UIViewController {
    UIScrollView *mainView;
    UIImageView *splashScreenView;
    UINavigationController *nc;
    
    NSMutableArray *packs;
}
@property (nonatomic, retain) IBOutlet UIImageView *splashScreenView;
@property (nonatomic, retain) IBOutlet UIScrollView *mainView;
@property (nonatomic, retain) NSMutableArray *packs;
@property (nonatomic, retain) UINavigationController *nc;

-(void)roundEmUp:(UIView *)view borderRadius:(float)radius borderWidth:(float)border
           color:(CGColorRef)color;

@end
