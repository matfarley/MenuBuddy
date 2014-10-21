//
//  MBRecipe.h
//  MenuBuddy
//
//  Created by Matthew Farley on 4/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBRecipe : NSObject
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *recipeName;
@property (nonatomic) int numberOfServes;
@property (strong, nonatomic) NSString *recipeSynopsis;
@property (strong, nonatomic) NSArray *recipeIngredients;
@property (strong, nonatomic) NSArray *recipeSteps;

extern NSString *const KEY_TIME;
extern NSString *const KEY_INSTRUCTION;
extern NSString *const KEY_SUBHEAD;
extern NSString *const KEY_CONTENT;


- (id)initWithTestRecipe;
- (id)initWith:(NSString *)name :(NSString *)ingredients :(NSArray *)steps;
- (NSDictionary *)getCurrentStep;
- (NSDictionary *)getNextStep;
- (NSDictionary *)getPreviousStep;
- (BOOL)hasMoreSteps;

@end

