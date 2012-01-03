//
//  OneRecipeViewController.h
//  Recipes_
//
//  Created by Ravis on 22.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Recipe.h"
#import "Pack.h"
#import "CrossButton.h"

@interface OneRecipeViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    Recipe *curRecipe;
    UIView *currentCrossView;
    CrossButton *currentCrossBtn;
    IBOutlet UIScrollView *mainView;
    IBOutlet UIScrollView *rotatedView;
    IBOutlet UIImageView *ingredientsPhoto;
    IBOutlet UIPageControl *dotControl;
    IBOutlet UIButton *hideBtn;
    
    BOOL currentlyWorking;
    BOOL firstLoad;
    NSUInteger prevValueOfDotController;
    BOOL spinOrNot;
    BOOL allowedToRotate;
    BOOL allowedToSpinBack;
}

@property (nonatomic, retain) Recipe *curRecipe;
@property (nonatomic, retain) UIScrollView *mainView;
@property (nonatomic, retain) UIScrollView *rotatedView;
@property (nonatomic, retain) UIPageControl *dotControl;
@property (nonatomic, retain) UIImageView *ingredientsPhoto;
@property (nonatomic, retain) UIButton *hideBtn;
@property (nonatomic) BOOL allowedToRotate;
@property (nonatomic) BOOL allowedToSpinBack;

-(void)roundEmUp:(UIView *)view borderRadius:(float)radius borderWidth:(float)border
           color:(CGColorRef)color;
-(id)initWithRecipe:(Recipe *)chosenRecipe;
+(CGSize) physycalSizeOfScreen:(UIScreen *)scr;
-(IBAction)dotControlValueChange:(id)sender;
@end
