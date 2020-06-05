//
//  SWTopImgBottomTextButton.m
//  JunWangShopping
//
//  Created by zhoushaowen on 2020/5/28.
//  Copyright © 2020 coderZhou. All rights reserved.
//

#import "SWTopImgBottomTextButton.h"

@implementation SWTopImgBottomTextButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image {
    SWTopImgBottomTextButton *btn = [SWTopImgBottomTextButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    return btn;
}

- (void)setup {
    self.vSpaceBetweenTitleAndImg = 2;
    if(self.currentTitleColor == nil){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];        
    }
}

- (CGSize)intrinsicContentSize {
    __block CGRect imageFrame = CGRectZero;
    __block CGRect labelFrame = CGRectZero;
    [self calculateControlFrame:^(CGRect aImageFrame, CGRect aLabelFrame) {
        imageFrame = aImageFrame;
        labelFrame = aLabelFrame;
    }];
    return CGSizeMake(MAX(imageFrame.size.width, labelFrame.size.width) + self.contentEdgeInsets.left + self.contentEdgeInsets.right, labelFrame.size.height + imageFrame.size.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom + self.vSpaceBetweenTitleAndImg);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self invalidateIntrinsicContentSize];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self invalidateIntrinsicContentSize];
}

- (void)setVSpaceBetweenTitleAndImg:(CGFloat)vSpaceBetweenTitleAndImg {
    _vSpaceBetweenTitleAndImg = vSpaceBetweenTitleAndImg;
    [self invalidateIntrinsicContentSize];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self calculateControlFrame:^(CGRect aImageFrame, CGRect aLabelFrame) {
        self.imageView.frame = aImageFrame;
        self.titleLabel.frame = aLabelFrame;
    }];
}

- (void)calculateControlFrame:(void(^)(CGRect imageFrame,CGRect labelFrame))block {
    UIImage *image = self.currentImage;
    CGRect rect = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
    CGFloat maxWidth = MAX(image.size.width, rect.size.width);
    maxWidth = MAX(maxWidth, self.bounds.size.width);
    CGRect imageFrame = CGRectMake(self.contentEdgeInsets.left+(maxWidth- image.size.width)/2.0f, self.contentEdgeInsets.top, image.size.width, image.size.height);
    CGRect labelFrame = CGRectMake(self.contentEdgeInsets.left+(maxWidth- rect.size.width)/2.0f, CGRectGetMaxY(imageFrame)+self.vSpaceBetweenTitleAndImg, rect.size.width, rect.size.height);
    if(block){
        block(imageFrame,labelFrame);
    }
}


@end
