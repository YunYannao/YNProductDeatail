//
//  ViewController.m
//  YNProductDetail
//
//  Created by 员延孬 on 16/6/2.
//  Copyright © 2016年 路之遥网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ProductDetailViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton * btn=[[UIButton alloc]init];
    btn.frame=CGRectMake((Screen_Width-100)/2, 150, 100, 30);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitle:@"点我去详情" forState:0];
}
-(void)go:(UIButton*)sender{
    [self.navigationController pushViewController:[ProductDetailViewController new] animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
