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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    self.textView.text = @"123";
}



@end
