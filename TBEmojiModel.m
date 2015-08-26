//
//  TBEmojiModel.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/26/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiModel.h"

@implementation TBEmojiModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {

    self = [super init];
    if (self) {
        self.chs = [dict objectForKey:@"chs"];
        self.png = [dict objectForKey:@"png"];
    }
    return self;
    
}


@end
