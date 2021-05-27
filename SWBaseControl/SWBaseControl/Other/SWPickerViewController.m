//
//  SWPickerViewController.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/8/6.
//

#import "SWPickerViewController.h"
#import <SWCustomPresentation/SWCustomPresentation.h>


@interface SWPickerViewController ()
{
    UIPickerView *_pickerView;
    CALayer *_line;
    UIButton *_cancelBtn,*_confirmBtn;
}

@property (nonatomic,weak) id<SWPickerViewControllerDelegate> delegate;

@end

@implementation UIViewController (SWPickerViewController)

- (SWPickerViewController *)sw_presentPickerViewController:(SWPickerViewController *)pickerViewController withDelegate:(id<SWPickerViewControllerDelegate>)delegate {
    pickerViewController.delegate = delegate;
    [self sw_presentCustomModalPresentationWithViewController:pickerViewController containerViewWillLayoutSubViewsBlock:^(SWPresentationController * _Nonnull presentationController) {
        presentationController.presentedView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 300);
    } animatedTransitioningModel:nil completion:nil];
    return pickerViewController;
}

@end

@implementation SWPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.view.backgroundColor = [UIColor whiteColor];
    _line = [CALayer layer];
    _line.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:_line];
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
    NSString *language = [self getLanguage];
    NSArray *titles = nil;
    if([language hasPrefix:@"zh-Hans"]){//简体中文
        titles = @[@"取消",@"确定"];
    }else if ([language hasPrefix:@"zh-Hant"]){//繁体中文
        titles = @[@"取消",@"確定"];
    }else{
        titles = @[@"Cancel",@"OK"];
    }
    NSArray *colors = @[[UIColor colorWithRed:117/255.0f green:117/255.0f blue:117/255.0f alpha:1.0],self.styleColor?:[UIColor colorWithRed:26/255.0 green:178/255.0 blue:10/255.0 alpha:1.0]];
    for(int i=0;i<2;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:colors[i] forState:UIControlStateNormal];
        if(i==0){
            _cancelBtn = btn;
        }else{
            _confirmBtn = btn;
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (NSString*)getPreferredLanguage
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    
    NSString* preferredLang = [languages objectAtIndex:0];
    
    NSLog(@"Preferred Language:%@", preferredLang);
    
    return preferredLang;
}

- (NSString *)getLanguage {
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    if (!language) {
        language = [self getPreferredLanguage];
    }
    return language;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _line.frame = CGRectMake(0, 40, self.view.bounds.size.width, 1/[UIScreen mainScreen].scale);
    _pickerView.frame = CGRectMake(0, 40, self.view.bounds.size.width, 300 - 40);
    _cancelBtn.frame = CGRectMake(0, 0, 156/2.0f, 40);
    _confirmBtn.frame = CGRectMake(self.view.bounds.size.width - 156/2.0f, 0, 156/2.0f, 40);
}

- (void)setStyleColor:(UIColor *)styleColor {
    _styleColor = styleColor;
    if(_styleColor == nil){
        _styleColor = [UIColor colorWithRed:26/255.0 green:178/255.0 blue:10/255.0 alpha:1.0];
    }
    [_confirmBtn setTitleColor:_styleColor forState:UIControlStateNormal];
}

- (void)btnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(sender == _confirmBtn){
        if(_delegate && [_delegate respondsToSelector:@selector(pickerViewControllerDidClickConfirmButton:)]){
            [_delegate pickerViewControllerDidClickConfirmButton:self];
        }
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
