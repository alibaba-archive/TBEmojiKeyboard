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
#import "TBEmojiKeyboardCell.h"
#import "TBEmojiModel.h"
#import "TBEmojiRecentManager.h"

int originTable[kTBEmojiSection][kTBEmojiRow];
int covertOriginTabel[kTBEmojiSection][kTBEmojiRow];

NSString *const cellIdentifer = @"TBEmojiIdentifer";
NSString *const deleteCellIdentifer = @"TBEmojiIdentiferDelete";

@interface TBEmojiViewCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UIPageControl     *pageControl;
@property (nonatomic, strong) NSMutableArray    *dataSource;
@property (nonatomic, assign) NSInteger         currentSection;
@property (nonatomic, strong) UIImageView       *popUpView;

@end

@implementation TBEmojiViewCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        _currentSection = 0;
        [self initTable];
        [self commomInit];
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

- (void)commomInit {

    [self initCollectionView];
    [self initDataSource];
    [self.collectionView registerClass:[TBEmojiKeyboardCell class] forCellWithReuseIdentifier:cellIdentifer];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:deleteCellIdentifer];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, CGRectGetWidth(self.frame), 20)];
    [self addSubview:self.pageControl];
    [self configPageControl];
}

- (void)configPageControl {
    [self.pageControl setNumberOfPages:[self getPageNumberofIndex:_currentSection]];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setBackgroundColor:TBK_BottomButtonSelected];
    
}

- (void)initDataSource {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
    NSDictionary *defaultDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.dataSource = [[NSMutableArray alloc] initWithArray: @[[[TBEmojiRecentManager manager] getRecentEmoji],[defaultDict objectForKey:@"emoticons"]]];
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

    return [self getPageNumberofIndex:_currentSection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return kTBEmojiRow * kTBEmojiSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TBEmojiKeyboardCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifer forIndexPath:indexPath];
    
    NSArray *currentDataSource = [self.dataSource objectAtIndex:_currentSection];
    
    NSInteger dataSourceIndex =  [self convertIndexPathtoDataSourceIndex:indexPath];
    
    if (indexPath.row <kTBEmojiRow * kTBEmojiSection -1 && dataSourceIndex - indexPath.section < currentDataSource.count) {
        NSDictionary *data = [currentDataSource objectAtIndex:dataSourceIndex - indexPath.section];
        [cell configWithModel:[[TBEmojiModel alloc] initWithDictionary:data]];
    } else {
    }
    if (indexPath.row == kTBEmojiRow * kTBEmojiSection -1) {
        UICollectionViewCell *deleteCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:deleteCellIdentifer forIndexPath:indexPath];
        UIImageView *deleteImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [deleteImage setImage:[UIImage imageNamed:@"delete_emoji"]];
        [deleteCell.contentView addSubview:deleteImage];
        deleteImage.center = deleteCell.contentView.center;
        return deleteCell;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == kTBEmojiRow * kTBEmojiSection -1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewDidDelete:)]) {
            [self.delegate collectionViewDidDelete:self];
        }
        return;
    }
    
    NSArray *currentDataSource = [self.dataSource objectAtIndex:_currentSection];
    NSInteger dataSourceIndex =  [self convertIndexPathtoDataSourceIndex:indexPath];
    if (indexPath.row <kTBEmojiRow * kTBEmojiSection -1 && dataSourceIndex - indexPath.section < currentDataSource.count) {
        NSInteger index =[self convertIndexPathtoDataSourceIndex:indexPath] - indexPath.section;
        [[TBEmojiRecentManager manager] appendEmoji:[self.dataSource[_currentSection] objectAtIndex:index]];
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:didSelectEmoji:)]) {
            [self.delegate collectionView:self didSelectEmoji:[self.dataSource[_currentSection] objectAtIndex:index]];
        }
    }
}

#pragma mark bottombar delegate

- (void)TBEmojiBottomBar:(TBEmojiBottomBar *)bottomBar didSelectAtIndex:(NSInteger)index {

    _currentSection = index;
    [self configPageControl];
    if (index ==0) {
        [self.dataSource replaceObjectAtIndex:0 withObject:[[TBEmojiRecentManager manager] getRecentEmoji]];
    }
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self.collectionView reloadData];
}

#pragma mark ScrollView Delegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.pageControl.currentPage = index;
}

#pragma mark private

- (NSInteger)getPageNumberofIndex:(NSInteger)index {
    NSArray *array = [self.dataSource objectAtIndex:index];
    NSInteger numberOfPage = kTBEmojiSection *kTBEmojiRow - 1;
    NSInteger page = array.count%numberOfPage==0?array.count/numberOfPage:array.count/numberOfPage+1;
    return page;
}

- (NSInteger)convertIndexPathtoDataSourceIndex:(NSIndexPath *)indexPath {
    for (int i =0; i<kTBEmojiSection; i++) {
        for (int j =0; j<kTBEmojiRow; j++) {
            if (originTable[i][j] == indexPath.row) {
                return covertOriginTabel[i][j] + indexPath.section * kTBEmojiSection *kTBEmojiRow;
            }
        }
    }
    return 0;
}


@end
