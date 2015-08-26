//
//  TBEmojiKeyboardConstant.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/25/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TBK_BottomButtonSelected [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]
#define TBK_BottomButtonTitle [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1]
#define TBK_SendButtonBackground [UIColor colorWithRed:3/255.0 green:169/255.0 blue:244/255.0 alpha:1]

static const CGFloat    kTBEmojiKeyboardHeight          = 216;
static const CGFloat    kTBEmojiCollectionViewHeight    = 181;
static const CGFloat    kTBEmojiPageControlHeight       = 20;
static const CGFloat    kTBEmojiBottomBarHeight         = 35;
static const CGFloat    kTBEmojiSendButtonWidth         = 80;
static const NSInteger  kTBEmojiRow                     = 3;
static const NSInteger  kTBEmojiSection                 = 7;

@interface TBEmojiKeyboardConstant : NSObject


+ (CGFloat)tbkey_getDeviceWidth;

+ (CGFloat)tbkey_getDeviceHeight;
@end
