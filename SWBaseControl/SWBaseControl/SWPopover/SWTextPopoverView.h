//
//  SWTextPopoverView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/9/1.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "SWPopoverView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTextPopoverView : SWPopoverView
/**
 default is 44.0
 */
@property (nonatomic) CGFloat rowHeight;
/// default is 5
@property (nonatomic) NSInteger maxDisplayRowCount;
/// default size is 15
@property (nonatomic) UIFont *textFont;

/// default is NSTextAlignmentCenter
@property (nonatomic) NSTextAlignment textAlignment;
/// default is 130
@property (nonatomic) CGFloat width;

@property (nonatomic,strong) void(^didSelectedItem)(NSInteger index,NSString *text);

- (instancetype)initWithTargetView:(UIView *)targetView titles:(NSArray<NSString *> *)titles;

@end

NS_ASSUME_NONNULL_END
