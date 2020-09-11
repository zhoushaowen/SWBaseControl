//
//  BaseTextFieldController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/9/11.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "BaseTextFieldController.h"
#import <SWBaseTextField.h>

@interface BaseTextFieldController ()
@property (weak, nonatomic) IBOutlet SWBaseTextField *textField;

@end

@implementation BaseTextFieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textField.textDidBeginEditing = ^(NSNotification * _Nonnull noti) {
        NSLog(@"%@",noti);
    };
    self.textField.textDidChange = ^(NSString * _Nonnull text, NSNotification * _Nonnull noti) {
        NSLog(@"%@---%@",noti,text);
    };
    self.textField.textDidEndEditing = ^(NSString * _Nonnull text, NSNotification * _Nonnull noti) {
        NSLog(@"%@---%@",noti,text);
    };
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
