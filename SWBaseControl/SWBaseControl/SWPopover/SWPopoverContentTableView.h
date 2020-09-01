//
//  PopoverViewContentView.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/27.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPopoverContentTableView : UIView

/**
 set dataSource will automatically reload tableView
 */
@property (nonatomic,copy) NSArray *dataSource;
/**
 default is 44.0
 */
@property (nonatomic) CGFloat rowHeight;

@property (nonatomic) UIFont *textFont;

@property (nonatomic) NSTextAlignment textAlignment;

@property (nonatomic,strong) void(^didSelectedIndex)(NSInteger index);
/**
 you can overrid the method.
 you must return a SWPopoverContentTableViewCell class or sub class.
 */
- (Class)registerCellClassForTableView;
/**
 you can overrid the method.
 you must return a SWPopoverContentTableViewCell class or sub class nib.
 if you return a nib the registerCellClassForTableView will ignore.
 */
- (UINib *)registerNibForTableView;
/**
 initialize subviews
 */
- (void)prepare NS_REQUIRES_SUPER;

@end
