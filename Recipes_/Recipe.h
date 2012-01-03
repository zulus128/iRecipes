//
//  Recipe.h
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Recipe : NSObject {
    NSNumber *ident;
    NSString *name;
    NSString *manufacturer;
    NSString *persons;
    UIImage *ingredsPhoto;
    NSMutableArray *imgs;
    NSMutableArray *steps;
    NSArray *ingredsOrder;
    NSMutableDictionary *ingreds;
    BOOL gotIngrNames;
}
@property (nonatomic) BOOL gotIngrNames;
@property (nonatomic, retain) NSMutableDictionary *ingreds;
@property (nonatomic, retain) NSArray *ingredsOrder;
@property (nonatomic, retain) NSString *manufacturer;
@property (nonatomic, retain) NSNumber *ident;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *persons;
@property (nonatomic, retain) UIImage *ingredsPhoto;
@property (nonatomic, retain) NSMutableArray *imgs;
@property (nonatomic, retain) NSMutableArray *steps;

-(id)initWithDict:(NSMutableDictionary *)dict withStringId:(NSString *)identificator;
-(id)initWithDict:(NSMutableDictionary *)dict withNumberId:(NSNumber *)identificator;
-(id)initWithRecipe:(Recipe *)chosenRecipe;
-(void)getIngrNames;

@end
