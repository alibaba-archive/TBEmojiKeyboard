//
//  TBEmojiKeyboardCell.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/26/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiKeyboardCell.h"
#import "TBEmojiModel.h"

@interface TBEmojiKeyboardCell()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *emojiView;


@end

@implementation TBEmojiKeyboardCell

- (void)configWithModel:(TBEmojiModel *)model {

    if (!_emojiView) {
        _emojiView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        _emojiView.center = self.contentView.center;
        [self.contentView addSubview:_emojiView];
    }
    [_emojiView setImage:[UIImage imageNamed:model.png]];
    
//    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEvent:)];
//    longPressGestureRecognizer.minimumPressDuration = 0.5;
//    longPressGestureRecognizer.delegate = self;
//    [self addGestureRecognizer:longPressGestureRecognizer];
}

- (void)longPressEvent:(UILongPressGestureRecognizer *)gesture {

//    if (!_popUpView) {
//        _popUpView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popup"]];
//        [_popUpView setFrame:CGRectMake(0, -80, 60, 100)];
//    }
//    
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        _popUpView.window.windowLevel =20001;
//        [self.contentView insertSubview:_popUpView atIndex:300];
//        NSLog(@"begen");
//    }else if (gesture.state == UIGestureRecognizerStateEnded) {
//         NSLog(@"end");
//        [_popUpView removeFromSuperview];
//    }
}

- (void)prepareForReuse {
    [_emojiView setImage:nil];
    [super prepareForReuse];
    
}

@end
