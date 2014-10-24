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
NSString *const KEY_SUBHEAD = @"subhead";
NSString *const KEY_CONTENT = @"content";
NSString *const KEY_ORDER = @"order";

//JSON constants
NSString *const KEY_JSON_RECIPE_NAME = @"recipeName";
NSString *const KEY_JSON_SERVES = @"numberOfServes";
NSString *const KEY_JSON_INGREDIENTS = @"recipeIngredients";
NSString *const KEY_JSON_ICON_NAME = @"iconName";
NSString *const KEY_JSON_RECIPE_STEPS = @"recipeSteps";


//- (id)initWithTestRecipe {
//    self = [super init];
//    if (self){
//        [self setTestRecipe];
//    }
//    return self;
//}

- (id)initWithFile:(NSString *)file{
    self = [super init];
    if (self){
        NSString *filePath =[[NSBundle mainBundle] pathForResource:file ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        [self setPropertiesWithJsonObject:json];
    }
    return self;
}

- (id)initWithJsonObject:(NSDictionary *)json{
    self = [super init];
    if (self){
        [self setPropertiesWithJsonObject:json];
    }
    return self;
}

- (void)setPropertiesWithJsonObject:(NSDictionary *)json{
    
    self.currentStepIndex = 0;
    
    if ([json objectForKey:KEY_JSON_RECIPE_NAME] && ![[json objectForKey:KEY_JSON_RECIPE_NAME]isEqualToString:@""]){
        self.recipeName = [json objectForKey:KEY_JSON_RECIPE_NAME];
    }
    
    // Bad, but will pass for this iteration.
    if ([json objectForKey:KEY_JSON_ICON_NAME] && ![[json objectForKey:KEY_JSON_ICON_NAME]isEqualToString:@""]){
        self.icon = [UIImage imageNamed:[json objectForKey:KEY_JSON_ICON_NAME]];
    }
    
    if ([json valueForKey:KEY_JSON_SERVES] && ((NSNumber *)[json valueForKey:KEY_JSON_SERVES]).intValue > 0){
        self.numberOfServes = ((NSNumber *)[json valueForKey:KEY_JSON_SERVES]).intValue;
    }
    
    if ([json objectForKey:KEY_JSON_INGREDIENTS] && [((NSArray *)[json objectForKey:KEY_JSON_INGREDIENTS]) count] > 0){
        self.recipeIngredients = [json objectForKey:KEY_JSON_INGREDIENTS];
    }
    
    if ([json objectForKey:KEY_JSON_RECIPE_STEPS] && [((NSArray *)[json objectForKey:KEY_JSON_RECIPE_STEPS]) count] > 0){
        self.recipeSteps = [json objectForKey:KEY_JSON_RECIPE_STEPS];
    }
}

//- (void)setTestRecipe {
//    self.currentStepIndex = 0;
//    self.recipeName = @"Nacho Pie";
//    self.numberOfServes = 4;
//    self.icon = [UIImage imageNamed:@"machoPie"];
//    self.recipeIngredients = @[
//                     @{KEY_SUBHEAD : @"For the Nachos:",
//                       KEY_CONTENT:@[@"Natural corn chips (as many as you want)",
//                                    @"500g minced beef",
//                                    @"1 onion (chopped)",
//                                    @"3 cloves garlic (crushed)",
//                                     @"2 teaspoons each of smoked paprika and ground cumin",
//                                     @"1 teaspoon ground coriander",
//                                     @"3 chillies (chopped)",
//                                     @"400gm each of caned tomatoes (chopped)",
//                                     @"red kidney beans (drained)",
//                                     @"2 cups beef stock"]
//                       },
//                     @{KEY_SUBHEAD : @"For the Salsa:",
//                       KEY_CONTENT :@[@"1 cup roasted capsicum (sliced)",
//                                      @"1 avocado (sliced)",
//                                      @"1 cucumber (diced)",
//                                      @"Coriander (chopped)",
//                                      @"Lime juice (squeezed)",
//                                      @"Salt, pepper and oil on hand"]
//                       }
//                     ];
//    
//    self.recipeSteps = @[
//                        @{@"order" : [NSNumber numberWithInt:0],
//                          KEY_TIME : [NSNumber numberWithInt:80],
//                          KEY_INSTRUCTION : @"Preheat oven to 180°C"},
//                        @{@"order" : [NSNumber numberWithInt:1],
//                          KEY_TIME : [NSNumber numberWithInt:15],
//                          KEY_INSTRUCTION : @"Heat little bit of oil in a large frying pan, set to 7/10"},
//                        @{@"order" : [NSNumber numberWithInt:2],
//                          KEY_TIME : [NSNumber numberWithInt:19],
//                          KEY_INSTRUCTION : @"Add mince, onion and garlic and stir"}];
//   
//}

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
