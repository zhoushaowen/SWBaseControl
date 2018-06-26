//
//  SWBaseButton.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/20.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWBaseButton : UIButton

- (instancetype)initWithType:(UIButtonType)buttonType style:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle;
/**
 startAnimating will automatically disable button's user interaction
 */
- (void)startAnimating;
/**
 stopAnimating will automatically enable button's user interaction
 */
- (void)stopAnimating;


@end
