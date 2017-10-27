//
//  PageView.h
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControllerStyle.h"

@interface PageView : UIView

@property (strong,nonatomic)NSArray *titles;
@property (strong,nonatomic)PageControllerStyle *style;
@property (strong,nonatomic)NSArray *childVCs;
@property (strong,nonatomic)UIViewController *parentVC;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles childVCs:(NSArray*)childVCs parentVC:(UIViewController*)parentVC  style:(PageControllerStyle*)style;

@end
