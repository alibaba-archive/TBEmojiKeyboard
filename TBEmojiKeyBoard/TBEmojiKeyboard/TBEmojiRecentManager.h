//
//  TBEmojiRecentManager.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/26/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBEmojiRecentManager : NSObject

+ (instancetype)manager;

- (NSArray *)getRecentEmoji;

- (void)appendEmoji:(NSDictionary *)dict;

@end
