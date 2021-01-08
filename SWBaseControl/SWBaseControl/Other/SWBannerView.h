//
//  SWBannerView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/7.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SWBannerView;

@protocol SWBannerViewDelegate <NSObject>

@required

- (NSUInteger)sw_numberOfItemsInBannerView:(SWBannerView *)bannerView;

- (void)sw_bannerView:(SWBannerView *)bannerView imageView:(UIImageView *)imageView forIndex:(NSInteger)index;

@optional

/**
 点击了某个索引
 */
- (void)sw_bannerView:(SWBannerView *)bannerView didSelectedIndex:(NSInteger)index;

/**
 当前滑动到哪个索引
 */
- (void)sw_bannerView:(SWBannerView *)bannerView didScrollToIndex:(NSInteger)index;

@end


@interface SWBannerView : UIView
@property (nonatomic,readonly,strong) UIScrollView *scrollView;

@property (nonatomic,readonly,strong) UIPageControl *pageControl;

@property (nonatomic,weak) id<SWBannerViewDelegate> delegate;
/**
 背景图片
 */
@property (nonatomic,strong) UIImage *backgroundImage;

/** 定时轮播的时间间隔,默认是5秒*/
@property (nonatomic) NSTimeInterval scrollInterval;
/** 禁止定时轮播,默认是NO*/
@property (nonatomic) BOOL disableIntervalScroll;

/**
 当只有一张图片的时候是否禁止定时轮播,默认是YES
 */
@property (nonatomic) BOOL disableIntervalScrollForSinglePage;
/**
 初始化的index，默认是0
 */
@property (nonatomic) NSInteger initialIndex;

/**
 禁止用户手动滑动,默认NO
 */
@property (nonatomic) BOOL disableUserScroll;

/**
 是否允许无限轮播,默认是YES
 */
@property (nonatomic) BOOL enableInfiniteScroll;

/**
 是否允许弹簧效果,默认YES
 */
@property (nonatomic) BOOL bounces;

/**
 滑动手势
 */
@property (nonatomic,readonly,weak) UIPanGestureRecognizer *panGesture;

/** 开启定时轮播,默认已经是开启的*/
- (void)startIntervelScroll;
/** 停止定时轮播*/
- (void)stopIntervelScroll;

/**
 滑动到某个索引

 @param index 索引
 @param animated 是否做动画
 */
- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

/**
 刷新数据
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
