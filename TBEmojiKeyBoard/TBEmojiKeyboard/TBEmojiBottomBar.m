//
//  TBEmojiKeyboardBottomBar.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiBottomBar.h"

@implementation TBEmojiBottomBar

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
        [self commomIntt];
    }
    return self;
}

- (void)commomIntt {

    [self setBackgroundColor:[UIColor whiteColor]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
