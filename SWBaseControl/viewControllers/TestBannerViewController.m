//
//  TestBannerViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/7.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "TestBannerViewController.h"
#import <SWBannerView.h>
#import <SWExtension.h>

@interface TestBannerViewController ()<SWBannerViewDelegate>
{
    NSArray *_array;
}

@end

@implementation TestBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SWBannerView *bannerView = [[SWBannerView alloc] init];
    bannerView.delegate = self;
    bannerView.scrollInterval = 2;
    bannerView.initialIndex = 1;
    bannerView.frame = CGRectMake(0, 20+SWNavigationBarHeight, self.view.bounds.size.width, 200);
    [self.view addSubview:bannerView];
    _array = @[@"1",@"2",@"3"];
//    _array = @[@"1"];
}

- (NSUInteger)sw_numberOfItemsInBannerView:(SWBannerView *)bannerView
{
    return _array.count;
}

- (void)sw_bannerView:(SWBannerView *)bannerView imageView:(UIImageView *)imageView forIndex:(NSInteger)index
{
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[[_array[index] stringByAppendingString:@"@2x"] stringByAppendingPathExtension:@"png"] ofType:nil]];
    imageView.image = image;
}

- (void)sw_bannerView:(SWBannerView *)bannerView didScrollToIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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
