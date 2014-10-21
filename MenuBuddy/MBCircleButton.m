//
//  MBCircleButton.m
//  MenuBuddy
//
//  Created by Matthew Farley on 4/10/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBCircleButton.h"

@implementation MBCircleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initialize];

}

- (void)initialize{
    self.layer.cornerRadius = self.bounds.size.width/2.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.backgroundColor = [UIColor blackColor];

    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:35];
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateHighlighted];
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
