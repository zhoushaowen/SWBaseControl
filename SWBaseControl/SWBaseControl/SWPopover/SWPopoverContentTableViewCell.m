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
    self.shouldStrokeLine = YES;
    self.lineStrokeColor = [UIColor whiteColor];
    self.sw_separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor whiteColor];
    self.selectedBackgroundView = [UIView new];
    self.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
}

- (void)drawRect:(CGRect)rect {
    if(!self.shouldStrokeLine) return;
    [self.lineStrokeColor?:[UIColor whiteColor] set];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath setLineWidth:1/[UIScreen mainScreen].scale];
    [bezierPath moveToPoint:CGPointMake(self.sw_separatorInset.left, self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width - self.sw_separatorInset.right, self.bounds.size.height)];
    [bezierPath stroke];
}

- (void)setShouldStrokeLine:(BOOL)shouldStrokeLine {
    _shouldStrokeLine = shouldStrokeLine;
    [self setNeedsDisplay];
}


@end
