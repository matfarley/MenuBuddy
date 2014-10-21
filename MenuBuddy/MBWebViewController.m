//
//  MBWebViewController.m
//  MenuBuddy
//
//  Created by Matthew Farley on 18/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBWebViewController.h"
#import "MBCountdownTimerButton.h"

@interface MBWebViewController ()

@end

@implementation MBWebViewController

@synthesize mbWebView = _mbWebView;
@synthesize recipe = _recipe;
@synthesize dataToShow = _dataToShow;

NSString *const DATA_TO_SHOW_RECIPE_STEPS = @"DATA_TO_SHOW_RECIPE_STEPS";
NSString *const DATA_TO_SHOW_RECIPE_INGREDIENTS = @"DATA_TO_SHOW_RECIPE_INGREDIENTS";

NSString *const OPENING_HTML = @"<html>";
NSString *const CLOSING_HTML = @"</html>";
NSString *const OPENING_HEAD = @"<head>";
NSString *const CLOSING_HEAD = @"</head>";
NSString *const CSS =
@"<style media=\"screen\" type=\"text/css\"> body {font-family: \"Helvetica Neue\", Helvetica, Arial;} p {font-weight: bold;}</style>";



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.recipe){
        [self.mbWebView loadHTMLString:[self buildHTMLStringwithRecipe:self.recipe] baseURL:nil];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)buildHTMLStringwithRecipe:(MBRecipe *)recipe{
    // Testing
    NSString * result;
    NSString * bodyContent = @"";
    if ([self.dataToShow isEqualToString:DATA_TO_SHOW_RECIPE_INGREDIENTS]){
        for (NSDictionary *dic in recipe.recipeIngredients){
            if ([dic objectForKey:KEY_SUBHEAD]){
                bodyContent = [bodyContent stringByAppendingString:
                 [NSString stringWithFormat:@"<p>%@</p>",[dic objectForKey:KEY_SUBHEAD]]];
            }
            if ([dic objectForKey:KEY_CONTENT]){
                bodyContent = [bodyContent stringByAppendingString:@"<ul>"];
                NSArray *arr = [dic objectForKey:KEY_CONTENT];
                for (NSString *s in arr){
                    bodyContent = [bodyContent stringByAppendingString:
                     [NSString stringWithFormat:@"<li>%@</li>",s]];
                }
                bodyContent = [bodyContent stringByAppendingString:@"</ul>"];
            }
        }
        result = [NSString stringWithFormat:@"<html><head>%@<body>%@</body></head></html>", CSS, bodyContent];
    } else if ([self.dataToShow isEqualToString:DATA_TO_SHOW_RECIPE_STEPS]){
        bodyContent = [bodyContent stringByAppendingString:@"<ol>"];
        for (NSDictionary *dic in recipe.recipeSteps){
            if ([dic objectForKey:KEY_INSTRUCTION]){
                bodyContent = [bodyContent stringByAppendingString:
                               [NSString stringWithFormat:@"<li>%@ (%@)</li>",[dic objectForKey:KEY_INSTRUCTION],
                                [MBCountdownTimerButton stringFromRawSeconds:((NSNumber *)[dic objectForKey:KEY_TIME]).intValue ]]];
            }
        }
        bodyContent = [bodyContent stringByAppendingString:@"</ol>"];
        
        result = [NSString stringWithFormat:@"<html><head>%@<body>%@</body></head></html>", CSS, bodyContent];
    }
    return result;
}

@end
