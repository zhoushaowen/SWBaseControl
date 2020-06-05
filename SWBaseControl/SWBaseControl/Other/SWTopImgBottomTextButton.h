//
//  SWTopImgBottomTextButton.h
//  JunWangShopping
//
//  Created by zhoushaowen on 2020/5/28.
//  Copyright © 2020 coderZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTopImgBottomTextButton : UIButton

@property (nonatomic) IBInspectable CGFloat vSpaceBetweenTitleAndImg;

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image;



@end

NS_ASSUME_NONNULL_END
