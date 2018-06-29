//
//  PopoverViewContentView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/27.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPopoverContentTableView : UIView

@property (nonatomic,copy) NSArray *dataSource;
/**
 default is 5
 */
@property (nonatomic) NSUInteger maxDisplayRows;
/**
 default is 44.0
 */
@property (nonatomic) CGFloat rowHeight;

@property (nonatomic,strong) void(^didSelectedIndex)(NSInteger index);
/**
 you must return a SWPopoverContentTableViewCell class or sub class
 */
- (Class)registerCellClassForTableView;
/**
 initialize subviews
 */
- (void)prepare NS_REQUIRES_SUPER;

@end
