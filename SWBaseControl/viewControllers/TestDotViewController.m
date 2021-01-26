//
//  TestDotViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2021/1/26.
//  Copyright © 2021 zhoushaowen. All rights reserved.
//

#import "TestDotViewController.h"
#import "SWDotView.h"

@interface TestDotViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,strong) SWDotView *dotView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;

@end

@implementation TestDotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dotView = [[SWDotView alloc] initWithTargetView:self.btn];
}
- (IBAction)btnAction:(UIButton *)sender {
//    self.dotView.position = SWDotViewPositionBottomLeft;
//    self.dotView.offset = CGPointMake(10, 10);
    self.widthCons.constant += 2;
    self.heightCons.constant += 5;
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
