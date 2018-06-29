//
//  MyPopoverContentTableView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/29.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "MyPopoverContentTableView.h"
#import "MyPopoverContentTableViewCell.h"

@implementation MyPopoverContentTableView

- (Class)registerCellClassForTableView {
    return [MyPopoverContentTableViewCell class];
}


@end
