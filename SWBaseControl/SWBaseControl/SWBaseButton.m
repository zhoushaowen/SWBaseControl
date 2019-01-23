//
//  SWBaseButton.m
//  Pods-SWBaseControl
//
//  Created by zhoushaowen on 2019/1/23.
//

#import "SWBaseButton.h"
#import <UIImage+SWExtension.h>
#import <UIColor+Hex.h>

@implementation SWBaseButton

- (void)setBackgroundImageHexStringForNormal:(NSString *)backgroundImageHexStringForNormal {
    _backgroundImageHexStringForNormal = [backgroundImageHexStringForNormal copy];
    if(_backgroundImageHexStringForNormal.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:backgroundImageHexStringForNormal]] forState:UIControlStateNormal];
}

- (void)setBackgroundImageHexStringForDisabled:(NSString *)backgroundImageHexStringForDisabled {
    _backgroundImageHexStringForDisabled = backgroundImageHexStringForDisabled;
    if(_backgroundImageHexStringForDisabled.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateDisabled];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:backgroundImageHexStringForDisabled]] forState:UIControlStateDisabled];
}

- (void)setBackgroundImageHexStringForSelected:(NSString *)backgroundImageHexStringForSelected {
    _backgroundImageHexStringForSelected = backgroundImageHexStringForSelected;
    if(_backgroundImageHexStringForSelected.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateSelected];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:backgroundImageHexStringForSelected]] forState:UIControlStateSelected];
}

- (void)setBackgroundImageHexStringForHighlighted:(NSString *)backgroundImageHexStringForHighlighted {
    _backgroundImageHexStringForHighlighted = backgroundImageHexStringForHighlighted;
    if(_backgroundImageHexStringForHighlighted.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:backgroundImageHexStringForHighlighted]] forState:UIControlStateHighlighted];
}

@end
