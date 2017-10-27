//
//  PageControllerStyle.m
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import "PageControllerStyle.h"
#import <UIKit/UIKit.h>
@implementation PageControllerStyle

- (instancetype)init{
    if (self = [super init]) {
        _bottomLineWidth = 40;
        _bottomLineHeight = 2;
        _bottomLineColor = [UIColor redColor];
        _titleLabelFont = [UIFont systemFontOfSize:13];
        _titleLabelColor = [UIColor whiteColor];
        _isSacle = NO;
        _isCanScroll = NO;
        _isShowBgColor = NO;
        _splitLineColor = [UIColor grayColor];
        _selectedTitleLabelColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setIsSacle:(BOOL)isSacle{
    _isSacle = isSacle;
}

- (void)setIsShowBgColor:(BOOL)isShowBgColor{
    _isShowBgColor = isShowBgColor;
}

- (void)setIsCanScroll:(BOOL)isCanScroll{
    _isCanScroll = isCanScroll;
}

- (void)setBottomLineHeight:(CGFloat)bottomLineHeight{
    _bottomLineHeight = bottomLineHeight;
}
- (void)setBottomLineWidth:(CGFloat)bottomLineWidth{
    _bottomLineWidth = bottomLineWidth;
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont{
    _titleLabelFont = titleLabelFont;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor{
    _bottomLineColor = bottomLineColor;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor{
    _titleLabelColor = titleLabelColor;
}

- (void)setSplitLineColor:(UIColor *)splitLineColor{
    _splitLineColor = splitLineColor;
}

- (void)setSelectedTitleLabelColor:(UIColor *)selectedTitleLabelColor{
    _selectedTitleLabelColor = selectedTitleLabelColor;
}
@end
