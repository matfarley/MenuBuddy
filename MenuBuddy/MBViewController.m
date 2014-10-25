//
//  MBViewController.m
//  MenuBuddy
//
//  Created by Matthew Farley on 23/09/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBViewController.h"
#import "MBWebViewController.h"



@interface MBViewController ()

@property (nonatomic)int counter;
@property (strong, nonatomic) AVSpeechSynthesizer* speechSynth;
@property (strong, nonatomic) NSTimer *countdownTimer;
@property (nonatomic) BOOL isTimerPaused;

@end

@implementation MBViewController

@synthesize recipe = _recipe;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isTimerPaused = NO;
    [self.forwardAStepButton setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [self.forwardAStepButton setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateHighlighted];
    [self.backAStepButton setImage:[UIImage imageNamed:@"backward"] forState:UIControlStateNormal];
    [self.backAStepButton setImage:[UIImage imageNamed:@"backward"] forState:UIControlStateHighlighted];
    [self.startStopButton.titleLabel setTextColor:[UIColor colorWithRed:247/255.0 green:180/255.0 blue:92/255.0 alpha:1]];
    self.speechSynth = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynth setDelegate: self];
	self.navigationItem.title = self.recipe.recipeName;
    [self.startStopButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.startStopButton.titleLabel setHidden:YES];
    //Set initial instruction and time
    self.currentStepTextView.text = [((NSDictionary *)[self.recipe getCurrentStep]) objectForKey:@"instruction"];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.iconImageView];
    [self.iconImageView setImage:[UIImage imageNamed:@"play1"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (MBRecipe *)recipe {
//    if (!_recipe){
//        // For Testing!
//        _recipe = [[MBRecipe alloc]initWithTestRecipe];
//    }
//    return _recipe;
//}

- (IBAction)buttonCLick:(MBCircleButton *)sender {
    if(sender == self.startStopButton){
        //[self.startStopButton.titleLabel setHidden:NO];
        //Pause Flow
        if(self.countdownTimer.isValid && !self.startStopButton.titleLabel.isHidden &&
           !self.isTimerPaused){
            self.isTimerPaused = YES;
            [self.countdownTimer invalidate];
            //Pause
            //get time - put it in a variable
            //invalidate timer
        }else if (self.isTimerPaused){
            self.isTimerPaused = NO;
            [self.countdownTimer invalidate];
            [self startCountdownWithTime: self.counter];
        }else{
            [self playRecipeStep:[self.recipe getCurrentStep]];
        }

    } else if (sender == self.forwardAStepButton) {
        //invalidate timer
        [self.startStopButton.titleLabel setHidden:YES];
        if ([self.recipe hasMoreSteps]){
            if (self.speechSynth.isSpeaking){
                [self.speechSynth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            }
            [self.countdownTimer invalidate];
            [self playRecipeStep:[self.recipe getNextStep]];
        }
        
    } else if (sender == self.backAStepButton){
        if (self.speechSynth.isSpeaking){
            [self.speechSynth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        }
        [self.startStopButton.titleLabel setHidden:YES];
        [self.countdownTimer invalidate];
        [self playRecipeStep:[self.recipe getPreviousStep]];
    }
}

- (void)startCountdownWithTime:(int)startTime{
    self.counter = startTime;
    if (self.countdownTimer){
        [self.countdownTimer invalidate];
    }
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCounterButtonView:) userInfo:nil repeats:YES];
}

- (void)updateCounterButtonView:(NSTimer *)timer{
    self.counter--;
    [self.startStopButton setTitleWithSeconds:self.counter];
    if (self.counter <= 0){
        [timer invalidate];
        if ([self.recipe hasMoreSteps]){
            [self playRecipeStep:[self.recipe getNextStep]];
            [self.startStopButton.titleLabel setHidden:YES];
        } else {
            [self.startStopButton.titleLabel setHidden:YES];
            [self.iconImageView setImage:[UIImage imageNamed:@"play1"]];
            [self.iconImageView setHidden:NO];
        }
    }
}

-(void)playRecipeStep:(NSDictionary *)recipeStep{
    self.currentStepTextView.text = [((NSDictionary *)[self.recipe getCurrentStep]) objectForKey:@"instruction"];
    if (self.iconImageView.isHidden)
    {
        [self.iconImageView setHidden:NO];
    }
    [self.startStopButton.titleLabel setHidden:YES];
    [self.iconImageView setImage:[UIImage imageNamed:@"sound"]];
    NSString * textToSpeak = (NSString *)[recipeStep valueForKey:KEY_INSTRUCTION];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:textToSpeak];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-AU"];
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.5;
    [self.speechSynth speakUtterance:utterance];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    [self.iconImageView setHidden:YES];
    int time = [((NSNumber *)[[self.recipe getCurrentStep] objectForKey:@"time"]) intValue];
    [self.startStopButton setTitleWithSeconds:time];
    //[self.startStopButton.titleLabel setHidden:NO];
    [self startCountdownWithTime: time];
    [self.startStopButton.titleLabel setHidden:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (sender == self.showRecipeStepsButton){
        MBWebViewController *mbwvc = [segue destinationViewController];
        mbwvc.navigationItem.title = @"Recipe Steps";
        mbwvc.recipe = self.recipe;
        mbwvc.dataToShow = DATA_TO_SHOW_RECIPE_STEPS;
        
        
    }
    if (sender == self.showIngredientsListButton){
        MBWebViewController *mbwvc = [segue destinationViewController];
        mbwvc.navigationItem.title = @"Ingredients";
        mbwvc.recipe = self.recipe;
        mbwvc.dataToShow = DATA_TO_SHOW_RECIPE_INGREDIENTS;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.countdownTimer invalidate];
}

@end
