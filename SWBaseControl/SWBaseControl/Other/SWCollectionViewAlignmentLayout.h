//
//  SWCollectionViewAlignmentLayout.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/8.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SWCollectionViewAlignmentLayout;

@protocol SWCollectionViewAlignmentLayoutDelegate <NSObject>

@required
- (CGSize)collectionView:(UICollectionView *)collectionView alignmentLayout:(SWCollectionViewAlignmentLayout*)alignmentLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView alignmentLayout:(SWCollectionViewAlignmentLayout*)alignmentLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView alignmentLayout:(SWCollectionViewAlignmentLayout*)alignmentLayout lineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView alignmentLayout:(SWCollectionViewAlignmentLayout*)alignmentLayout interitemSpacingForSectionAtIndex:(NSInteger)section;

@end

typedef NS_ENUM(NSUInteger, SWCollectionViewAlignment) {
    SWCollectionViewAlignmentLeft,
    SWCollectionViewAlignmentRight,
};

@interface SWCollectionViewAlignmentLayout : UICollectionViewLayout

@property (nonatomic) SWCollectionViewAlignment alignment;

- (CGSize)getCollectionViewContentSizeWithPreCollectionViewSize:(CGSize)preCollectionViewSize;

@end

NS_ASSUME_NONNULL_END
