//
//  PageView.m
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import "PageView.h"
#import "TitleView.h"
#import "ContentView.h"
@interface PageView ()<TitleViewDelegate,ContentViewDelegate>
@property (strong,nonatomic)TitleView *titleView;
@property (strong,nonatomic)ContentView *contentView;
@end

@implementation PageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC style:(PageControllerStyle *)style{
    if (self = [super initWithFrame:frame]) {
        if (titles.count != childVCs.count) {
            NSLog(@"标题&控制器数量不一致");
        }
        self.style = style;
        self.titles = titles;
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        parentVC.automaticallyAdjustsScrollViewInsets = NO;
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    CGFloat titleH = 44;
    CGRect titleViewFrame = CGRectMake(0, 0, self.frame.size.width, titleH);
    self.titleView = [[TitleView alloc]initWithFrame:titleViewFrame titles:self.titles style:self.style];
    
    [self addSubview:self.titleView];
    
    CGRect contentViewFrame = CGRectMake(0, titleH, self.frame.size.width, self.frame.size.height - titleH);
    self.contentView = [[ContentView alloc]initWithFrame:contentViewFrame childVCs:self.childVCs parentVC:self.parentVC];
    self.contentView.delegate = self;
    self.titleView.delegate = self;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.contentView];
    
}

#pragma mark - TitleViewDelegate
- (void)titleView:(TitleView *)titleView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    //切换子控制器,更改子控制器的view
    [self.contentView setCurrentIndex:toIndex];
    
}

#pragma mark - ContentViewDelegate
- (void)contentViewEndScroll:(ContentView *)contentView{
    [self.titleView contentViewDidEndScroll];
}

- (void)contentView:(ContentView *)contentView setTitleWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    [self.titleView setTitleWithProgress:progress fromIndex:fromIndex toIndex:toIndex];
}

@end
