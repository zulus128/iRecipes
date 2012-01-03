//
//  Pack.m
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Pack.h"


@implementation Pack
@synthesize name, ident, recipes, videos, img, reciped;

-(id)initWithDict:(NSMutableDictionary *)dict withName:(NSString *)keyName{
    self.name=keyName;
    self.ident=[NSNumber numberWithInt:[[dict objectForKey:@"id"] intValue]];
    self.img=[UIImage imageNamed:[dict objectForKey:@"img"]];
    self.recipes=[dict objectForKey:@"recipes"];
    self.videos=[dict objectForKey:@"videos"];
    self.reciped=NO;
    return self;
}

-(id)initWithPack:(Pack *)otherPack{

    self.name=otherPack.name;
    self.ident=otherPack.ident;
    self.reciped=otherPack.reciped;
    self.recipes=otherPack.recipes;
    self.videos=otherPack.videos;
    self.img=otherPack.img;
    return self;
}

@end
