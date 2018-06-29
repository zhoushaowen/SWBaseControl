//
//  MyPopoverContentTableViewCell.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "MyPopoverContentTableViewCell.h"

@implementation MyPopoverContentTableViewCell

- (void)setModel:(id)model {
    [super setModel:model];
    self.textLabel.text = (NSString *)self.model;
}


@end
