//
//  PageControllerStyle.h
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PageControllerStyle : NSObject
@property (assign,nonatomic)CGFloat bottomLineHeight;
@property (assign,nonatomic)CGFloat bottomLineWidth;
@property (strong,nonatomic)UIFont *titleLabelFont;
@property (strong,nonatomic)UIColor *splitLineColor;
@property (strong,nonatomic)UIColor *titleLabelColor;
@property (strong,nonatomic)UIColor *bottomLineColor;
@property (strong,nonatomic)UIColor *selectedTitleLabelColor;
@property (assign,nonatomic)BOOL isSacle;
@property (assign,nonatomic)BOOL isShowBgColor;
@property (assign,nonatomic)BOOL isCanScroll;
@end


// @property(nonatomic,getter=isExclusiveTouch) BOOL       exclusiveTouch
