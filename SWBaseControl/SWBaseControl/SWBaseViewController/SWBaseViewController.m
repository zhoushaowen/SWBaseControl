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

@implementation UIView (SWBaseViewController)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSel = @selector(addSubview:);
        SEL cusSel = @selector(sw_addSubview:);
        Method systemMethod = class_getInstanceMethod([self class], sysSel);
        Method customMethod = class_getInstanceMethod([self class], cusSel);
        if(class_addMethod([self class], sysSel, method_getImplementation(customMethod), method_getTypeEncoding(customMethod))){
            class_replaceMethod([self class], cusSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            method_exchangeImplementations(systemMethod, customMethod);
        }
    });
}

- (void)sw_addSubview:(UIView *)view {
    [self sw_addSubview:view];
    if([[self nextResponder] isKindOfClass:[SWBaseViewController class]]){
        SWBaseViewController *vc = (SWBaseViewController *)[self nextResponder];
        [self bringSubviewToFront:vc.sw_bar];
    }
}

@end

static void *SW_bar_key = &SW_bar_key;
static void *SW_barBottomLine_key = &SW_barBottomLine_key;
static void *SW_barColor_key = &SW_barColor_key;
static void *SW_barBackgroundImage_key = &SW_barBackgroundImage_key;
static void *SW_visualView_key = &SW_visualView_key;
static void *SW_barBackgroundImageView_key = &SW_barBackgroundImageView_key;
static void *SW_barBottomLineImage_key = &SW_barBottomLineImage_key;

@interface UIViewController ()
//category私有属性
@property (nonatomic,strong) SWVisualEffectView *sw_visualView;
@property (nonatomic,strong) UIImageView *sw_barBackgroundImageView;
@property (nonatomic,strong) UIImageView *sw_barBottomLine;

@end

@implementation UIViewController (SWBaseViewController)

@dynamic sw_bar;
@dynamic sw_barColor;
@dynamic sw_barBackgroundImage;
@dynamic sw_barBottomLineImage;

- (void)sw_initSubViews {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    if(self.view.backgroundColor == nil){
        self.view.backgroundColor = [UIColor whiteColor];
    }
    self.sw_bar = [[UIView alloc] init];
    [self.view addSubview:self.sw_bar];
    self.sw_barBackgroundImageView = [[UIImageView alloc] initWithFrame:self.sw_bar.bounds];
    self.sw_barBackgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.sw_barBackgroundImageView.clipsToBounds = YES;
    [self.sw_bar addSubview:self.sw_barBackgroundImageView];
    
    self.sw_visualView = [[SWVisualEffectView alloc] initWithFrame:self.sw_bar.bounds];
    self.sw_visualView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.sw_bar addSubview:self.sw_visualView];
    
    CGFloat height = 1/[UIScreen mainScreen].scale;
    self.sw_barBottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.sw_bar.frame.size.height - height, self.sw_visualView.frame.size.width, height)];
    self.sw_barBottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    self.sw_barBottomLine.image = [self sw_createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
    self.sw_barBottomLineImage = self.sw_barBottomLine.image;
    [self.sw_bar addSubview:self.sw_barBottomLine];
    self.sw_bar.hidden = ![self.parentViewController isKindOfClass:[UINavigationController class]];
    @weakify(self)
    [self rac_observeKeyPath:@"view.frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self)
        [self sw_updateBarFrame];
    }];
    if(self.navigationController){
        [self rac_observeKeyPath:@"self.navigationController.navigationBar.frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
            @strongify(self)
            [self sw_updateBarFrame];
        }];
    }
}

