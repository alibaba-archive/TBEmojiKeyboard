//
//  TBEmojiKeyboard.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBEmojiKeyboard;

@protocol TBEmojiKeyboardDelegate <NSObject>

- (void)TBEmojiKeyboardWillShowKeyboard:(TBEmojiKeyboard *)keyboard;

- (void)TBEmojiKeyboardDidShowKeyboard:(TBEmojiKeyboard *)keyboard;

- (void)TBEmojiKeyboardWillHideKeyboard:(TBEmojiKeyboard *)keyboard;

- (void)TBEmojiKeyboardDidHideKeyboard:(TBEmojiKeyboard *)keyboard;

@end

@interface TBEmojiKeyboard : UIView

- (void)showKeyboard;

- (void)hideKeyboard;

@end
