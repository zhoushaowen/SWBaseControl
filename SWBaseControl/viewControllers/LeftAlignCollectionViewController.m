//
//  LeftAlignCollectionViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/3/11.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "LeftAlignCollectionViewController.h"
#import <Masonry.h>
#import <SWCollectionViewLeftAlignLayout.h>
#import <SWCornerShadowView.h>

@interface LeftAlignCollectionViewController ()

@end

@implementation LeftAlignCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self = [super initWithCollectionViewLayout:[[SWCollectionViewLeftAlignLayout alloc] init]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    SWCornerShadowView *shadowView = [cell.contentView viewWithTag:200];
    if(shadowView == nil){
        shadowView = [[SWCornerShadowView alloc] init];
        shadowView.tag = 200;
        [cell.contentView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    UILabel *label = [shadowView.contentView viewWithTag:100];
    if(label == nil){
        label = [[UILabel alloc] init];
        label.tag = 100;
        [shadowView.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
    }
    shadowView.shadowBackgroundColor = indexPath.section == 0? [UIColor redColor]:[UIColor blueColor];
    label.text = [NSString stringWithFormat:@"%d",indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.item == 0){
        return CGSizeMake(self.view.bounds.size.width, 40);
    }
    return CGSizeMake(20+arc4random_uniform(80), 40+arc4random_uniform(10));
//    return CGSizeMake(20+indexPath.item*40, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

@end
