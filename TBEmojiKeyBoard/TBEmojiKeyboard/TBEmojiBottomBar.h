//
//  TBEmojiKeyboardBottomBar.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBEmojiBottomBar;

@protocol TBEmojiBottomBarDelegate <NSObject>

/**
 *  return the index of button
 *
 *  @param bottomBar
 *  @param index
 */
- (void)TBEmojiBottomBar:(TBEmojiBottomBar *)bottomBar didSelectAtIndex:(NSInteger)index;

@end

@interface TBEmojiBottomBar : UIView

- (instancetype)initWithFrame:(CGRect)frame buttonArray:(NSArray *)buttonArray;

@property (nonatomic, weak) id<TBEmojiBottomBarDelegate> delegate;

@end
