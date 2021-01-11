//
//  SWCollectionViewAlignedLayout.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/3/11.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SWCollectionViewAlignment) {
    SWCollectionViewAlignmentLeft,
    SWCollectionViewAlignmentRight,
};

/// 建议使用SWCollectionViewAlignmentLayout替代
@interface SWCollectionViewAlignedLayout : UICollectionViewFlowLayout

@property (nonatomic) SWCollectionViewAlignment alignment;

@end

NS_ASSUME_NONNULL_END
