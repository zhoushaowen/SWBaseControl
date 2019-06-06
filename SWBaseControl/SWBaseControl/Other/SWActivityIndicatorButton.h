//
//  SWActivityIndicatorButton.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/20.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWBaseButton.h"

@interface SWActivityIndicatorButton : SWBaseButton

- (instancetype)initWithType:(UIButtonType)buttonType style:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle;
/**
  will automatically disable button's user interaction
 */
- (void)startAnimating;
/**
  will automatically enable button's user interaction
 */
- (void)stopAnimating;


@end
