//
//  MBPopOutViewController.m
//  MenuBuddy
//
//  Created by Matthew Farley on 12/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBRecipeInfoViewController.h"

@interface MBRecipeInfoViewController ()

@end

@implementation MBRecipeInfoViewController

@synthesize infoTextView = _infoTextView;
@synthesize recipeInfoText = _recipeInfoText;

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
    [self.infoTextView setText: self.recipeInfoText];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
