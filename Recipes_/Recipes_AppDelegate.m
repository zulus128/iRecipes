//
//  Recipes_AppDelegate.m
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Recipes_AppDelegate.h"
#import "Recipes_ViewController.h"
#import "VideosViewController.h"
#import "AnonsViewController.h"
#import "MoreViewController.h"
#import "Pack.h"
#import "Recipe.h"
#import "MyNavController.h"
#import "OneRecipeViewController.h"

@implementation Recipes_AppDelegate


@synthesize window=_window;
@synthesize viewController=_viewController;
@synthesize tbc;
@synthesize mtbc;

-(MyNavController *)createNC:(UINavigationController *)NC{
    if (![NC.title compare:@"Back"]){
        Recipes_ViewController *VC=[[Recipes_ViewController alloc] initWithNibName:@"Recipes_ViewController" bundle:nil];
        NC.viewControllers=[NSArray arrayWithObject:VC];
        NC.title=NSLocalizedString(@"Рецепты", @"Рецепты");
        [VC release];
    }
    else if (![NC.title compare:@"Videos"]){
        VideosViewController *VC=[[VideosViewController alloc] initWithNibName:@"VideosViewController" bundle:nil andNC:NC];
        NC.viewControllers=[NSArray arrayWithObject:VC];
        NC.title=NSLocalizedString(@"О проекте", @"О проекте");
        [VC release];
    }
    else if (![NC.title compare:@"Anons"]){
        AnonsViewController *VC=[[AnonsViewController alloc] initWithNibName:@"AnonsViewController" bundle:nil andNC:NC];
        NC.viewControllers=[NSArray arrayWithObject:VC];
        NC.title=NSLocalizedString(@"Анонс", @"Анонс");
        [VC release];
    }
    else if (![NC.title compare:@"More"]){
        MoreViewController *VC=[[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil andNC:NC];
        NC.viewControllers=[NSArray arrayWithObject:VC];
        NC.title=NSLocalizedString(@"Our thanks", @"Our thanks");
        [VC release];
    }
    MyNavController *myNC=[[[MyNavController alloc] initwithUINavigationController:NC] autorelease];
    return myNC;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //====создание VC для навигаций в каждой вкладке таб бара
    NSArray *VCs=self.tbc.viewControllers;
    NSMutableArray *finalVCs=[[NSMutableArray alloc] init];
    UINavigationController *eachNC;
    for (eachNC in VCs){
        MyNavController *eachMyNC;
        eachMyNC=[self createNC:eachNC];
        NSLog(@"test - %i", [eachMyNC.childViewControllers count]);
        [finalVCs addObject:eachMyNC];
    }
    [self.tbc setViewControllers:finalVCs];
    [finalVCs release];
    [self.tbc setTitle:@"TBC"];
    mtbc=[[MyTabBarController alloc] initWithUITabBarController:tbc];
    [mtbc setTitle:@"MyTBC"];
    // Override point for customization after application launch.
    self.window.rootViewController = mtbc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [mtbc release];
    [tbc release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
