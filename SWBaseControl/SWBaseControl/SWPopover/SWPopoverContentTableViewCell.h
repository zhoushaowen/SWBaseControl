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

@property (nonatomic,strong) id model;

@end
