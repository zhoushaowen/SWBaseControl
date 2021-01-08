//
//  SWCollectionPagingView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/7.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "SWCollectionPagingView.h"
#import <SWExtension.h>

@interface SWCollectionPagingViewCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *label;

@end

@implementation SWCollectionPagingViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [UILabel new];
        self.label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label];
        self.label.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.contentView.bounds;
}

@end

@interface SWCollectionPagingView ()

@end

@implementation SWCollectionPagingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40);
}

- (UICollectionView *)collectionView {
    if(!_collectionView){
        SWCollectionViewPagingLayout *layout = [SWCollectionViewPagingLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_collectionView sw_registerCellWithClass:[SWCollectionPagingViewCell class]];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        [_pageControl addTarget:self action:@selector(pageControlValueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (void)pageControlValueChanged {
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width*self.pageControl.currentPage, 0) animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 99;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SWCollectionPagingViewCell *cell = [collectionView sw_dequeueReusableCellWithClass:[SWCollectionPagingViewCell class] forIndexPath:indexPath];
    cell.label.text = @(indexPath.item).stringValue;
    cell.contentView.backgroundColor = [UIColor blueColor];
    return cell;
}

#pragma mark - SWCollectionViewPagingLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(60, 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout lineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout interitemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (void)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout *)pagingLayout pageCount:(NSInteger)pageCount {
    self.pageControl.numberOfPages = pageCount;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.pageControl.currentPage = index;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.pageControl.currentPage = index;
}



@end
