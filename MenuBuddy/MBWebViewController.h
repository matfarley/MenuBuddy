//
//  MBWebViewController.h
//  MenuBuddy
//
//  Created by Matthew Farley on 18/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBRecipe.h"

@interface MBWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *mbWebView;
@property (strong, nonatomic)MBRecipe *recipe;
@property (strong, nonatomic)NSString *dataToShow;

extern NSString *const DATA_TO_SHOW_RECIPE_STEPS;
extern NSString *const DATA_TO_SHOW_RECIPE_INGREDIENTS;
@end
