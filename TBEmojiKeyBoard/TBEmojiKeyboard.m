//
//  TBEmojiKeyboard.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiKeyboard.h"
#import "TBEmojiViewCollectionView.h"
#import "TBEmojiBottomBar.h"
#import "TBEmojiKeyboardConstant.h"

@interface TBEmojiKeyboard()<TBEmojiViewCollectionViewDelegate>

@property (nonatomic, weak ,readwrite)  UIResponder<UITextInput>    *textInput;

@end

@implementation TBEmojiKeyboard

- (instancetype)init {

    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    //[self setHidden:YES];
    
    [self setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1]];
    [self setFrame:CGRectMake(0, 20, 375, kTBEmojiKeyboardHeight)];
    
    TBEmojiViewCollectionView *collectionView = [[TBEmojiViewCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), kTBEmojiCollectionViewHeight)];
    collectionView.delegate = self;
    [self addSubview:collectionView];
    
    NSArray *buttonArray = @[@"最近",@"默认"];
    TBEmojiBottomBar *bottomBar = [[TBEmojiBottomBar alloc] initWithFrame:CGRectMake(0, kTBEmojiKeyboardHeight - kTBEmojiBottomBarHeight, CGRectGetWidth(self.frame), kTBEmojiBottomBarHeight) buttonArray:buttonArray];
    bottomBar.delegate = collectionView;
    [self addSubview:bottomBar];
    
}

- (void)showKeyboard {
    
    [self setHidden:NO];
    CGRect originFrame = CGRectMake(0, [TBEmojiKeyboardConstant tbkey_getDeviceHeight], [TBEmojiKeyboardConstant tbkey_getDeviceWidth], kTBEmojiKeyboardHeight);
    
    CGRect finalFrame = CGRectMake(0, [TBEmojiKeyboardConstant tbkey_getDeviceHeight] - kTBEmojiKeyboardHeight, [TBEmojiKeyboardConstant tbkey_getDeviceWidth], kTBEmojiKeyboardHeight);
    
    self.frame = originFrame;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = finalFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideKeyboard {

    
}

#pragma mark collectionView Delegate

- (void)collectionView:(TBEmojiViewCollectionView *)collectionview didSelectEmoji:(NSDictionary *)dict {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboard:didSelectEmoji:)]) {
        [self.delegate keyboard:self didSelectEmoji:dict];
    }
}

- (void)collectionViewDidDelete:(TBEmojiViewCollectionView *)collectionview {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardDidDelete:)]) {
        [self.delegate keyboardDidDelete:self];
    }
}


#pragma mark private



#pragma mark - Input

- (void)setInputViewToView:(UIView *)view {
    self.textInput.inputView = view;
    [self.textInput reloadInputViews];
}

- (void)attachToTextInput:(UIResponder<UITextInput> *)textInput {

    self.textInput = textInput;
    [self setInputViewToView:self];
}

- (void)switchToDefaultKeyboard {
    [self setInputViewToView:nil];
    self.textInput = nil;
//    [[NSNotificationCenter defaultCenter] postNotificationName:WUEmoticonsKeyboardDidSwitchToDefaultKeyboardNotification object:self];
}

@end



@implementation UIResponder (TBEmojiKeyboard)

- (TBEmojiKeyboard *)emojiKeyboard {
    if ([self.inputView isKindOfClass:[TBEmojiKeyboard class]]) {
        return (TBEmojiKeyboard *)self.inputView;
    }
    return nil;
}

- (void)switchToEmojiKeyboard:(TBEmojiKeyboard *)keyboard {
    [keyboard attachToTextInput:(UIResponder<UITextInput> *)self];
}

- (void)switchToDefaultKeyboard {
    [self.emojiKeyboard switchToDefaultKeyboard];
    
}

@end
