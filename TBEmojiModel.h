//
//  TBEmojiModel.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/26/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBEmojiModel : NSObject

@property (nonatomic, strong) NSString *chs;
@property (nonatomic, strong) NSString *png;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
