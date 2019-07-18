//
//  SWBaseTextField.m
//  ZhuHaiSocialAPP
//
//  Created by zhoushaowen on 2019/7/18.
//  Copyright © 2019 zhoushaowen. All rights reserved.
//

#import "SWBaseTextField.h"

@implementation SWBaseTextField

- (CGRect)borderRectForBounds:(CGRect)bounds {
    if(self.borderRectForBounds){
        return self.borderRectForBounds([super borderRectForBounds:bounds],bounds);
    }
    return [super borderRectForBounds:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if(self.textRectForBounds){
        return self.textRectForBounds([super textRectForBounds:bounds],bounds);
    }
    return [super textRectForBounds:bounds];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if(self.placeholderRectForBounds){
        return self.placeholderRectForBounds([super placeholderRectForBounds:bounds],bounds);
    }
    return [super placeholderRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if(self.editingRectForBounds){
        return self.editingRectForBounds([super editingRectForBounds:bounds],bounds);
    }
    return [super editingRectForBounds:bounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    if(self.clearButtonRectForBounds){
        return self.clearButtonRectForBounds([super clearButtonRectForBounds:bounds],bounds);
    }
    return [super clearButtonRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    if(self.leftViewRectForBounds){
        return self.leftViewRectForBounds([super leftViewRectForBounds:bounds],bounds);
    }
    return [super leftViewRectForBounds:bounds];
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    if(self.rightViewRectForBounds){
        return self.rightViewRectForBounds([super rightViewRectForBounds:bounds],bounds);
    }
    return [super rightViewRectForBounds:bounds];
}

- (void)drawTextInRect:(CGRect)rect {
    if(self.drawTextInRect){
        self.drawTextInRect(rect);
        return;
    }
    [super drawTextInRect:rect];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    if(self.drawPlaceholderInRect){
        self.drawPlaceholderInRect(rect);
        return;
    }
    [super drawPlaceholderInRect:rect];
}




@end
