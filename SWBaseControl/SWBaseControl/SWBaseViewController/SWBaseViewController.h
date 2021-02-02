//
//  SWBaseViewController.h
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/3/30.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

//@interface UIView (SWBaseViewController)
//
//@end
//
//@interface UIViewController (SWBaseViewController)
//
///**
// 自定义的类似系统导航上的UINavigationBar
// */
//@property (nonatomic,strong,readonly) UIView *sw_bar;
///**
// 自定义bar下面的下划线，设置之后为非nil之后自动使用默认的下划线
// */
//@property (nonatomic,strong) UIImage *sw_barBottomLineImage;
///**
// 自定义bar的颜色
// */
//@property (nonatomic,strong) UIColor *sw_barColor;
///**
// 自定义bar的背景图片,设置之后为非nil之后毛玻璃效果会自动消失
// */
//@property (nonatomic,strong) UIImage *sw_barBackgroundImage;
//
///**
// 初始化自定义导航视图(SWBaseViewController内部已经默认调用了,不要重复调用)
// */
//- (void)sw_initSubViews;
//
//@end

typedef NS_ENUM(NSUInteger, SWBaseViewControllerType) {
    SWBaseViewControllerNormalType = 0,
    SWBaseViewControllerTableViewType = 1,
    SWBaseViewControllerCollectionViewType = 2,
    SWBaseViewControllerWebViewType,
};

typedef NS_ENUM(NSUInteger, SWBaseViewControllerScrollViewInsetsAdjustType) {
    SWBaseViewControllerScrollViewInsetsAdjustTypeDefault,
    SWBaseViewControllerScrollViewInsetsAdjustTypeAutomaticBySystem,
    SWBaseViewControllerScrollViewInsetsAdjustTypeNoAdjust,
};

@interface SWBaseViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WKNavigationDelegate,WKUIDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

- (instancetype)initWithControllerType:(SWBaseViewControllerType)controllerType;
- (instancetype)initWithStyle:(UITableViewStyle)style;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *_Nonnull)collectionViewLayout;
- (instancetype)initWithURL:(NSURL *)url;

#pragma mark - Nav
@property (nonatomic,readonly) BOOL navigationBarBottomLineHidden;
@property (nonatomic,readonly) BOOL navigationBarHidden;
//@property (nonatomic,readonly) BOOL translucentNavigationBar;

/// 是否开启导航渐变色
@property (nonatomic) BOOL enableGradientNavigationBarColor;
/// 开始渐变需要移动的距离,默认值100
@property (nonatomic) CGFloat gradientNavigationColorBeginOffset;
/// 渐变导航不透明的时候的标题
@property (nonatomic,copy) NSString *gradientNavigationTitleForOpacity;
/// 渐变导航透明的时候的标题
@property (nonatomic,copy) NSString *gradientNavigationTitleForTranslucent;
/// 渐变导航不透明的时候的颜色
@property (nonatomic,strong) UIColor *gradientNavigationColorForOpacity;

/// default is white
@property (nonatomic,readonly,strong) UIColor *navigationBarBackgroundColor;
@property (nonatomic,readonly,strong) UIImage *navigationBarBackgroundImage;
/// 需要将image renderingMode设为UIImageRenderingModeAlwaysTemplate default is block
@property (nonatomic,readonly,strong) UIColor *navigationItemColor;

/// default is nil
@property (nonatomic,readonly,strong) NSDictionary<NSAttributedStringKey, id> *navigationBarTitleTextAttributes;

@property (nonatomic) BOOL forceDisplayBackItemBtn;
@property (nonatomic) BOOL automaticallyHidesBottomBarWhenPushed;
- (void)configNavBackItem;
- (void)backItemAction;

- (UIImage *)sw_createImageWithColor:(UIColor *)color;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic,readonly) IBInspectable NSUInteger controllerType;
#else
@property (nonatomic,readonly) SWBaseViewControllerType controllerType;
#endif

@property (nonatomic) UIEdgeInsets contentViewInsets;

@property (nonatomic,readonly) SWBaseViewControllerScrollViewInsetsAdjustType scrollViewInsetsAdjustType;

@property (nonatomic,readonly,strong,nullable) UITableView *tableView;
@property (nonatomic,readonly) UITableViewStyle tableViewStyle;
///default is UICollectionViewFlowLayout
@property (nonatomic,readonly,strong,nullable) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic,readonly,strong,nullable) UICollectionView *collectionView;

#pragma mark - WKWebView
@property (nonatomic,readonly,strong,nullable) WKWebView *webView;
@property (nonatomic,strong) UIProgressView *webLoadingProgressView;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,copy) NSString *htmlString;
///是否强制禁止缩放
@property (nonatomic) BOOL forceDisableScale;
/// default is 3.0
@property (nonatomic) CGFloat maximumScale;

@end

NS_ASSUME_NONNULL_END
