//
//  SWCollectionPagingView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/7.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWCollectionViewPagingLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWCollectionPagingView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,SWCollectionViewPagingLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

NS_ASSUME_NONNULL_END
