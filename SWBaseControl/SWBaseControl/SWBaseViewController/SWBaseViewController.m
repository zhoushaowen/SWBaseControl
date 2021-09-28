//
//  SWBaseViewController.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2017/3/30.
//  Copyright © 2017年 Yidu. All rights reserved.
//

#import "SWBaseViewController.h"
#import <objc/runtime.h>
#import "SWVisualEffectView.h"
#import <SWExtension/SWExtension.h>
//#import <NSObject+RACKVOWrapper.h>
//#import <RACEXTScope.h>
#import <ReactiveObjC/ReactiveObjC.h>


@interface SWBaseViewController ()
{
    UIScrollView *_scrollView;
}

@property (nonatomic,strong) UIColor *navigationBarBackgroundColor;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger controllerType;
#else
@property (nonatomic) SWBaseViewControllerType controllerType;
#endif
@property (nonatomic) UITableViewStyle tableViewStyle;
@property (nonatomic,strong) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic,strong) WKWebView *webView;

@end

@implementation SWBaseViewController

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self beforeLoadViewInit];
//    }
//    return self;
//}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        [self beforeLoadViewInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self beforeLoadViewInit];
    }
    return self;
}

- (void)beforeLoadViewInit  {
    self.automaticallyHidesBottomBarWhenPushed = YES;
}


- (instancetype)initWithControllerType:(SWBaseViewControllerType)controllerType {
    self = [[[self class] alloc] initWithNibName:nil bundle:nil];
    if(self){
        self.controllerType = controllerType;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [[[self class] alloc] initWithNibName:nil bundle:nil];
    if(self){
        self.tableViewStyle = style;
        self.controllerType = SWBaseViewControllerTableViewType;
    }
    return self;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *_Nonnull)collectionViewLayout {
    self = [[[self class] alloc] initWithNibName:nil bundle:nil];
    if(self){
        if(collectionViewLayout == nil){
            collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        }
        self.collectionViewLayout = collectionViewLayout;
        self.controllerType = SWBaseViewControllerCollectionViewType;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [[[self class] alloc] initWithNibName:nil bundle:nil];
    if(self){
        self.controllerType = SWBaseViewControllerWebViewType;
        self.url = url;
    }
    return self;
}

- (BOOL)navigationBarBottomLineHidden {
    return YES;
}

- (UIColor *)navigationBarBackgroundColor {
    return [UIColor whiteColor];
}

- (BOOL)enableGradientNavigationBarColor {
    return NO;
}

- (UIColor *)gradientNavigationColorForOpacity {
    return [UIColor whiteColor];
}

//- (BOOL)translucentNavigationBar {
//    return YES;
//}

- (BOOL)enableScrollViewInsetsAdjust {
    return YES;
}

- (CGFloat)gradientNavigationColorBeginOffset {
    return 100;
}

- (UIColor *)navigationItemColor {
    return [UIColor blackColor];
}

- (UIProgressView *)webLoadingProgressView {
    if(!_webLoadingProgressView){
        _webLoadingProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        @weakify(self)
        [RACObserve(self.webView, estimatedProgress) subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self->_webLoadingProgressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    self->_webLoadingProgressView.hidden = YES;
                });
            }
        }];
    }
    return _webLoadingProgressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self sw_initSubViews];
    [self sw_configNavigation:NO];
    self.automaticallyAdjustsScrollViewInsets = self.scrollViewInsetsAdjustType == SWBaseViewControllerScrollViewInsetsAdjustTypeAutomaticBySystem?YES:NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    if(self.view.backgroundColor == nil){
        self.view.backgroundColor = [UIColor whiteColor];
    }
    switch (self.controllerType) {
        case SWBaseViewControllerNormalType:
        {
            
        }
            break;
        case SWBaseViewControllerTableViewType:{
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom) style:self.tableViewStyle];
            if (@available(iOS 11.0, *)) {
                _tableView.contentInsetAdjustmentBehavior = self.scrollViewInsetsAdjustType == SWBaseViewControllerScrollViewInsetsAdjustTypeAutomaticBySystem? UIScrollViewContentInsetAdjustmentAutomatic:UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlie   r versions
            }
            _scrollView = _tableView;
            _tableView.rowHeight = UITableViewAutomaticDimension;
            _tableView.estimatedRowHeight = 44.0f;
            _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
            _tableView.estimatedSectionHeaderHeight = 44.0f;
            _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
            //不要设置UITableViewAutomaticDimension 否则UITableViewStyleGrouped 底部有间隙
            _tableView.estimatedSectionFooterHeight = 44.0f;
