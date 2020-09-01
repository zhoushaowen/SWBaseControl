//
//  SWTextPopoverView.m
//  SWBaseControl
//
//  Created by zhoushaowen on 2020/9/1.
//  Copyright © 2020 zhoushaowen. All rights reserved.
//

#import "SWTextPopoverView.h"
#import "SWPopoverContentTableView.h"

#define kMargin UIEdgeInsetsMake(15, 15, 15, 15)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@implementation SWTextPopoverView
{
    __weak UIView *_targetView;
    NSArray<NSString *> *_titles;
}

- (instancetype)initWithTargetView:(UIView *)targetView titles:(nonnull NSArray<NSString *> *)titles {
    self.rowHeight = 44.0;
    self.maxDisplayRowCount = 5;
    self.textFont = [UIFont systemFontOfSize:15];
    self.width = 130;
    self.textAlignment = NSTextAlignmentCenter;
    _targetView = targetView;
    _titles = titles;
    SWPopoverContentTableView *contentView = [SWPopoverContentTableView new];
    contentView.rowHeight = self.rowHeight;
    contentView.textFont = self.textFont;
    contentView.dataSource = titles;
    contentView.textAlignment = self.textAlignment;
    __weak typeof(self) weakSelf = self;
    contentView.didSelectedIndex = ^(NSInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(strongSelf.didSelectedItem){
            strongSelf.didSelectedItem(index, titles[index]);
        }
    };
    CGSize contentViewSize = CGSizeMake(self.width, contentView.rowHeight*(titles.count > self.maxDisplayRowCount?self.maxDisplayRowCount:titles.count));
    self = [super initWithContentView:contentView contentViewSize:contentViewSize arrowPoint:CGPointZero arrowDirection:self.arrowDirection contentViewCenterOffset:0];
    if(self){
        [self updatePositionWithContentView:contentView];
    }
    return self;
}

- (void)updatePositionWithContentView:(SWPopoverContentTableView *)contentView  {
    if(contentView == nil) return;
    CGRect convertRect = [_targetView.superview convertRect:_targetView.frame toCoordinateSpace:[UIScreen mainScreen].fixedCoordinateSpace];
    CGSize contentViewSize = self.contentViewSize;
    CGPoint arrowPoint = CGPointZero;
    CGFloat contentViewCenterOffset = 0;
    CGFloat midX = CGRectGetMidX(convertRect);
    if((CGRectGetMaxY(convertRect) + contentViewSize.height + kMargin.bottom) <= kScreenHeight){//targetView在屏幕上方
        self.arrowDirection = SWPopoverArrowDirectionTop;
        if(midX >= 15 && midX <= kScreenWidth - kMargin.right){
            arrowPoint = CGPointMake(midX, CGRectGetMaxY(convertRect));
        }else if (midX > kScreenWidth - kMargin.right){
            midX = CGRectGetMinX(convertRect);
            arrowPoint = CGPointMake(midX, CGRectGetMaxY(convertRect));
        }else{
            midX = CGRectGetMaxX(convertRect);
            arrowPoint = CGPointMake(midX, CGRectGetMaxY(convertRect));
        }
    }else if (CGRectGetMinY(convertRect) > (contentViewSize.height + kMargin.top)){//targetView在屏幕下方
        self.arrowDirection = SWPopoverArrowDirectionBottom;
        if(midX >= 15 && midX <= kScreenWidth - kMargin.right){
            arrowPoint = CGPointMake(midX, CGRectGetMinY(convertRect));
        }else if (midX > kScreenWidth - kMargin.right){
            midX = CGRectGetMinX(convertRect);
            arrowPoint = CGPointMake(midX, CGRectGetMinY(convertRect));
        }else{
            midX = CGRectGetMaxX(convertRect);
            arrowPoint = CGPointMake(midX, CGRectGetMinY(convertRect));
        }
    }
    CGFloat value = midX + contentViewSize.width/2.0 + kMargin.right - kScreenWidth;
    if(value > 0){//超出边界了
        contentViewCenterOffset = - value;
    }else{
        value = kMargin.left + contentViewSize.width/2.0 - midX;
        if(value > 0){//超出边界了
            contentViewCenterOffset = value;
        }
    }
    self.contentViewCenterOffset = contentViewCenterOffset;
    self.arrowPoint = arrowPoint;
}

- (void)setRowHeight:(CGFloat)rowHeight {
    _rowHeight = rowHeight;
    ((SWPopoverContentTableView *)self.contentView).rowHeight = rowHeight;
    self.contentViewSize = CGSizeMake(self.width, self.rowHeight*self.maxDisplayRowCount);
    [self updatePositionWithContentView:(SWPopoverContentTableView *)self.contentView];
}

- (void)setMaxDisplayRowCount:(NSInteger)maxDisplayRowCount {
    _maxDisplayRowCount = maxDisplayRowCount;
    self.contentViewSize = CGSizeMake(self.width, self.rowHeight*self.maxDisplayRowCount);
    [self updatePositionWithContentView:(SWPopoverContentTableView *)self.contentView];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    ((SWPopoverContentTableView *)self.contentView).textFont = textFont;
}

- (void)setWidth:(CGFloat)width {
    _width = width;
    self.contentViewSize = CGSizeMake(width, self.rowHeight*self.maxDisplayRowCount);
    [self updatePositionWithContentView:(SWPopoverContentTableView *)self.contentView];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    ((SWPopoverContentTableView *)self.contentView).textAlignment = textAlignment;
}

@end
