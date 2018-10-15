//
//  SWBaseCollectionViewController.m
//  SWBaseViewController
//
//  Created by zhoushaowen on 2018/8/8.
//  Copyright © 2018年 Yidu. All rights reserved.
//

#import "SWBaseCollectionViewController.h"

@interface SWBaseCollectionViewController ()

@property (nonatomic,strong) UICollectionViewLayout *collectionViewLayout;

@end

@implementation SWBaseCollectionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *_Nonnull)collectionViewLayout {
    self = [super initWithNibName:nil bundle:nil];
    if(self){
        self.collectionViewLayout = collectionViewLayout;
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
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewLayout];
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

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