- (void)sw_updateBarFrame {
    if(self.navigationController.presentingViewController){
        //适配iOS13,默认情况下iOS13模态出的导航条高度为56
        if (@available(iOS 13.0, *)) {
            if(self.navigationController.modalPresentationStyle == UIModalPresentationPopover || self.navigationController.modalPresentationStyle == UIModalPresentationPageSheet || self.navigationController.modalPresentationStyle == UIModalPresentationFormSheet ||
               self.navigationController.modalPresentationStyle ==
               UIModalPresentationAutomatic
               ){
                CGFloat height = self.navigationController.navigationBar.frame.size.height;
                self.sw_bar.frame = CGRectMake(0, -self.view.frame.origin.y, self.view.bounds.size.width, height);
                return;
            }
        } else {
            // Fallback on earlier versions
        }
    }
    CGFloat height = self.navigationController.navigationBar.frame.size.height;
    if(height != (UIDevice.sw_navigationBarHeight - UIDevice.sw_statusBarHeight)){
        //在导航的titleView上放searchBar 会导致navigationBar的高度变的比正常要高 ios13上实测高度为56
        height = MAX(height, UIDevice.sw_navigationBarHeight - UIDevice.sw_statusBarHeight);
        self.sw_bar.frame = CGRectMake(0, -self.view.frame.origin.y, self.view.bounds.size.width, height + ([UIApplication sharedApplication].isStatusBarHidden?0:UIDevice.sw_statusBarHeight));
    }else{
        if(UIDevice.sw_isIPhoneXSeries){
            self.sw_bar.frame = CGRectMake(0, -self.view.frame.origin.y, self.view.bounds.size.width, UIDevice.sw_navigationBarHeight);
        }else{
            self.sw_bar.frame = CGRectMake(0, -self.view.frame.origin.y, self.view.bounds.size.width, UIDevice.sw_navigationBarHeight - ([UIApplication sharedApplication].isStatusBarHidden?UIDevice.sw_statusBarHeight:0));
        }
    }
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

#pragma mark - Setter&Getter
- (void)setSw_bar:(UIView *)sw_bar {
    objc_setAssociatedObject(self, SW_bar_key, sw_bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)sw_bar {
    return objc_getAssociatedObject(self, SW_bar_key);
}

- (void)setSw_barBottomLine:(UIImageView *)sw_barBottomLine {
    objc_setAssociatedObject(self, SW_barBottomLine_key, sw_barBottomLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)sw_barBottomLine {
    return objc_getAssociatedObject(self, SW_barBottomLine_key);
}

- (void)setSw_barColor:(UIColor *)sw_barColor {
    objc_setAssociatedObject(self, SW_barColor_key, sw_barColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.sw_visualView.sw_tintColor = sw_barColor;
}

- (UIColor *)sw_barColor {
    return objc_getAssociatedObject(self, SW_barColor_key);
}

- (void)setSw_barBackgroundImage:(UIImage *)sw_barBackgroundImage {
    objc_setAssociatedObject(self, &sw_barBackgroundImage, sw_barBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.sw_barBackgroundImageView.image = sw_barBackgroundImage;
    self.sw_visualView.hidden = sw_barBackgroundImage != nil;
}

- (UIImage *)sw_barBackgroundImage {
    return objc_getAssociatedObject(self, SW_barBackgroundImage_key);
}

- (void)setSw_barBottomLineImage:(UIImage *)sw_barBottomLineImage {
    objc_setAssociatedObject(self, SW_barBottomLineImage_key, sw_barBottomLineImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(sw_barBottomLineImage == nil){
        self.sw_barBottomLine.image = [self sw_createImageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
    }else{
        self.sw_barBottomLine.image = sw_barBottomLineImage;
    }
}

- (UIImage *)sw_barBottomLineImage {
    return objc_getAssociatedObject(self, SW_barBottomLineImage_key);
}

- (void)setSw_visualView:(SWVisualEffectView *)sw_visualView {
    objc_setAssociatedObject(self, SW_visualView_key, sw_visualView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SWVisualEffectView *)sw_visualView {
    return objc_getAssociatedObject(self, SW_visualView_key);
}

- (void)setSw_barBackgroundImageView:(UIImageView *)sw_barBackgroundImageView {
    objc_setAssociatedObject(self, SW_barBackgroundImageView_key, sw_barBackgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)sw_barBackgroundImageView {
    return objc_getAssociatedObject(self, SW_barBackgroundImageView_key);
}


@end


@interface SWBaseViewController ()

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

//- (SWBaseViewControllerType)controllerType {
//    return _controllerType;
//}
- (instancetype)initWithControllerType:(SWBaseViewControllerType)controllerType {
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        self.controllerType = controllerType;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        self.tableViewStyle = style;
        self.controllerType = SWBaseViewControllerTableViewType;
    }
    return self;
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *_Nonnull)collectionViewLayout {
    self = [super initWithNibName:nil bundle:nil];
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
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        self.controllerType = SWBaseViewControllerWebViewType;
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sw_initSubViews];
    switch (self.controllerType) {
        case SWBaseViewControllerNormalType:
        {
            
        }
            break;
        case SWBaseViewControllerTableViewType:{
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom) style:self.tableViewStyle];
            _tableView.rowHeight = UITableViewAutomaticDimension;
            _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
            _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
            _tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
            _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
            _tableView.estimatedSectionFooterHeight = UITableViewAutomaticDimension;
//            _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            //去除UITableViewStyleGrouped样式导致的tableView头部空白间隙
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0.001)];
            _tableView.tableHeaderView = headerView;
            _tableView.tableFooterView = [UIView new];
            //防止外界全局更改了这个属性
            if (@available(iOS 11.0, *)) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            } else {
                // Fallback on earlier versions
                CGFloat inset = UIDevice.sw_navigationBarHeight - ([UIApplication sharedApplication].isStatusBarHidden?UIDevice.sw_statusBarHeight:0);
                //适配iOS13,默认情况下iOS13模态出的导航条高度为56
                if(self.navigationController.navigationBar.frame.size.height == 56){
                    inset = 56;
                }
                _tableView.contentInset = UIEdgeInsetsMake(inset, 0, 0, 0);
                _tableView.scrollIndicatorInsets = _tableView.contentInset;
            }
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [self.view addSubview:_tableView];
            [self addScrollViewContentOffsetObserver:_tableView];
        }
            break;
        case SWBaseViewControllerCollectionViewType:
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
//            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            //防止外界全局更改了这个属性
            if (@available(iOS 11.0, *)) {
                _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            } else {
                // Fallback on earlier versions
                CGFloat inset = UIDevice.sw_navigationBarHeight - ([UIApplication sharedApplication].isStatusBarHidden?UIDevice.sw_statusBarHeight:0);
                //适配iOS13,默认情况下iOS13模态出的导航条高度为56
                if(self.navigationController.navigationBar.frame.size.height == 56){
                    inset = 56;
                }
                _collectionView.contentInset = UIEdgeInsetsMake(inset, 0, 0, 0);
                _collectionView.scrollIndicatorInsets = _tableView.contentInset;
            }
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [self.view addSubview:_collectionView];
            [self addScrollViewContentOffsetObserver:_collectionView];
        }
            break;
        case SWBaseViewControllerWebViewType:
        {
            self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom)];
//            self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
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
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    switch (self.controllerType) {
        case SWBaseViewControllerTableViewType:
            {
                _tableView.frame = CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom);
            }
            break;
        case SWBaseViewControllerCollectionViewType:
        {
            _collectionView.frame = CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom);
        }
            break;
        case SWBaseViewControllerWebViewType:
        {
            _webView.frame = CGRectMake(self.contentViewInsets.left, self.contentViewInsets.top, self.view.bounds.size.width - self.contentViewInsets.left - self.contentViewInsets.right, self.view.bounds.size.height - self.contentViewInsets.top - self.contentViewInsets.bottom);
        }
            break;
            
        default:
            break;
    }
}

