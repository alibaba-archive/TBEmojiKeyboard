//
//  TBEmojiKeyboard.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBEmojiKeyboard;

@interface UIResponder (WriteableInputView)
@property (readwrite, retain) UIView *inputView;
@end

@interface UIResponder (TBEmojiKeyboard)

@property (readonly, strong) TBEmojiKeyboard *emojiKeyboard;
- (void)switchToDefaultKeyboard;
- (void)switchToEmojiKeyboard:(TBEmojiKeyboard *)keyboard;
@end



@protocol TBEmojiKeyboardDelegate <NSObject>

- (void)TBEmojiKeyboardWillShowKeyboard:(TBEmojiKeyboard *)keyboard;

- (void)TBEmojiKeyboardDidShowKeyboard:(TBEmojiKeyboard *)keyboard;

- (void)TBEmojiKeyboardWillHideKeyboard:(TBEmojiKeyboard *)keyboard;

- (void)TBEmojiKeyboardDidHideKeyboard:(TBEmojiKeyboard *)keyboard;

@end

@interface TBEmojiKeyboard : UIView


@property (nonatomic, weak, readonly) UIResponder<UITextInput> *textInput;

- (void)showKeyboard;

- (void)hideKeyboard;

@end
