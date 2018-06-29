//
//  SWPopoverContentTableViewCell.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2018/6/27.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWPopoverContentTableViewCell.h"

@implementation SWPopoverContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self prepare];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        [self prepare];
    }
    return self;
}

- (void)prepare {
    self.backgroundColor = [UIColor clearColor];
    self.layoutMargins = UIEdgeInsetsMake(0, 8, 0, 8);
    self.textLabel.textColor = [UIColor whiteColor];
    self.selectedBackgroundView = [UIView new];
    self.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
}

- (void)setModel:(id)model {
    _model = model;
}


@end
