//
//  Recipe.m
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Recipe.h"


@implementation Recipe
@synthesize name, ident, imgs, steps, manufacturer, ingreds, gotIngrNames, ingredsPhoto, ingredsOrder, persons;

-(id)initWithDict:(NSMutableDictionary *)dict withStringId:(NSString *)identificator{
    self.ident=[NSNumber numberWithInt:[identificator intValue]];
    self.name=[dict objectForKey:@"name"];
    self.manufacturer=[dict objectForKey:@"manufacturer"];
    self.imgs=[dict objectForKey:@"imgs"];
    self.steps=[dict objectForKey:@"steps"];
    self.ingreds=[dict objectForKey:@"ingredients"];
    self.gotIngrNames=NO;
    self.ingredsPhoto=[UIImage imageNamed:[dict objectForKey:@"ingredsPhoto"]];
    self.ingredsOrder=[dict objectForKey:@"ingreds_order"];
    self.persons=[dict objectForKey:@"persons"];
    return self;
}

-(id)initWithDict:(NSMutableDictionary *)dict withNumberId:(NSNumber *)identificator{
    self.ident=identificator;
    self.name=[dict objectForKey:@"name"];
    self.manufacturer=[dict objectForKey:@"manufacturer"];
    self.imgs=[dict objectForKey:@"imgs"];
    self.steps=[dict objectForKey:@"steps"];
    self.ingreds=[dict objectForKey:@"ingredients"];
    self.gotIngrNames=NO;
    self.ingredsPhoto=[UIImage imageNamed:[dict objectForKey:@"ingredsPhoto"]];
    self.ingredsOrder=[dict objectForKey:@"ingreds_order"];
    self.persons=[dict objectForKey:@"persons"];
    return self;
}

-(id)initWithRecipe:(Recipe *)chosenRecipe{
    self.ident=chosenRecipe.ident;
    self.imgs=chosenRecipe.imgs;
    self.name=chosenRecipe.name;
    self.steps=chosenRecipe.steps;
    self.manufacturer=chosenRecipe.manufacturer;
    self.ingreds=chosenRecipe.ingreds;
    self.gotIngrNames=chosenRecipe.gotIngrNames;
    self.ingredsPhoto=chosenRecipe.ingredsPhoto;
    self.ingredsOrder=chosenRecipe.ingredsOrder;
    self.persons=chosenRecipe.persons;
    return self;
}

-(void)getIngrNames{
    if (self.gotIngrNames) 
        return;
    NSString *ingredsPath=[[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"plist"];
    NSMutableDictionary *ingredsDict=[[NSMutableDictionary alloc] initWithContentsOfFile:ingredsPath];
    NSArray *allNames=[self.ingreds allKeys];
    NSString *eachKey;
    for (eachKey in allNames){
        NSString *ingrName=[ingredsDict objectForKey:eachKey];
        NSString *ingredsNum=[NSString stringWithString:[self.ingreds objectForKey:eachKey]];
        [self.ingreds removeObjectForKey:eachKey];
        [self.ingreds setObject:ingredsNum forKey:ingrName];
        NSLog(@"Replaced %@ with %@",eachKey,ingrName);
    }
    self.gotIngrNames=YES;
    [ingredsDict release];
}

@end
