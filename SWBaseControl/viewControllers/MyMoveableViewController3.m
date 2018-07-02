//
//  MyMoveableViewController3.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/7/2.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "MyMoveableViewController3.h"

@interface MyMoveableViewController3 ()
{
    UIView *_testView;
}
@end

@implementation MyMoveableViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _testView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 500, self.view.bounds.size.width, 500)];
    _testView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_testView];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:_testView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 0)];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path = bezierPath.CGPath;
    _testView.layer.mask = shaperLayer;
}

- (UIView *)moveableView {
    return _testView;
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
