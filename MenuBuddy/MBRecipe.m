//
//  MBRecipe.m
//  MenuBuddy
//
//  Created by Matthew Farley on 4/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBRecipe.h"
@interface MBRecipe()

@property (nonatomic) int currentStepIndex;

@end

@implementation MBRecipe
@synthesize icon = _icon;
@synthesize recipeName = _recipeName;
@synthesize numberOfServes = _numberOfServes;
@synthesize recipeSynopsis = _recipeSynopsis;
@synthesize recipeIngredients = _recipeIngredients;
@synthesize recipeSteps = _recipeSteps;

NSString *const KEY_TIME = @"time";
NSString *const KEY_INSTRUCTION = @"instruction";
NSString *const KEY_SUBHEAD = @"Subhead";
NSString *const KEY_CONTENT = @"Content";
NSString *const KEY_ORDER = @"order";


- (id)initWithTestRecipe {
    self = [super init];
    if (self){
        [self setTestRecipe];
    }
    return self;
}


- (id)initWith:(NSData *)data{
    self = [super init];
    if (self){
        self.currentStepIndex = 0;
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
//        self.recipeName = name;
//        self.recipeIngredients = ingredients;
//        // each step is a map i.e @{ order : <value>, time : <value> , instruction : <value>}
//        self.recipeSteps = steps;
    }
    return self;
}

- (void)setTestRecipe {
    self.currentStepIndex = 0;
    self.recipeName = @"Nacho Pie";
    self.numberOfServes = 4;
    self.icon = [UIImage imageNamed:@"machoPie"];
    self.recipeIngredients = @[
                     @{KEY_SUBHEAD : @"For the Nachos:",
                       KEY_CONTENT:@[@"Natural corn chips (as many as you want)",
                                    @"500g minced beef",
                                    @"1 onion (chopped)",
                                    @"3 cloves garlic (crushed)",
                                     @"2 teaspoons each of smoked paprika and ground cumin",
                                     @"1 teaspoon ground coriander",
                                     @"3 chillies (chopped)",
                                     @"400gm each of caned tomatoes (chopped)",
                                     @"red kidney beans (drained)",
                                     @"2 cups beef stock"]
                       },
                     @{KEY_SUBHEAD : @"For the Salsa:",
                       KEY_CONTENT :@[@"1 cup roasted capsicum (sliced)",
                                      @"1 avocado (sliced)",
                                      @"1 cucumber (diced)",
                                      @"Coriander (chopped)",
                                      @"Lime juice (squeezed)",
                                      @"Salt, pepper and oil on hand"]
                       }
                     ];
    
    self.recipeSteps = @[
                        @{@"order" : [NSNumber numberWithInt:0],
                          KEY_TIME : [NSNumber numberWithInt:80],
                          KEY_INSTRUCTION : @"Preheat oven to 180°C"},
                        @{@"order" : [NSNumber numberWithInt:2],
                          KEY_TIME : [NSNumber numberWithInt:15],
                          KEY_INSTRUCTION : @"Heat little bit of oil in a large frying pan, set to 7/10"},
                        @{@"order" : [NSNumber numberWithInt:3],
                          KEY_TIME : [NSNumber numberWithInt:19],
                          KEY_INSTRUCTION : @"Add mince, onion and garlic and stir"}];
   
}

- (NSDictionary *)getCurrentStep{
    if (self.currentStepIndex <= self.recipeSteps.count && self.currentStepIndex >= 0){
        return self.recipeSteps[self.currentStepIndex];
    } else {
        return nil;
    }
}

- (NSDictionary *)getNextStep{
    self.currentStepIndex++;
    return [self getCurrentStep];
}

- (NSDictionary *)getPreviousStep{
    if (self.currentStepIndex != 0){
        self.currentStepIndex--;
    }
    return [self getCurrentStep];
}

- (BOOL)hasMoreSteps{
    if (self.currentStepIndex < [self.recipeSteps indexOfObject:self.recipeSteps.lastObject]){
        return YES;
    } else {
        return NO;
    }
}

@end
