//
//  TBEmojiPageFlowLayout.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiPageFlowLayout.h"

@implementation TBEmojiPageFlowLayout

- (instancetype)init {

    if (self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 30)/8.0;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.itemSize = CGSizeMake(width, width);
        self.sectionInset = UIEdgeInsetsMake(15, 15, 5, 15);
        
    }
    return self;
}
@end
