//
//  ViewController.m
//  JJPageController
//
//  Created by Adobe on 2017/10/20.
//  Copyright © 2017年 龚. All rights reserved.
//

#import "ViewController.h"
#import "KTViewController.h"
#import "JJViewController.h"
#import "PageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
//    PageControllerStyle *style = [[PageControllerStyle alloc]init];
//    style.titleLabelFont = [UIFont systemFontOfSize:20];
//    PageView *pageView = [[PageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height- 20) titles:@[@"你好",@"明天",@"世界",@"浮云"] childVCs:@[
//    [UIViewController new],[UIViewController new],[UIViewController new],[UIViewController new]
//                                                                                                                                            ] parentVC:self style:style];
//    [self.view addSubview:pageView];

}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [UIView animateWithDuration:0.f animations:^{
        [self.navigationController pushViewController:[[JJViewController alloc]init] animated:NO];
    } completion:^(BOOL finished) {
         [self.navigationController pushViewController:[[KTViewController alloc]init] animated:NO];
    }];
    
   
    
    
}

@end
