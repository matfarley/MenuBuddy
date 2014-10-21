//
//  MBCountdownTimerButton.h
//  MenuBuddy
//
//  Created by Matthew Farley on 5/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBCircleButton.h"

@interface MBCountdownTimerButton : MBCircleButton
+ (NSString *)stringFromRawSeconds:(int)rawSeconds;
- (void)setTitleWithSeconds:(int)rawSeconds;

@end
