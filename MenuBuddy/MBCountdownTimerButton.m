//
//  MBCountdownTimerButton.m
//  MenuBuddy
//
//  Created by Matthew Farley on 5/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBCountdownTimerButton.h"

@implementation MBCountdownTimerButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self initialize];
    }
    return self;
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

+ (NSString *)stringFromRawSeconds:(int)rawSeconds {
    int minutes = rawSeconds / 60;
    int remainingSeconds = rawSeconds % 60;
    NSString *minString = (minutes > 0)?[NSString stringWithFormat:@"%d", minutes]:@"";
    NSString *secString = (remainingSeconds > 9)?[NSString stringWithFormat:@"%d", remainingSeconds]:
    [NSString stringWithFormat:@"0%d", remainingSeconds];
    return [NSString stringWithFormat:@"%@:%@", minString, secString];
}

- (void)setTitleWithSeconds:(int)rawSeconds{
    NSString * result = [MBCountdownTimerButton stringFromRawSeconds:rawSeconds];
    [self setTitle:result forState:UIControlStateNormal];
    [self setTitle:result forState:UIControlStateHighlighted];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
