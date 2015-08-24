//
//  TBEmojiViewCollectionView.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiViewCollectionView.h"
#import "TBEmojiPageFlowLayout.h"

NSString *const cellIdentifer = @"TBEmojiIdentifer";

@interface TBEmojiViewCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TBEmojiViewCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        [self commomIntt];
    }
    return self;
}

- (void)commomIntt {
    
    [self setBackgroundColor:[UIColor redColor]];
    [self initCollectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifer];
}

- (void)initCollectionView {

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-10) collectionViewLayout:[[TBEmojiPageFlowLayout alloc] init]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
