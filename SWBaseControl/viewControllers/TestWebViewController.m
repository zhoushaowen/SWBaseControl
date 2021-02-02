//
//  TestWebViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/2/2.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "TestWebViewController.h"
#import <ReactiveObjC.h>
#import <SWExtension.h>

@interface TestWebViewController ()

@end

@implementation TestWebViewController

- (SWBaseViewControllerType)controllerType {
    return SWBaseViewControllerWebViewType;
}

- (UIColor *)navigationBarBackgroundColor {
    return [UIColor purpleColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.url = [NSURL URLWithString:@"https://www.baidu.com/"];
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
