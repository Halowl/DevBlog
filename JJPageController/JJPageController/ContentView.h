//
//  ContentView.h
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentView;
@protocol ContentViewDelegate <NSObject>
- (void)contentView:(ContentView*)contentView setTitleWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
- (void)contentViewEndScroll:(ContentView *)contentView;
@end

@class ContentViewDelegate;
@interface ContentView : UIView
@property (strong,nonatomic)NSArray *childVCs;
@property (strong,nonatomic)UIViewController *parentVC;
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC;
- (void)setCurrentIndex:(NSInteger)currentIndex;

@property (weak,nonatomic)id <ContentViewDelegate> delegate;
@end
