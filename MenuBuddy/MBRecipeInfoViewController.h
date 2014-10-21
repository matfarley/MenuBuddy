//
//  MBPopOutViewController.h
//  MenuBuddy
//
//  Created by Matthew Farley on 12/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBRecipeInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (strong, nonatomic)NSString *recipeInfoText;

@end
