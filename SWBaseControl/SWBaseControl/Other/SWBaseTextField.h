//
//  SWBaseTextField.h
//  ZhuHaiSocialAPP
//
//  Created by zhoushaowen on 2019/7/18.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWBaseTextField : UITextField

@property (nonatomic,strong) CGRect(^borderRectForBounds)(CGRect borderRectForBounds,CGRect bounds);
@property (nonatomic,strong) CGRect(^textRectForBounds)(CGRect textRectForBounds,CGRect bounds);
@property (nonatomic,strong) CGRect(^placeholderRectForBounds)(CGRect placeholderRectForBounds,CGRect bounds);
@property (nonatomic,strong) CGRect(^editingRectForBounds)(CGRect editingRectForBounds,CGRect bounds);
@property (nonatomic,strong) CGRect(^clearButtonRectForBounds)(CGRect clearButtonRectForBounds,CGRect bounds);
@property (nonatomic,strong) CGRect(^leftViewRectForBounds)(CGRect leftViewRectForBounds,CGRect bounds);
@property (nonatomic,strong) CGRect(^rightViewRectForBounds)(CGRect rightViewRectForBounds,CGRect bounds);
@property (nonatomic,strong) void(^drawTextInRect)(CGRect rect);
@property (nonatomic,strong) void(^drawPlaceholderInRect)(CGRect rect);

@end

NS_ASSUME_NONNULL_END
