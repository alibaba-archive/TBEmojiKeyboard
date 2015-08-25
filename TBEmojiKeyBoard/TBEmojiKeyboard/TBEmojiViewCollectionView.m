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

int originTable[kTBEmojiSection][kTBEmojiRow];
int covertOriginTabel[kTBEmojiSection][kTBEmojiRow];

NSString *const cellIdentifer = @"TBEmojiIdentifer";

@interface TBEmojiViewCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) NSArray           *dataSource;

@end

@implementation TBEmojiViewCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        [self initTable];
        [self commomIntt];
    }
    return self;
}

- (void)initTable {
    int index = 0;
    for (int i =0; i< kTBEmojiSection; i++) {
        for (int j =0; j<kTBEmojiRow; j++) {
            originTable[i][j] = index++;
        }
    }
    
    index = 0;
    for (int i =0; i< kTBEmojiRow; i++) {
        for (int j =0; j<kTBEmojiSection; j++) {
            covertOriginTabel[j][i] = index++;
        }
    }
    
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
    [self.collectionView setBackgroundColor:TBK_BottomButtonSelected];
    self.collectionView.showsHorizontalScrollIndicator = NO;
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
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [imageview setImage:[UIImage imageNamed:@"emoji_1"]];
    
    NSInteger dataSourceIndex =  [self covertIndexPathtoDataSourceIndex:indexPath];
    
    if (indexPath.row <kTBEmojiRow * kTBEmojiSection -1 && dataSourceIndex <=self.dataSource.count) {
        [cell.contentView addSubview:imageview];
        imageview.center = cell.contentView.center;
    } else
    {
        for (UIView *v in cell.contentView.subviews) {
            [v removeFromSuperview];
        }
    }
    if (indexPath.row == kTBEmojiRow * kTBEmojiSection -1) {
        UIImageView *deleteImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [deleteImage setImage:[UIImage imageNamed:@"delete_emoji"]];
        [cell.contentView addSubview:deleteImage];
        deleteImage.center = cell.contentView.center;
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

- (NSInteger)getPageNumber {
    return self.dataSource.count/24==0?self.dataSource.count/24:self.dataSource.count/24+1;
}

- (NSInteger)covertIndexPathtoDataSourceIndex:(NSIndexPath *)indexPath {
    for (int i =0; i<kTBEmojiSection; i++) {
        for (int j =0; j<kTBEmojiRow; j++) {
            if (originTable[i][j] == indexPath.row) {
                return covertOriginTabel[i][j] + indexPath.section * kTBEmojiSection *kTBEmojiRow;
            }
        }
    }
    return 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
