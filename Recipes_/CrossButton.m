//
//  CrossButton.m
//  Recipes_
//
//  Created by Ravis on 30.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CrossButton.h"

@implementation CrossButton

-(id)initWithFrame:(CGRect)frame andViewToCross:(UIView *)view{
    self=[self initWithFrame:frame];
    viewToCross=view;
    return self;
}

-(UIView *)getViewToCross{
    return viewToCross;
}

@end
