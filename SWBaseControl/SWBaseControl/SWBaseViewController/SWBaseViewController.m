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
#import <SWExtension.h>
#import <NSObject+RACKVOWrapper.h>
#import <RACEXTScope.h>
#import <ReactiveObjC.h>

//@implementation UIView (SWBaseViewController)
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL sysSel = @selector(addSubview:);
//        SEL cusSel = @selector(sw_addSubview:);
//        Method systemMethod = class_getInstanceMethod([self class], sysSel);
//        Method customMethod = class_getInstanceMethod([self class], cusSel);
//        if(class_addMethod([self class], sysSel, method_getImplementation(customMethod), method_getTypeEncoding(customMethod))){
//            class_replaceMethod([self class], cusSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
//        }else{
//            method_exchangeImplementations(systemMethod, customMethod);
//        }
//    });
//}
//
//- (void)sw_addSubview:(UIView *)view {
//    [self sw_addSubview:view];
//    if([[self nextResponder] isKindOfClass:[SWBaseViewController class]]){
//        SWBaseViewController *vc = (SWBaseViewController *)[self nextResponder];
//        [self bringSubviewToFront:vc.sw_bar];
//    }
//}
//
//@end
//
//static void *SW_bar_key = &SW_bar_key;
//static void *SW_barBottomLine_key = &SW_barBottomLine_key;
//static void *SW_barColor_key = &SW_barColor_key;
//static void *SW_barBackgroundImage_key = &SW_barBackgroundImage_key;
//static void *SW_visualView_key = &SW_visualView_key;
//static void *SW_barBackgroundImageView_key = &SW_barBackgroundImageView_key;
//static void *SW_barBottomLineImage_key = &SW_barBottomLineImage_key;
//
//@interface UIViewController ()
////category私有属性
//@property (nonatomic,strong) SWVisualEffectView *sw_visualView;
//@property (nonatomic,strong) UIImageView *sw_barBackgroundImageView;
//@property (nonatomic,strong) UIImageView *sw_barBottomLine;
//
//@end
//
//@implementation UIViewController (SWBaseViewController)
//
//@dynamic sw_bar;
//@dynamic sw_barColor;
//@dynamic sw_barBackgroundImage;
//@dynamic sw_barBottomLineImage;
//
//- (void)sw_initSubViews {
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    if(self.view.backgroundColor == nil){
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
//    self.sw_bar = [[UIView alloc] init];
//    [self.view addSubview:self.sw_bar];
//    self.sw_barBackgroundImageView = [[UIImageView alloc] initWithFrame:self.sw_bar.bounds];
//    self.sw_barBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    self.sw_barBackgroundImageView.clipsToBounds = YES;
//    [self.sw_bar addSubview:self.sw_barBackgroundImageView];
//
//    self.sw_visualView = [[SWVisualEffectView alloc] initWithFrame:self.sw_bar.bounds];
//    self.sw_visualView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    [self.sw_bar addSubview:self.sw_visualView];
//
//    CGFloat height = 1/[UIScreen mainScreen].scale;
//    self.sw_barBottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.sw_bar.frame.size.height - height, self.sw_visualView.frame.size.width, height)];
//    self.sw_barBottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
//    self.sw_barBottomLine.image = [self sw_createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
//    self.sw_barBottomLineImage = self.sw_barBottomLine.image;
//    [self.sw_bar addSubview:self.sw_barBottomLine];
//    self.sw_bar.hidden = ![self.parentViewController isKindOfClass:[UINavigationController class]];
//    @weakify(self)
//    [self rac_observeKeyPath:@"view.frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//        @strongify(self)
//        [self sw_updateBarFrame];
//    }];
//    if(self.navigationController){
//        [self rac_observeKeyPath:@"self.navigationController.navigationBar.frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//            @strongify(self)
//            [self sw_updateBarFrame];
//        }];
//    }
//    [[self rac_signalForSelector:@selector(viewWillLayoutSubviews)] subscribeNext:^(RACTuple * _Nullable x) {
//        @strongify(self)
//        [self sw_updateBarFrame];
//    }];
//}
//
//- (void)sw_updateBarFrame {
//    CGRect convertViewRect = [self.view convertRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) toCoordinateSpace:[UIScreen mainScreen].coordinateSpace];
//    CGRect convertNavbarRect = [self.navigationController.navigationBar convertRect:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height) toCoordinateSpace:[UIScreen mainScreen].coordinateSpace];
//    CGFloat diffValue = (convertNavbarRect.origin.y - convertViewRect.origin.y);//导航高度的原点y和self.view的原点y的差值(就是状态栏的高度)
//    //这样的高度才是导航的真实高度
//    CGFloat realNavHeight = diffValue + convertNavbarRect.size.height;
//    if(realNavHeight > 0){
//        self.sw_bar.frame = CGRectMake(0, -self.view.frame.origin.y, self.view.bounds.size.width, realNavHeight);
//    }
//}
//
//- (UIImage *)sw_createImageWithColor:(UIColor *)color
//{
//    CGRect rect = CGRectMake(0, 0, 1, 1);
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
//#pragma mark - Setter&Getter
//- (void)setSw_bar:(UIView *)sw_bar {
//    objc_setAssociatedObject(self, SW_bar_key, sw_bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIView *)sw_bar {
//    return objc_getAssociatedObject(self, SW_bar_key);
//}
//
//- (void)setSw_barBottomLine:(UIImageView *)sw_barBottomLine {
//    objc_setAssociatedObject(self, SW_barBottomLine_key, sw_barBottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIImageView *)sw_barBottomLine {
//    return objc_getAssociatedObject(self, SW_barBottomLine_key);
//}
//
//- (void)setSw_barColor:(UIColor *)sw_barColor {
//    objc_setAssociatedObject(self, SW_barColor_key, sw_barColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    self.sw_visualView.sw_tintColor = sw_barColor;
//}
//
//- (UIColor *)sw_barColor {
//    return objc_getAssociatedObject(self, SW_barColor_key);
//}
//
//- (void)setSw_barBackgroundImage:(UIImage *)sw_barBackgroundImage {
//    objc_setAssociatedObject(self, &sw_barBackgroundImage, sw_barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    self.sw_barBackgroundImageView.image = sw_barBackgroundImage;
//    self.sw_visualView.hidden = sw_barBackgroundImage != nil;
//}
//
//- (UIImage *)sw_barBackgroundImage {
//    return objc_getAssociatedObject(self, SW_barBackgroundImage_key);
//}
//
//- (void)setSw_barBottomLineImage:(UIImage *)sw_barBottomLineImage {
//    objc_setAssociatedObject(self, SW_barBottomLineImage_key, sw_barBottomLineImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    if(sw_barBottomLineImage == nil){
//        self.sw_barBottomLine.image = [self sw_createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
//    }else{
//        self.sw_barBottomLine.image = sw_barBottomLineImage;
//    }
//}
//
//- (UIImage *)sw_barBottomLineImage {
//    return objc_getAssociatedObject(self, SW_barBottomLineImage_key);
//}
//
//- (void)setSw_visualView:(SWVisualEffectView *)sw_visualView {
//    objc_setAssociatedObject(self, SW_visualView_key, sw_visualView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (SWVisualEffectView *)sw_visualView {
//    return objc_getAssociatedObject(self, SW_visualView_key);
//}
//
//- (void)setSw_barBackgroundImageView:(UIImageView *)sw_barBackgroundImageView {
//    objc_setAssociatedObject(self, SW_barBackgroundImageView_key, sw_barBackgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIImageView *)sw_barBackgroundImageView {
//    return objc_getAssociatedObject(self, SW_barBackgroundImageView_key);
//}
//
//
//@end


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
            self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom)];
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
    [self.navigationController.navigationBar setShadowImage:self.navigationBarBottomLineHidden?[UIImage new]:nil];
    [self.navigationController.navigationBar setBarTintColor:self.navigationBarBackgroundColor];
    [self.navigationController.navigationBar setBackgroundImage:self.navigationBarBackgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:animated];
    self.navigationController.navigationBar.tintColor = self.navigationItemColor;
    [self.navigationController.navigationBar setTitleTextAttributes:self.navigationBarTitleTextAttributes];
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


