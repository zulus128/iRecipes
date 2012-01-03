//
//  MyTabBarController.h
//  Recipes_
//
//  Created by Ravis on 30.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarController : UITabBarController <UITabBarControllerDelegate>{
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

-(id)initWithUITabBarController:(UITabBarController *)tbc;

-(void)cleanSubviews;

@end
