//
//  SWBaseButton.m
//  Pods-SWBaseControl
//
//  Created by zhoushaowen on 2019/1/23.
//

#import "SWBaseButton.h"
#import <UIImage+SWExtension.h>
#import <UIColor+SWHex.h>

@implementation SWBaseButton

- (CGSize)intrinsicContentSize {
    if(self.isHidden && !self.enableContentSizeWhenHidden) return CGSizeZero;
    if((self.currentTitle.length < 1) && !self.enableContentSizeWhenTextEmpty) return CGSizeZero;
    return [super intrinsicContentSize];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self invalidateIntrinsicContentSize];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self invalidateIntrinsicContentSize];
}

- (void)setEnableContentSizeWhenHidden:(BOOL)enableContentSizeWhenHidden {
    _enableContentSizeWhenHidden = enableContentSizeWhenHidden;
    [self invalidateIntrinsicContentSize];
}

- (void)setEnableContentSizeWhenTextEmpty:(BOOL)enableContentSizeWhenTextEmpty {
    _enableContentSizeWhenTextEmpty = enableContentSizeWhenTextEmpty;
    [self invalidateIntrinsicContentSize];
}

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

- (void)setImageForNormal:(UIImage *)imageForNormal {
    [self setImage:imageForNormal forState:UIControlStateNormal];
}

- (UIImage *)imageForNormal {
    return [self imageForState:UIControlStateNormal];
}

- (void)setImageForHighlighted:(UIImage *)imageForHighlighted {
    [self setImage:imageForHighlighted forState:UIControlStateHighlighted];
}

- (UIImage *)imageForHighlighted {
    return [self imageForState:UIControlStateHighlighted];
}

- (void)setImageForSelected:(UIImage *)imageForSelected {
    [self setImage:imageForSelected forState:UIControlStateSelected];
}

- (UIImage *)imageForSelected {
    return [self imageForState:UIControlStateSelected];
}

- (void)setImageForDisabled:(UIImage *)imageForDisabled {
    [self setImage:imageForDisabled forState:UIControlStateDisabled];
}

- (UIImage *)imageForDisabled {
    return [self imageForState:UIControlStateDisabled];
}

- (void)setBackgroundImageForNormal:(UIImage *)backgroundImageForNormal {
    [self setBackgroundImage:backgroundImageForNormal forState:UIControlStateNormal];
}

- (UIImage *)backgroundImageForNormal {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setBackgroundImageForHighlighted:(UIImage *)backgroundImageForHighlighted {
    [self setBackgroundImage:backgroundImageForHighlighted forState:UIControlStateHighlighted];
}

- (UIImage *)backgroundImageForHighlighted {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

- (void)setBackgroundImageForSelected:(UIImage *)backgroundImageForSelected {
    [self setBackgroundImage:backgroundImageForSelected forState:UIControlStateSelected];
}

- (UIImage *)backgroundImageForSelected {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setBackgroundImageForDisabled:(UIImage *)backgroundImageForDisabled {
    [self setBackgroundImage:backgroundImageForDisabled forState:UIControlStateDisabled];
}

- (UIImage *)backgroundImageForDisabled {
    return [self backgroundImageForState:UIControlStateDisabled];
}

@end