//            _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            //去除UITableViewStyleGrouped样式导致的tableView头部空白间隙
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.01)];
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.01)];
            _tableView.tableHeaderView = headerView;
            _tableView.tableFooterView = footerView;
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [self.view addSubview:_tableView];
//            [self addScrollViewContentOffsetObserver:_tableView];
        }
            break;
        case SWBaseViewControllerCollectionViewType:
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
            if (@available(iOS 11.0, *)) {
                _collectionView.contentInsetAdjustmentBehavior = self.scrollViewInsetsAdjustType == SWBaseViewControllerScrollViewInsetsAdjustTypeAutomaticBySystem? UIScrollViewContentInsetAdjustmentAutomatic:UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlie   r versions
            }
            _scrollView = _collectionView;
//            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [self.view addSubview:_collectionView];
//            [self addScrollViewContentOffsetObserver:_collectionView];
        }
            break;
        case SWBaseViewControllerWebViewType:
        {
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            WKUserContentController *userContent = [[WKUserContentController alloc] init];
            config.userContentController = userContent;
            self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom) configuration:config];
//            self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            if (@available(iOS 11.0, *)) {
                self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            } else {
                // Fallback on earlie   r versions
                self.automaticallyAdjustsScrollViewInsets = YES;
            }
            self.webView.navigationDelegate = self;
            self.webView.UIDelegate = self;
            [self.view addSubview:self.webView];
            
            [self.view addSubview:self.webLoadingProgressView];
            
            if(self.url){
                [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
            }else if(self.htmlString.length > 0){
                [self.webView loadHTMLString:self.htmlString baseURL:nil];
            }

        }
            break;
            
        default:
            break;
    }
    _scrollView.emptyDataSetSource = self;
    _scrollView.emptyDataSetDelegate = self;
    if(self.navigationController && [self isNavigationRouteVc] && (self.navigationController.viewControllers.count > 1 || self.forceDisplayBackItemBtn)){
        [self configNavBackItem];
    }
}

- (BOOL)isNavigationRouteVc {
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    return index != NSNotFound;
}

