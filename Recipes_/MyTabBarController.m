//
//  MyTabBarController.m
//  Recipes_
//
//  Created by Ravis on 30.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyTabBarController.h"
#import "Recipes_ViewController.h"
#import "OneRecipeViewController.h"
#import "MyNavController.h"

@implementation MyTabBarController

-(void)cleanSubviews{
    NSArray *subs=self.view.subviews;
    for (NSUInteger i=0;i<[subs count];i++){
        if ([[subs objectAtIndex:i] tag]==1993){
            [[subs objectAtIndex:i] removeFromSuperview];
            i--;
        }
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

-(id)initWithUITabBarController:(UITabBarController *)tbc{
    self=[self init];
    self.viewControllers=tbc.viewControllers;
    return self;
}

@end
