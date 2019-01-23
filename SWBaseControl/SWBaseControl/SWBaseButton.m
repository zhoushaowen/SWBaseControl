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

- (void)setHexColorStringForNormalBackgroundImage:(NSString *)hexColorStringForNormalBackgroundImage {
    _hexColorStringForNormalBackgroundImage = [hexColorStringForNormalBackgroundImage copy];
    if(_hexColorStringForNormalBackgroundImage.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:_hexColorStringForNormalBackgroundImage]] forState:UIControlStateNormal];
}

- (void)setHexColorStringForDisabledBackgroundImage:(NSString *)hexColorStringForDisabledBackgroundImage  {
    _hexColorStringForDisabledBackgroundImage = hexColorStringForDisabledBackgroundImage;
    if(_hexColorStringForDisabledBackgroundImage.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateDisabled];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:_hexColorStringForDisabledBackgroundImage]] forState:UIControlStateDisabled];
}

- (void)setHexColorStringForSelectedBackgroundImage:(NSString *)hexColorStringForSelectedBackgroundImage {
    _hexColorStringForSelectedBackgroundImage = hexColorStringForSelectedBackgroundImage;
    if(_hexColorStringForSelectedBackgroundImage.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateSelected];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:_hexColorStringForSelectedBackgroundImage]] forState:UIControlStateSelected];
}

- (void)setHexColorStringForHighlightedBackgroundImage:(NSString *)hexColorStringForHighlightedBackgroundImage {
    _hexColorStringForHighlightedBackgroundImage = hexColorStringForHighlightedBackgroundImage;
    if(_hexColorStringForHighlightedBackgroundImage.length < 1){
        [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    }
    [self setBackgroundImage:[UIImage sw_createImageWithColor:[UIColor colorWithHexString:_hexColorStringForHighlightedBackgroundImage]] forState:UIControlStateHighlighted];
}

@end
