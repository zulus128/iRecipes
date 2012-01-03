//
//  OnePackViewController.h
//  Recipes_
//
//  Created by Ravis on 21.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Pack.h"
#import "Recipe.h"

@interface OnePackViewController : UIViewController  {
    Pack *curPack;
    
    UIScrollView *mainView;
}
@property (nonatomic, retain) IBOutlet UIScrollView *mainView;
@property (nonatomic, retain) Pack *curPack;
-(id)initWithPack:(Pack *)aPack reciped:(BOOL)idsOrNot;
-(void)roundEmUp:(UIView *)view borderRadius:(float)radius borderWidth:(float)border
            color:(CGColorRef)color;
@end
