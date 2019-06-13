//
//  BaseTextViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2019/6/12.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "BaseTextViewController.h"
#import <SWBaseTextView.h>

@interface BaseTextViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet SWBaseTextView *textView;

@end

@implementation BaseTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
