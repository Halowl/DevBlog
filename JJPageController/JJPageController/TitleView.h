//
//  TitleView.h
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControllerStyle.h"
@class TitleView;
@protocol TitleViewDelegate <NSObject>

- (void)titleView:(TitleView*)titleView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end

@class TitleViewDelegate;
@interface TitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(PageControllerStyle*)style;
- (void)contentViewDidEndScroll;
- (void)setTitleWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@property (weak,nonatomic)id<TitleViewDelegate> delegate;
@end
