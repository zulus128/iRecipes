//
//  CrossButton.h
//  Recipes_
//
//  Created by Ravis on 30.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrossButton : UIButton{
    UIView *viewToCross;
}

-(id)initWithFrame:(CGRect)frame andViewToCross:(UIView *)view;
-(UIView *)getViewToCross;

@end
