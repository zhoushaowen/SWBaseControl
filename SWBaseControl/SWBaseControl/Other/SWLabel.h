//
//  SWLabel.h
//  BSHealthCloud
//
//  Created by zhoushaowen on 2019/1/17.
//  Copyright © 2019 B-Soft Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface SWLabel : UILabel

@property (nonatomic) IBInspectable CGFloat topInset;
@property (nonatomic) IBInspectable CGFloat leftInset;
@property (nonatomic) IBInspectable CGFloat bottomInset;
@property (nonatomic) IBInspectable CGFloat rightInset;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic) IBInspectable BOOL enableContentSizeWhenTextEmpty;
@property (nonatomic) IBInspectable BOOL enableContentSizeWhenHidden;

@end

