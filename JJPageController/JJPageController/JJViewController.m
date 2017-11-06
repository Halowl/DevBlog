//
//  JJViewController.m
//  JJPageController
//
//  Created by Adobe on 2017/10/30.
//  Copyright © 2017年 龚. All rights reserved.
//

#import "JJViewController.h"
#import "KTViewController.h"
@interface JJViewController ()

@end

@implementation JJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.navigationController pushViewController:[[KTViewController alloc]init] animated:YES];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
