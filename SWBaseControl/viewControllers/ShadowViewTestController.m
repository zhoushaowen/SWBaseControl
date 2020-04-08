//
//  ShadowViewTestController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/4/8.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "ShadowViewTestController.h"
#import <Masonry.h>
#import <SWCornerShadowView.h>

@interface ShadowViewTestController ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ShadowViewTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SWCornerShadowView *shadowView = [[SWCornerShadowView alloc] init];
    shadowView.shadowCornerRadius = 20;
    shadowView.shadowRadius = 5;
    shadowView.shadowOffset = CGSizeMake(0, -5);
//    shadowView.shadowColor = [UIColor redColor];
    [self.backView addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.clipsToBounds = YES;
    [shadowView.contentView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    SWCornerShadowView *shadowView2 = [[SWCornerShadowView alloc] init];
    shadowView2.shadowCornerRadius = 20;
    shadowView2.shadowRadius = 5;
    shadowView2.shadowOffset = CGSizeMake(0, 5);
    shadowView2.shadowBackgroundColor = [UIColor systemPinkColor];
    [self.view addSubview:shadowView2];
    [shadowView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(shadowView);
        make.top.equalTo(shadowView.mas_bottom).mas_offset(30);
        make.centerX.equalTo(shadowView);
    }];
    
    
    
}

@end