- (void)configNavBackItem {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SWBaseControl.bundle" ofType:nil];
    NSString *imageName = [path stringByAppendingPathComponent:@"fanhui"];
    [backBtn setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    backBtn.contentMode = UIViewContentModeLeft;
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)setForceDisplayBackItemBtn:(BOOL)forceDisplayBackItemBtn {
    _forceDisplayBackItemBtn = forceDisplayBackItemBtn;
    if(forceDisplayBackItemBtn && self.navigationController && [self isNavigationRouteVc] && self.isViewLoaded){
        [self configNavBackItem];
    }
}

- (void)backItemAction {
    if(self.presentingViewController && self.navigationController.viewControllers.count <= 1){
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    UIView *contentView = nil;
    switch (self.controllerType) {
        case SWBaseViewControllerTableViewType:
            {
                contentView = _tableView;
            }
            break;
        case SWBaseViewControllerCollectionViewType:
        {
            contentView = _collectionView;
        }
            break;
        case SWBaseViewControllerWebViewType:
        {
            contentView = _webView;
            CGRect webLoadingProgressViewFrame = self.webLoadingProgressView.frame;
            if (@available(iOS 11.0, *)) {
                webLoadingProgressViewFrame.origin = CGPointMake(self.contentViewInsets.left, self.contentViewInsets.top + self.view.safeAreaInsets.top);
            } else {
                // Fallback on earlier versions
                webLoadingProgressViewFrame.origin = CGPointMake(self.contentViewInsets.left, self.contentViewInsets.top + self.navigationController.navigationBar.frame.size.height);
            }
            webLoadingProgressViewFrame.size.width = self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right;
            self.webLoadingProgressView.frame = webLoadingProgressViewFrame;
        }
            break;
            
        default:
            break;
    }
    CGRect contentViewFrame = contentView.frame;
    contentViewFrame = CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom);
    if(!CGRectEqualToRect(contentViewFrame, contentView.frame)){
        contentView.frame = contentViewFrame;
    }
    [self updateScrollViewContentInsets];
}

- (void)updateScrollViewContentInsets {
    if(self.scrollViewInsetsAdjustType != SWBaseViewControllerScrollViewInsetsAdjustTypeDefault) return;
    if(_scrollView){
        UIView *contentView = nil;
        switch (self.controllerType) {
            case SWBaseViewControllerTableViewType:
                {
                    contentView = _tableView;
                }
                break;
            case SWBaseViewControllerCollectionViewType:
            {
                contentView = _collectionView;
            }
                break;
            default:
                break;
        }
        //关闭自动自动计算insets 解决融云和MJRefresh共存的情况下不兼容的问题
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        UIEdgeInsets insets = UIEdgeInsetsZero;
//        insets.top = UIDevice.sw_navigationBarHeight - ([UIApplication sharedApplication].isStatusBarHidden?UIDevice.sw_statusBarHeight:0);
//        //适配iOS13,默认情况下iOS13模态出的导航条高度为56
//        if(self.navigationController.navigationBar.frame.size.height == 56){
//            insets.top = 56;
//        }
        CGRect convertContentViewRect = [self.view convertRect:contentView.frame toCoordinateSpace:[UIScreen mainScreen].coordinateSpace];
        CGRect convertNavbarRect = [self.navigationController.navigationBar.superview convertRect:self.navigationController.navigationBar.frame toCoordinateSpace:[UIScreen mainScreen].coordinateSpace];
        BOOL isIntersect1 = CGRectIntersectsRect(convertContentViewRect, convertNavbarRect);
        BOOL isNavRouteVc = [self.navigationController.viewControllers indexOfObject:self] != NSNotFound;
        if(isNavRouteVc && isIntersect1){
            CGFloat diffValue = (convertNavbarRect.origin.y - convertContentViewRect.origin.y);//导航高度的原点y和contentView的原点y的差值(就是状态栏的高度)
            insets.top = diffValue + convertNavbarRect.size.height;
        }
        CGRect convertTabbarRect = [self.tabBarController.tabBar convertRect:CGRectMake(0, 0, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height) toCoordinateSpace:[UIScreen mainScreen].coordinateSpace];
        BOOL isIntersect2 = CGRectIntersectsRect(convertContentViewRect, convertTabbarRect);
        if(self.tabBarController && isIntersect2 && !self.tabBarController.tabBar.isHidden && isNavRouteVc && !self.hidesBottomBarWhenPushed){
            insets.bottom = self.tabBarController.tabBar.frame.size.height;
        }else{
            CGRect unsafeRect = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - UIDevice.sw_safeBottomInset, [UIScreen mainScreen].bounds.size.width, UIDevice.sw_safeBottomInset);
            if(CGRectIntersectsRect(convertContentViewRect, unsafeRect)){
                insets.bottom = UIDevice.sw_safeBottomInset - (CGRectGetMaxY(unsafeRect) - CGRectGetMaxY(convertContentViewRect));
            }
        }
        if(!UIEdgeInsetsEqualToEdgeInsets(_scrollView.contentInset, insets)){
            _scrollView.contentInset = insets;
            _scrollView.contentOffset = CGPointMake(0, -insets.top);
        }
    }
}

- (void)setContentViewInsets:(UIEdgeInsets)contentViewInsets {
    if(!UIEdgeInsetsEqualToEdgeInsets(contentViewInsets, _contentViewInsets)){
        _contentViewInsets = contentViewInsets;
        [self.view setNeedsLayout];
        //不能立即调用layoutIfNeeded 会处方tableView/collectionView的dataSource方法 在registerCell之前执行会crash
        //    [self.view layoutIfNeeded];
    }
}

//屏幕即将反正旋转api
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    //coordinator:动画过渡协调器
//    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        //动画执行中
//        [self sw_updateBarFrame];//解决屏幕反正旋转之后自定义Bar frame错乱的bug
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
//        //动画执行完毕
//    }];
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sw_configNavigation:animated];
    [self updateNavigationBarWithScrollViewDidScroll:self.tableView?self.tableView:(self.collectionView?self.collectionView:nil)];
}

