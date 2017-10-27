//
//  TitleView.m
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import "TitleView.h"
#import "UIView+Extension.h"
#import "ContentView.h"
@interface TitleView ()
@property (strong,nonatomic)NSArray *titles;
@property (strong,nonatomic)PageControllerStyle *style;
@property (assign,nonatomic)NSInteger currentIndex;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIView *splitLineView;
@property (strong,nonatomic)UIView *bottomline;
@property (strong,nonatomic)NSMutableArray *titleLabels;
@end

@implementation TitleView


- (NSMutableArray *)titleLabels
{
    if (!_titleLabels) {
        _titleLabels = @[].mutableCopy;
    }
    return _titleLabels;
    
}
- (UIView *)splitLineView
{
    if (!_splitLineView) {
        _splitLineView = [[UIView alloc]init];
        CGFloat h = 0.5;
        _splitLineView.frame = CGRectMake(0, self.frame.size.height - h, self.frame.size.width, h);
        _splitLineView.backgroundColor = self.style.splitLineColor;
    }
    return _splitLineView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
    
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(PageControllerStyle*)style{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.style = style;
        self.currentIndex = 0;
        [self setupUI];
    }
    return self;
}

// 布局
- (void)setupUI{
 
    // 添加scrollView
    [self addSubview:self.scrollView];
    
    // 添加分割线
    [self addSubview:self.splitLineView];
    
    // 添加底部线条
    [self addBottomline];
    
    // 设置的所有标题Label位置/手势等
    [self addTitleLabels];
    
    // 设置遮盖
    
    // 添加动画
    
}

- (void)addBottomline{
    self.bottomline = [[UIView alloc]init];
    CGFloat h = self.style.bottomLineHeight;
    CGFloat w = self.style.bottomLineWidth;
    _bottomline.frame = CGRectMake(0, self.frame.size.height - h, w, h);
    _bottomline.backgroundColor = self.style.bottomLineColor;
    [self addSubview:self.bottomline];
}


- (void)addTitleLabels{
   
    CGFloat lastW = 0;
    CGFloat margin = 10;
    for (int i = 0; i < self.titles.count; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = self.titles[i];
        label.font = self.style.titleLabelFont;
        label.textColor = self.style.titleLabelColor;
        label.textAlignment = NSTextAlignmentCenter;
        if (self.style.isCanScroll) {
            CGFloat w = [label.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * margin, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{                                                                                                                           NSFontAttributeName:self.style.titleLabelFont} context:nil].size.width;
            label.frame = CGRectMake(margin + lastW, 0, w, self.frame.size.height);
            lastW = CGRectGetMaxX(label.frame);
        }else{
            CGFloat w = [UIScreen mainScreen].bounds.size.width / self.titles.count;
            label.frame = CGRectMake(i * w, 0, w, self.frame.size.height);
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        [self addSubview:label];
        [self.titleLabels addObject:label];
        if (i == 0) {
            label.textColor = self.style.selectedTitleLabelColor;
            _bottomline.centerX = label.centerX;
        }

    }
}

- (void)titleLabelClick:(UITapGestureRecognizer*)titleLabelClick{
    
    if ([self.delegate respondsToSelector:@selector(titleView:fromIndex:toIndex:)]) {
        UILabel *currentLabel = self.titleLabels[self.currentIndex];
        currentLabel.textColor = self.style.titleLabelColor;
        for (NSInteger i = 0; i < self.titles.count; i++) {
            UILabel *label = (UILabel*)titleLabelClick.view;
            if ([label.text isEqualToString:self.titles[i]]) {
                [self.delegate titleView:self fromIndex:self.currentIndex toIndex:i];
                
                CGFloat h = self.style.bottomLineHeight;
                CGFloat w = self.style.bottomLineWidth;
                _bottomline.frame = CGRectMake(0, self.frame.size.height - h, w, h);
                _bottomline.centerX = label.centerX;
                self.currentIndex = i;
                label.textColor = self.style.selectedTitleLabelColor;
            }
        }
    }
    
}

- (void)setTitleWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    
    UILabel *currentLabel = self.titleLabels[self.currentIndex];
    UILabel *toLabel = self.titleLabels[toIndex];
    currentLabel.textColor = self.style.titleLabelColor;
    toLabel.textColor = self.style.selectedTitleLabelColor;
    self.bottomline.centerX = toLabel.centerX;
    self.currentIndex = toIndex;
    
}

- (void)contentViewDidEndScroll{
    if (!self.style.isCanScroll) {
        return;
    }
    UILabel *currentLabel = self.titleLabels[self.currentIndex];
    // 2.计算和中间位置的偏移量
    CGFloat offsetX = currentLabel.centerX - self.bounds.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }

    CGFloat maxOffset = self.scrollView.contentSize.width - self.bounds.size.width;
    if (offsetX >  maxOffset) {
        offsetX = maxOffset;
    }
    // 3.滚动UIScrollView
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0)];
}

@end