//- (void)addScrollViewContentOffsetObserver:(UIScrollView *)scrollView {
//    @weakify(self)
//    [scrollView rac_observeKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//        @strongify(self)
//        //        NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//        if (@available(iOS 13.0, *)) {
//#ifdef __IPHONE_13_0
//            self.sw_visualView.sw_tintColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
//                @strongify(self)
//                if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && self.sw_barColor == nil){
//                    self.sw_visualView.visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//                }else{
//                    self.sw_visualView.visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//                }
//                CGFloat percent = (scrollView.contentOffset.y + self.sw_bar.bounds.size.height)/self.sw_bar.bounds.size.height;
//                if(percent >= 1.0){
//                    percent = 1.0;
//                }
//                //                NSLog(@"percent:%f",percent);
//                if(percent > 0){
//                    if(self.sw_barColor){
//                        return [self.sw_barColor colorWithAlphaComponent:1.0-0.1*percent];
//                    }else{
//                        if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
//                            return [[UIColor blackColor] colorWithAlphaComponent:1.0 - 0.9*percent];
//                        }else{
//                            return [[UIColor whiteColor] colorWithAlphaComponent:1.0-0.1*percent];
//                        }
//                    }
//                }else{
//                    if(self.sw_barColor){
//                        return self.sw_barColor;
//                    }else{
//                        if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
//                            return [UIColor blackColor];
//                        }else{
//                            return [UIColor whiteColor];
//                        }
//                    }
//                }
//
//            }];
//#endif
//        }else{
//            CGFloat percent = (scrollView.contentOffset.y + self.sw_bar.bounds.size.height)/self.sw_bar.bounds.size.height;
//            if(percent >= 1.0){
//                percent = 1.0;
//            }
//            //            NSLog(@"percent:%f",percent);
//            if(percent > 0){
//                if(self.sw_barColor){
//                    self.sw_visualView.sw_tintColor = [self.sw_barColor colorWithAlphaComponent:1.0-0.1*percent];
//                }else{
//                    self.sw_visualView.sw_tintColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0-0.1*percent];
//                }
//            }else{
//                if(self.sw_barColor){
//                    self.sw_visualView.sw_tintColor = self.sw_barColor;
//                }else{
//                    self.sw_visualView.sw_tintColor = [UIColor whiteColor];
//                }
//            }
//        }
//
//    }];
//}

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
