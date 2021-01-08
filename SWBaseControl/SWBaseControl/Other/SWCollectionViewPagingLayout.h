//
//  SWCollectionViewPagingLayout.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/7.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SWCollectionViewPagingLayout;

@protocol SWCollectionViewPagingLayoutDelegate <NSObject>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout lineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout interitemSpacingForSectionAtIndex:(NSInteger)section;
- (void)collectionView:(UICollectionView *)collectionView pagingLayout:(SWCollectionViewPagingLayout*)pagingLayout pageCount:(NSInteger)pageCount;

@end

@interface SWCollectionViewPagingLayout : UICollectionViewLayout

@end

NS_ASSUME_NONNULL_END
