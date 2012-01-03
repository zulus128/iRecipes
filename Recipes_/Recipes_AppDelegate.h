//
//  Recipes_AppDelegate.h
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTabBarController.h"

@class Recipes_ViewController;

@interface Recipes_AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UITabBarController *tbc;
    MyTabBarController *mtbc;
}
@property (nonatomic, retain) IBOutlet UITabBarController *tbc;
@property (nonatomic, retain) IBOutlet MyTabBarController *mtbc;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Recipes_ViewController *viewController;

@end