- (void)setContentViewInsets:(UIEdgeInsets)contentViewInsets {
    _contentViewInsets = contentViewInsets;
    [self.view setNeedsLayout];
//不能立即调用layoutIfNeeded 会处方tableView/collectionView的dataSource方法 在registerCell之前执行会crash
//    [self.view layoutIfNeeded];
}

//屏幕即将反正旋转api
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    //coordinator:动画过渡协调器
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        //动画执行中
        [self sw_updateBarFrame];//解决屏幕反正旋转之后自定义Bar frame错乱的bug
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        //动画执行完毕
    }];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[[UIApplication sharedApplication].delegate window].rootViewController setNeedsStatusBarAppearanceUpdate];
}

- (void)addScrollViewContentOffsetObserver:(UIScrollView *)scrollView {
    @weakify(self)
    [scrollView rac_observeKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self)
        //        NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
        if (@available(iOS 13.0, *)) {
#ifdef __IPHONE_13_0
            self.sw_visualView.sw_tintColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                @strongify(self)
                if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark && self.sw_barColor == nil){
                    self.sw_visualView.visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
                }else{
                    self.sw_visualView.visualView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                }
                CGFloat percent = (scrollView.contentOffset.y + self.sw_bar.bounds.size.height)/self.sw_bar.bounds.size.height;
                if(percent >= 1.0){
                    percent = 1.0;
                }
                //                NSLog(@"percent:%f",percent);
                if(percent > 0){
                    if(self.sw_barColor){
                        return [self.sw_barColor colorWithAlphaComponent:1.0-0.1*percent];
                    }else{
                        if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
                            return [[UIColor blackColor] colorWithAlphaComponent:1.0 - 0.9*percent];
                        }else{
                            return [[UIColor whiteColor] colorWithAlphaComponent:1.0-0.1*percent];
                        }
                    }
                }else{
                    if(self.sw_barColor){
                        return self.sw_barColor;
                    }else{
                        if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark){
                            return [UIColor blackColor];
                        }else{
                            return [UIColor whiteColor];
                        }
                    }
                }
                
            }];
#endif
        }else{
            CGFloat percent = (scrollView.contentOffset.y + self.sw_bar.bounds.size.height)/self.sw_bar.bounds.size.height;
            if(percent >= 1.0){
                percent = 1.0;
            }
            //            NSLog(@"percent:%f",percent);
            if(percent > 0){
                if(self.sw_barColor){
                    self.sw_visualView.sw_tintColor = [self.sw_barColor colorWithAlphaComponent:1.0-0.1*percent];
                }else{
                    self.sw_visualView.sw_tintColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0-0.1*percent];
                }
            }else{
                if(self.sw_barColor){
                    self.sw_visualView.sw_tintColor = self.sw_barColor;
                }else{
                    self.sw_visualView.sw_tintColor = [UIColor whiteColor];
                }
            }
        }
        
    }];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if([self tableView:self.tableView viewForHeaderInSection:section] == nil ) return 0.1;
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if([self tableView:self.tableView viewForFooterInSection:section] == nil) return 0.1;
    return UITableViewAutomaticDimension;
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
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
