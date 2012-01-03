//
//  Pack.h
//  Recipes_
//
//  Created by Ravis on 20.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Pack : NSObject {
    NSNumber *ident;
    NSString *name;
    NSMutableArray *recipes;
    NSMutableArray *videos;
    BOOL reciped;
    
    UIImage *img;
}
@property (nonatomic) BOOL reciped;
@property (nonatomic, retain) NSNumber *ident;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *recipes;
@property (nonatomic, retain) NSMutableArray *videos;
@property (nonatomic, retain) UIImage *img;

-(id)initWithDict:(NSMutableDictionary *)dict withName:(NSString *)keyName;
-(id)initWithPack:(Pack *)otherPack;

@end
