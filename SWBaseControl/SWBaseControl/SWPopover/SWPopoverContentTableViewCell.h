//
//  SWPopoverContentTableViewCell.h
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/27.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPopoverContentTableViewCell : UITableViewCell

/**
 init subviews
 */
- (void)prepare;
/**
 the line between left and right distance,default is UIEdgeInsetsMake(0, 8, 0, 8)
 */
@property (nonatomic) UIEdgeInsets sw_separatorInset;
/**
 is enable stroke line,default is YES
 */
@property (nonatomic) BOOL shouldStrokeLine;
/**
 default is white
 */
@property (nonatomic,copy) UIColor *lineStrokeColor;

/**
 config your UI with data
 */
@property (nonatomic,strong) id model;

@end