- (void)sw_configNavigation:(BOOL)animated {
    if(![self isNavigationRouteVc]) return;
//    [self.navigationController.navigationBar setTranslucent:self.translucentNavigationBar];
    [self.navigationController.navigationBar setShadowImage:self.navigationBarBottomLineHidden?[UIImage sw_createImageWithColor:[UIColor clearColor]]:nil];
    [self.navigationController.navigationBar setBarTintColor:self.navigationBarBackgroundColor];
    [self.navigationController.navigationBar setBackgroundImage:self.navigationBarBackgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:animated];
    self.navigationController.navigationBar.tintColor = self.navigationItemColor;
    [self.navigationController.navigationBar setTitleTextAttributes:self.navigationBarTitleTextAttributes];
    if (@available(iOS 15.0, *)) {
        //适配iOS15:在iOS15系统下navigationBar的背景默认是透明的,之前对导航栏的设置方法已失效,需要使用下面方法
        /*scrollEdgeAppearance 属性
         iOS15 强制适用于所有导航器
         当导航控制器包含导航栏和滚动视图时，滚动视图的部分内容将显示在导航栏下方。如果滚动内容的边缘到达该栏，UIKit将在此属性中应用外观设置。如果此属性的值为nil，UIKit将使用standardAppearance属性中的设置，并修改为使用透明背景。如果没有导航控制器管理您的导航栏，UIKit将忽略此属性，并使用导航栏的标准外观。在使用iOS 14或更低版本的应用程序上运行时，此属性适用于标题较大的导航栏。在iOS 15中，此属性适用于所有导航栏。
         */
        UINavigationBarAppearance *barAppearence = [[UINavigationBarAppearance alloc] init];
        [barAppearence configureWithOpaqueBackground];
        [barAppearence setBackgroundColor:self.navigationBarBackgroundColor];
        //ios15上如果setBackgroundImage为[UIImage new]或者[UIImage sw_createImageWithColor:[UIColor clearColor]]将无法改变背景
        [barAppearence setBackgroundImage:self.navigationBarBackgroundImage];
        //ios15上如果setBackgroundImage为[UIImage new]无法隐藏分割线
        [barAppearence setShadowImage:self.navigationBarBottomLineHidden?[UIImage sw_createImageWithColor:[UIColor clearColor]]:nil];
        [barAppearence setTitleTextAttributes:self.navigationBarTitleTextAttributes];
        self.navigationController.navigationBar.standardAppearance = barAppearence;
        self.navigationController.navigationBar.scrollEdgeAppearance = barAppearence;
        self.navigationController.navigationBar.compactAppearance = barAppearence;
        self.navigationController.navigationBar.compactScrollEdgeAppearance = barAppearence;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateScrollViewContentInsets];
    [self updateNavigationBarWithScrollViewDidScroll:self.tableView?self.tableView:(self.collectionView?self.collectionView:nil)];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[[UIApplication sharedApplication].delegate window].rootViewController setNeedsStatusBarAppearanceUpdate];
}

- (UIImage *)sw_createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if([self tableView:self.tableView viewForHeaderInSection:section] == nil ) return 0;
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if([self tableView:self.tableView viewForFooterInSection:section] == nil) return 0;
    return UITableViewAutomaticDimension;
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - DZN
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    return [[NSAttributedString alloc] initWithString:@"空空如也" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
}

#pragma mark - WKWebView
- (void)setUrl:(NSURL *)url {
    _url = url;
    if(self.isViewLoaded && url){
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}
- (void)setHtmlString:(NSString *)htmlString {
    _htmlString = [htmlString copy];
    if(self.controllerType == SWBaseViewControllerWebViewType && htmlString.length > 0){
        [_webView loadHTMLString:htmlString baseURL:nil];
    }
}

- (void)setMaximumScale:(CGFloat)maximumScale {
    if(maximumScale < 1.0) maximumScale = 1.0;
    _maximumScale = maximumScale;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSString *str = nil;
    if(self.forceDisableScale){
        // 禁止放大缩小
        str = @"no";
        NSString *injectionJSString = [NSString stringWithFormat:@"var script = document.createElement('meta');"
                                       "script.name = 'viewport';"
                                       "script.content=\"width=device-width, initial-scale=1.0,maximum-scale=%f, minimum-scale=1.0, user-scalable=%@\";"
                                       "document.getElementsByTagName('head')[0].appendChild(script);",self.maximumScale,str];
        [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    }else{
//        str = @"yes";
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateNavigationBarWithScrollViewDidScroll:scrollView];
}

- (void)updateNavigationBarWithScrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.enableGradientNavigationBarColor) return;
    CGFloat percent = (scrollView.contentOffset.y - scrollView.contentInset.top - self.gradientNavigationColorBeginOffset)/UIDevice.sw_navigationBarHeight;
    percent = percent < 0?0:percent;
    percent = percent >= 1.0?1.0:percent;
    self.navigationItem.title = percent > 0.5?self.gradientNavigationTitleForOpacity:self.gradientNavigationTitleForTranslucent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage sw_createImageWithColor:[self.gradientNavigationColorForOpacity colorWithAlphaComponent:percent]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc {
    NSLog(@"%@---dealloc",[self class]);
}

@end
