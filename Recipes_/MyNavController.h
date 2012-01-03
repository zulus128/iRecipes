//
//  MyNavController.h
//  Recipes_
//
//  Created by Ravis on 03.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavController : UINavigationController <UINavigationControllerDelegate>{
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

-(id)initwithUINavigationController:(UINavigationController *)nc;

@end
