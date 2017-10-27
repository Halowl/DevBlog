//
//  ContentView.m
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import "ContentView.h"
#import "TitleView.h"

#define     kRandomColor            [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]
@interface ContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic)UICollectionView *collectionView;
@property (assign,nonatomic)CGFloat offsetX;
@property (assign,nonatomic)BOOL isClick;
@end

static NSString *const KCELLID = @"KCELLID";
@implementation ContentView


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //修改item大小 (可通过次属性来估算有多少列)
        layout.itemSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
        //上下左右偏移
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //左右两个item的最小间距
        layout.minimumInteritemSpacing = 0;
        //上下两个item的最小间距
        layout.minimumLineSpacing = 0;
        //滚动的方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KCELLID];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
    
}

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC{
    if (self = [super initWithFrame:frame]) {
        self.childVCs = childVCs;
        self.parentVC = parentVC;
        self.isClick = NO;
        [self setupUI];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)setupUI{
    
    for (UIViewController *vc in self.childVCs) {
        [self.parentVC addChildViewController:vc];
    }
    [self addSubview:self.collectionView];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCELLID forIndexPath:indexPath];
    
    // 添加动画
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIViewController *childVC = self.childVCs[indexPath.item];
    childVC.view.frame = cell.contentView.bounds;
    childVC.view.backgroundColor = kRandomColor;
    [cell.contentView addSubview:childVC.view];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",collectionView.subviews);
}


#pragma mark - UICollectionViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isClick = NO;
    self.offsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isClick) {return;}
    
    CGFloat progress = 0;
    NSInteger fromIndex = 0;
    NSInteger toIndex = 0;
    
    // 判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    if (currentOffsetX > self.offsetX) { //左滑
        fromIndex = (NSInteger)currentOffsetX / scrollView.bounds.size.width;
        toIndex = fromIndex + 1;
        
        progress = currentOffsetX / scrollView.bounds.size.width - floor(currentOffsetX / scrollView.bounds.size.width);
        
        if (toIndex >= self.childVCs.count) {
            toIndex = self.childVCs.count - 1;
        }
        
        // 4.如果完全划过去
        if (currentOffsetX - self.offsetX == scrollView.bounds.size.width) {
            progress = 1;
            toIndex = fromIndex;
        }
    }else{ //右滑
        
        progress = 1 - (currentOffsetX / scrollView.bounds.size.width - floor(currentOffsetX / scrollView.bounds.size.width));
        
        toIndex = (NSInteger)currentOffsetX / scrollView.bounds.size.width;
        fromIndex = toIndex + 1;
        if (fromIndex >= self.childVCs.count) {
            fromIndex = self.childVCs.count - 1;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(contentView:setTitleWithProgress:fromIndex:toIndex:)]) {
        [self.delegate contentView:self setTitleWithProgress:progress fromIndex:fromIndex toIndex:toIndex];
    }
   
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(contentViewEndScroll:)]) {
        [self.delegate contentViewEndScroll:self];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(contentViewEndScroll:)]) {
        [self.delegate contentViewEndScroll:self];
    }
}

#pragma mark - setCurrentIndex
- (void)setCurrentIndex:(NSInteger)currentIndex{
    self.isClick = YES;
    CGFloat offsetX = currentIndex * self.collectionView.frame.size.width;
    [_collectionView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
}

@end
