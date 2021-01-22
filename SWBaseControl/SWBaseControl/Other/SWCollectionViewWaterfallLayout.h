//
//  SWCollectionViewWaterfallLayout.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/22.
//  Copyright © 2021 zhoushaowen. All rights reserved.
// 瀑布流

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SWCollectionViewWaterfallLayout;

@protocol SWCollectionViewDelegateWaterfallLayout <UICollectionViewDelegate>
- (CGFloat)collectionView:(UICollectionView *)collectionView
          waterfallLayout:(SWCollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SWCollectionViewWaterfallLayout : UICollectionViewLayout

@property (nonatomic, assign) NSUInteger columnCount; // How many columns
@property (nonatomic, assign) CGFloat itemWidth; // Width for every column
@property (nonatomic, assign) UIEdgeInsets sectionInset; // The margins used to lay out content in a section

@end

NS_ASSUME_NONNULL_END
