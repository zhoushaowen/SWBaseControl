//
//  SWBaseViewController.h
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/3/30.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SWBaseViewController)

@end

@interface UIViewController (SWBaseViewController)

/**
 自定义的类似系统导航上的UINavigationBar
 */
@property (nonatomic,strong,readonly) UIView *sw_bar;
/**
 自定义bar下面的下划线，设置之后为非nil之后自动使用默认的下划线
 */
@property (nonatomic,strong) UIImage *sw_barBottomLineImage;
/**
 自定义bar的颜色
 */
@property (nonatomic,strong) UIColor *sw_barColor;
/**
 自定义bar的背景图片,设置之后为非nil之后毛玻璃效果会自动消失
 */
@property (nonatomic,strong) UIImage *sw_barBackgroundImage;

/**
 初始化自定义导航视图(SWBaseViewController内部已经默认调用了,不要重复调用)
 */
- (void)sw_initSubViews;

///**
// 设置自定义导航的frame(必须在viewWillLayoutSubviews之后调用,SWBaseViewController内部已经默认调用了,不要重复调用)
// */
//- (void)sw_layoutSubviews;

@end

typedef NS_ENUM(NSUInteger, SWBaseViewControllerType) {
    SWBaseViewControllerNormalType = 0,
    SWBaseViewControllerTableViewType = 1,
    SWBaseViewControllerCollectionViewType = 2,
    SWBaseViewControllerWebViewType,
};

@interface SWBaseViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WKNavigationDelegate,WKUIDelegate>

- (instancetype)initWithControllerType:(SWBaseViewControllerType)controllerType;
- (instancetype)initWithStyle:(UITableViewStyle)style;
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *_Nonnull)collectionViewLayout;
- (instancetype)initWithURL:(NSURL *)url;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic,readonly) IBInspectable NSUInteger controllerType;
#else
@property (nonatomic,readonly) SWBaseViewControllerType controllerType;
#endif

@property (nonatomic) UIEdgeInsets contentViewInsets;

@property (nonatomic,readonly,strong,nullable) UITableView *tableView;
@property (nonatomic,readonly) UITableViewStyle tableViewStyle;
///default is UICollectionViewFlowLayout
@property (nonatomic,readonly,strong,nullable) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic,readonly,strong,nullable) UICollectionView *collectionView;

#pragma mark - WKWebView
@property (nonatomic,readonly,strong,nullable) WKWebView *webView;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,copy) NSString *htmlString;
///是否强制禁止缩放
@property (nonatomic) BOOL forceDisableScale;
/// default is 3.0
@property (nonatomic) CGFloat maximumScale;

@end

NS_ASSUME_NONNULL_END
