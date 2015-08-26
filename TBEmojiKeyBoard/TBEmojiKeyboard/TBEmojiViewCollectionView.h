//
//  TBEmojiViewCollectionView.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBEmojiBottomBar.h"

@class TBEmojiViewCollectionView;

@protocol TBEmojiViewCollectionViewDelegate <NSObject>

- (void)collectionView:(TBEmojiViewCollectionView *)collectionview didSelectEmoji:(NSDictionary *)dict;

- (void)collectionViewDidDelete:(TBEmojiViewCollectionView *)collectionview;

@end

@interface TBEmojiViewCollectionView : UIView <TBEmojiBottomBarDelegate>

@property (nonatomic, weak) id<TBEmojiViewCollectionViewDelegate> delegate;

@end
