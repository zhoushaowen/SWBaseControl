//
//  TestSWLabelController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/27.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "TestSWLabelController.h"
#import <SWLabel.h>
#import <Masonry/Masonry.h>

@interface TestSWLabelController ()
@property (weak, nonatomic) IBOutlet SWLabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end

@implementation TestSWLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label1.text = @"测试文字";
    self.label1.topInset = 10;
    self.label1.bottomInset = 10;
    self.label1.leftInset = 10;
    self.label1.rightInset = 10;
    CGSize size = [self.label1 sizeThatFits:CGSizeMake(300, 100)];
    NSLog(@"%@",NSStringFromCGSize(size));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.label1.text = nil;
//    self.label1.hidden = YES;
//    self.label2.text = nil;
//    self.label2.hidden = YES;
    
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
