//
//  MyNavController.m
//  Recipes_
//
//  Created by Ravis on 03.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyNavController.h"
#import "OneRecipeViewController.h"

@implementation MyNavController

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return [[self topViewController] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

-(id)initwithUINavigationController:(UINavigationController *)nc{
    self=[self init];
    self.title=nc.title;
    self.viewControllers=nc.viewControllers;
    return self;
}

@end
