//
//  SWBaseCollectionViewController.h
//  SWBaseViewController
//
//  Created by zhoushaowen on 2018/8/8.
//  Copyright © 2018年 Yidu. All rights reserved.
//

#import "SWBaseViewController.h"

@interface SWBaseCollectionViewController : SWBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

//default is UICollectionViewFlowLayout
@property (nonatomic,readonly,strong) UICollectionViewLayout *collectionViewLayout;

@property (nonatomic,readonly,strong) UICollectionView *collectionView;

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *_Nonnull)collectionViewLayout NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
