//
//  TBEmojiKeyboardBottomBar.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiBottomBar.h"
#import "TBEmojiKeyboardConstant.h"

@interface TBEmojiBottomBar()

@property (nonatomic, strong) UIButton      *sendButton;
@property (nonatomic, strong) UIScrollView  *buttonScrollView;
@property (nonatomic, strong) NSArray       *buttonTitleArray;
@property (nonatomic, strong) NSArray       *buttonArray;

@end

@implementation TBEmojiBottomBar

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
        [self commomInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame buttonArray:(NSArray *)buttonArray {
    self.buttonTitleArray = buttonArray;
    return [self initWithFrame:frame];
}

- (void)commomInit {

    [self setBackgroundColor:[UIColor whiteColor]];

    _sendButton  = [[UIButton alloc] initWithFrame:CGRectMake([TBEmojiKeyboardConstant tbkey_getDeviceWidth] -kTBEmojiSendButtonWidth, 0,kTBEmojiSendButtonWidth, kTBEmojiBottomBarHeight)];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setBackgroundColor:TBK_SendButtonBackground];
    [[_sendButton titleLabel] setFont:[UIFont systemFontOfSize:13]];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_sendButton];
    
    
    _buttonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[TBEmojiKeyboardConstant tbkey_getDeviceWidth] - kTBEmojiSendButtonWidth, kTBEmojiBottomBarHeight)];
    [self addSubview:_buttonScrollView];
    [self initButton];
}

- (void)initButton {

    UIButton *lastButton;
    NSMutableArray *tempButtonArray = [[NSMutableArray alloc] init];
    for (NSString *buttonTitle in self.buttonTitleArray) {
        
        UIButton *button;
        if (!lastButton) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kTBEmojiSendButtonWidth, kTBEmojiBottomBarHeight)];
            [button setSelected:YES];
        } else {
             button = [[UIButton alloc] initWithFrame:CGRectMake(lastButton.frame.origin.x + kTBEmojiSendButtonWidth, 0, kTBEmojiSendButtonWidth, kTBEmojiBottomBarHeight)];
        }
        lastButton = button;
        [tempButtonArray addObject:button];
        [[button titleLabel] setFont:[UIFont systemFontOfSize:13]];
        [button addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:TBK_BottomButtonTitle forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:TBK_BottomButtonSelected] forState:UIControlStateSelected];
        [_buttonScrollView addSubview:button];
    }
    self.buttonArray = [tempButtonArray copy];
}


#pragma mark Event Response

- (void)buttonTouchUp:(UIButton *)sender {

    for (UIButton *button in self.buttonArray) {
        [button setSelected:NO];
    }
    [sender setSelected:YES];
    NSInteger index = [self.buttonArray indexOfObject:sender];
    if ([self.delegate respondsToSelector:@selector(TBEmojiBottomBar:didSelectAtIndex:)] && self.delegate) {
        [self.delegate TBEmojiBottomBar:self didSelectAtIndex:index];
    }
}

#pragma mark privete

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
