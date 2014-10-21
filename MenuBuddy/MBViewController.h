//
//  MBViewController.h
//  MenuBuddy
//
//  Created by Matthew Farley on 23/09/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCircleButton.h"
#import "MBRecipe.h"
#import "MBCountdownTimerButton.h"
#import <AVFoundation/AVFoundation.h>

@interface MBViewController : UIViewController <AVSpeechSynthesizerDelegate>
@property (strong, nonatomic)MBRecipe *recipe;
@property (weak, nonatomic) IBOutlet UIButton *showRecipeStepsButton;
@property (weak, nonatomic) IBOutlet UIButton *showIngredientsListButton;
@property (weak, nonatomic) IBOutlet MBCountdownTimerButton *startStopButton;
@property (weak, nonatomic) IBOutlet MBCircleButton *backAStepButton;
@property (weak, nonatomic) IBOutlet MBCircleButton *forwardAStepButton;
@property (weak, nonatomic) IBOutlet UITextView *currentStepTextView;
- (IBAction)buttonCLick:(MBCircleButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;



@end
