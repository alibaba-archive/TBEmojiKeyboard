//
//  TBEmojiViewCollectionView.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "TBEmojiViewCollectionView.h"
#import "TBEmojiPageFlowLayout.h"
#import "TBEmojiKeyboardConstant.h"

NSString *const cellIdentifer = @"TBEmojiIdentifer";

@interface TBEmojiViewCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UIPageControl     *pageControl;

@property (nonatomic, strong) NSArray           *dataSource;

@end

@implementation TBEmojiViewCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        [self commomIntt];
    }
    return self;
}

- (void)commomIntt {
    
    [self initCollectionView];
    [self initDataSource];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifer];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, CGRectGetWidth(self.frame), 20)];
    [self.pageControl setNumberOfPages:[self getPageNumber]];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setBackgroundColor:TBK_BottomButtonSelected];
    
    [self addSubview:self.pageControl];
}

- (void)initDataSource {

    self.dataSource = [[NSArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
}

- (void)initCollectionView {

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-20) collectionViewLayout:[[TBEmojiPageFlowLayout alloc] init]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.collectionView];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [self getPageNumber];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return kTBEmojiRow * kTBEmojiSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:cell.contentView.frame];
    [imageview setImage:[UIImage imageNamed:@"moji"]];
    if (indexPath.row <kTBEmojiRow * kTBEmojiSection -1 && [self isValidCell:indexPath]) {
        [cell.contentView addSubview:imageview];
    } else
    {
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
}

#pragma mark ScrollView Delegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
}


#pragma mark private

- (BOOL)isValidCell:(NSIndexPath *)indexPath {

    if ((indexPath.section +1) * (indexPath.row +1) <= self.dataSource.count) {
//        NSLog(@"%ld %ld %ld",indexPath.section +1,indexPath.row +1,self.dataSource.count );
        return YES;
    }
    return NO;
}

- (NSInteger)getPageNumber {
    return self.dataSource.count/24==0?self.dataSource.count/24:self.dataSource.count/24+1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
