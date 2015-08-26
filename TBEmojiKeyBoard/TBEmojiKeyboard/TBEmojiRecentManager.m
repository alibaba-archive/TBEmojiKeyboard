//
//  TBEmojiRecentManager.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/26/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiRecentManager.h"

#define kEmojiRecentUserDefaultIdentifer @"kEmojiRecentUserDefaultIdentifer"

@interface TBEmojiRecentManager()

@property (nonatomic, strong) NSMutableArray *recentlyEmojiArray;

@end

@implementation TBEmojiRecentManager

+ (instancetype)manager {

    static TBEmojiRecentManager *managerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerInstance = [[TBEmojiRecentManager alloc] init];
    });
    return managerInstance;
}

- (NSArray *)getRecentEmoji {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefault objectForKey:kEmojiRecentUserDefaultIdentifer];
    return array==nil?[[NSArray alloc] init]:[[array reverseObjectEnumerator] allObjects];
}

- (void)appendEmoji:(NSDictionary *)dict {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefault objectForKey:kEmojiRecentUserDefaultIdentifer];
    NSMutableArray *mutableArray;
    if (array) {
        mutableArray = [[NSMutableArray alloc] initWithArray:array];
    } else {
        mutableArray = [NSMutableArray new];
    }
    if ([mutableArray containsObject:dict]) {
        [mutableArray removeObject:dict];
    }
    [mutableArray addObject:dict];
    [userDefault setObject:[mutableArray copy] forKey:kEmojiRecentUserDefaultIdentifer];
    [userDefault synchronize];
}


@end
