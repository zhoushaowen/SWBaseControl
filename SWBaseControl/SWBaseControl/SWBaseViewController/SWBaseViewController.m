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
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
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
}

- (void)sw_layoutSubviews {
    if (@available(iOS 11.0, *)) {
        self.sw_bar.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.safeAreaInsets.top);
    } else {
        CGFloat height = 44.0;
        height += [UIApplication sharedApplication].isStatusBarHidden ? 0 : 20;
        self.sw_bar.frame = CGRectMake(0, 0, self.view.bounds.size.width, height);
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
    objc_setAssociatedObject(self, SW_bar_key, sw_bar, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)sw_bar {
    return objc_getAssociatedObject(self, SW_bar_key);
}

- (void)setSw_barBottomLine:(UIImageView *)sw_barBottomLine {
    objc_setAssociatedObject(self, SW_barBottomLine_key, sw_barBottomLine, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)sw_barBottomLine {
    return objc_getAssociatedObject(self, SW_barBottomLine_key);
}

- (void)setSw_barColor:(UIColor *)sw_barColor {
    objc_setAssociatedObject(self, SW_barColor_key, sw_barColor, OBJC_ASSOCIATION_RETAIN);
    self.sw_visualView.sw_tintColor = sw_barColor;
}

- (UIColor *)sw_barColor {
    return objc_getAssociatedObject(self, SW_barColor_key);
}

- (void)setSw_barBackgroundImage:(UIImage *)sw_barBackgroundImage {
    objc_setAssociatedObject(self, &sw_barBackgroundImage, sw_barBackgroundImage, OBJC_ASSOCIATION_RETAIN);
    self.sw_barBackgroundImageView.image = sw_barBackgroundImage;
    self.sw_visualView.hidden = sw_barBackgroundImage != nil;
}

- (UIImage *)sw_barBackgroundImage {
    return objc_getAssociatedObject(self, SW_barBackgroundImage_key);
}

- (void)setSw_barBottomLineImage:(UIImage *)sw_barBottomLineImage {
    objc_setAssociatedObject(self, SW_barBottomLineImage_key, sw_barBottomLineImage, OBJC_ASSOCIATION_RETAIN);
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
    objc_setAssociatedObject(self, SW_visualView_key, sw_visualView, OBJC_ASSOCIATION_RETAIN);
}

- (SWVisualEffectView *)sw_visualView {
    return objc_getAssociatedObject(self, SW_visualView_key);
}

- (void)setSw_barBackgroundImageView:(UIImageView *)sw_barBackgroundImageView {
    objc_setAssociatedObject(self, SW_barBackgroundImageView_key, sw_barBackgroundImageView, OBJC_ASSOCIATION_RETAIN);
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

@end

@implementation SWBaseViewController

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
        self.collectionViewLayout = collectionViewLayout;
        self.controllerType = SWBaseViewControllerCollectionViewType;
    }
    return self;
}

- (UICollectionViewLayout *)collectionViewLayout {
    if(!_collectionViewLayout){
        _collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _collectionViewLayout;
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
            _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
            _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            _tableView.backgroundColor = [UIColor redColor];
            _tableView.tableFooterView = [UIView new];
            //防止外界全局更改了这个属性
            if (@available(iOS 11.0, *)) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            } else {
                // Fallback on earlier versions
            }
            _tableView.delegate = self;
            _tableView.dataSource = self;
            [self.view addSubview:_tableView];
        }
            break;
            case SWBaseViewControllerCollectionViewType:
        {
            _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
            _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            _collectionView.backgroundColor = [UIColor blueColor];
            //防止外界全局更改了这个属性
            if (@available(iOS 11.0, *)) {
                _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            } else {
                // Fallback on earlier versions
            }
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [self.view addSubview:_collectionView];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[[UIApplication sharedApplication].delegate window].rootViewController setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self sw_layoutSubviews];
//    switch (self.controllerType) {
//        case SWBaseViewControllerTableViewType:
//        {
//            _tableView.frame = self.view.bounds;
//        }
//            break;
//            case SWBaseViewControllerCollectionViewType:
//        {
//            _collectionView.frame = self.view.bounds;
//        }
//            break;
//
//        default:
//            break;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
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

@end
