//
//  ProductDetailViewController.m
//  YNProductDetail
//
//  Created by 员延孬 on 16/6/2.
//  Copyright © 2016年 路之遥网络科技有限公司. All rights reserved.
//

#define contenSize 800.0  //两个scrollView的contentSize大小
#define dragStrength 60.0 //拖拽强度

#import "ProductDetailViewController.h"
#import "LoadMoreView.h"

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@property(nonatomic,strong)UIScrollView * mainScrollView;
@property(nonatomic,strong)UIScrollView * secScrollView;
@property(nonatomic,strong)SecondPageTopBar * topBar;
@property(nonatomic,strong)BuyBotomView*botomView;
@property(nonatomic,strong)UIView * NavBarView;
@property(nonatomic,strong)SDCycleScrollView * banerView;
@property(nonatomic,strong)UILabel * secPageHeaderLabel;
@property(nonatomic,strong)UIButton * backToTopBtn;

@property(nonatomic,strong)UILabel * banerIndictor;

@end

@implementation ProductDetailViewController
{
    int banerCurImg;
    NSArray * imagesUrlArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any aScreen_Heightdditional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    
    banerCurImg=1;
    NSString * str=@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg";
    imagesUrlArr=@[str,str,str];
    
    [self setFirstPageView];
    
    [self addNavBarView];
    
    [self addBotomView];

 
}

-(UIScrollView*)mainScrollView{
    if (_mainScrollView == nil){
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.delegate = self;
        _mainScrollView.frame = CGRectMake(0.0, 0.0, Screen_Width, Screen_Height-BottomH);
        _mainScrollView.pagingEnabled = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.tag =100;
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}
-(UIScrollView*)secScrollView{
    if (_secScrollView==nil) {
        _secScrollView=[[UIScrollView alloc]init];
        _secScrollView.frame=CGRectMake(0, Screen_Height-BottomH, Screen_Width, Screen_Height-NaviBarH-BottomH-TopTabBarH);
        _secScrollView.delegate=self;
        _secScrollView.pagingEnabled=YES;
        _secScrollView.showsVerticalScrollIndicator=NO;
        _secScrollView.tag=200;
        self.secScrollView.contentSize=CGSizeMake(0, contenSize);
        [self.view addSubview:_secScrollView];
    }
    return _secScrollView;
}
-(UILabel*)secPageHeaderLabel{
    if (_secPageHeaderLabel==nil) {
        _secPageHeaderLabel=[[UILabel alloc]init];
        _secPageHeaderLabel.frame=CGRectMake(0, NaviBarH+TopTabBarH+8, Screen_Width, 21);
        _secPageHeaderLabel.textColor=[UIColor blackColor];
        _secPageHeaderLabel.font=[UIFont systemFontOfSize:12];
        _secPageHeaderLabel.alpha=0;
        _secPageHeaderLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _secPageHeaderLabel;
}
-(UIButton*)backToTopBtn{
    if (_backToTopBtn==nil) {
        _backToTopBtn=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-15-40, Screen_Height-BottomH-20-40, 40, 40)];
        [_backToTopBtn setImage:[UIImage imageNamed:@"srp_scroll_2_top_btn@2x"] forState:UIControlStateNormal];
        [_backToTopBtn addTarget:self action:@selector(backToTopView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backToTopBtn;
}
-(void)setFirstPageView{
    
    self.mainScrollView.contentSize=CGSizeMake(0, contenSize);
    
    //banner图
    self.banerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width) delegate:self placeholderImage:loadFailImg];
    self.banerView.imageURLStringsGroup=imagesUrlArr;
    self.banerView.tag=66;
    self.banerView.autoScroll=NO;
    self.banerView.delegate=self;
    [self.mainScrollView addSubview:self.banerView];
    
    //banner图的指示标签
    if (imagesUrlArr.count>1) {
        _banerIndictor=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width-40, Screen_Width-40, 30, 30)];
        _banerIndictor.layer.cornerRadius=15;
        _banerIndictor.clipsToBounds=YES;
        _banerIndictor.backgroundColor=[UIColor grayColor];
        _banerIndictor.font=[UIFont systemFontOfSize:12];
        _banerIndictor.textColor=[UIColor whiteColor];
        _banerIndictor.text=[NSString stringWithFormat:@"%d/%lu",banerCurImg,(unsigned long)imagesUrlArr.count];
        _banerIndictor.textAlignment=NSTextAlignmentCenter;
        [self.mainScrollView addSubview:_banerIndictor];
    }
    
    //加载更多
    UIView * loadMoreView=[LoadMoreView view];
    loadMoreView.frame=CGRectMake(0, contenSize-BottomH, Screen_Width, BottomH);
    [self.mainScrollView addSubview:loadMoreView];
}
-(void)setSecondPageView{
    UILabel * lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 21)];
    lab.backgroundColor=[UIColor lightGrayColor];
    lab.text=@"我在第二屏的顶头位置";
    lab.textAlignment=NSTextAlignmentCenter;
    [self.secScrollView addSubview:lab];
}
/**
 添加导航栏背后的View
 */
-(void)addNavBarView{
    UIView* view = [[UIView alloc] init];
    self.NavBarView = view;
    view.frame = CGRectMake(0, 0, Screen_Width, NaviBarH);
    [self.view addSubview:view];
    
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, NaviBarH-0.5, Screen_Width, 0.5)];
    lineView.backgroundColor=[UIColor blackColor];
    [self.NavBarView addSubview:lineView];
    
    UIButton * backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 32, 25, 25)];
    [backBtn setImage:[UIImage imageNamed:@"lf_arrow_left@2x"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(navBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.layer.cornerRadius=25/2;
    backBtn.backgroundColor=[UIColor lightGrayColor];
    [self.NavBarView addSubview:backBtn];
    backBtn.tag=1;
    
    UIButton * shareBton=[[UIButton alloc]initWithFrame:CGRectMake(Screen_Width-10-25, 32, 25, 25)];
    [shareBton setImage:[UIImage imageNamed:@"lf_tabbar_cart_selected@2x"] forState:UIControlStateNormal];
    [self.NavBarView addSubview:shareBton];
    [shareBton addTarget:self action:@selector(navBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    shareBton.tag=2;
}
/**
 *  添加底部的购买 加入购物车 收藏等模块
 */
-(void)addBotomView{
    _botomView=[BuyBotomView botomViewWithFrame:CGRectMake(0, Screen_Height-BottomH, Screen_Width, BottomH) withDelegate:self];
    [self.view addSubview:_botomView];
    [self.view bringSubviewToFront:_botomView];
}
/**
 *  第二屏顶部的三个模块
 *
 *  @return 懒加载
 */
-(SecondPageTopBar*)topBar{
    if (_topBar==nil) {
        _topBar=[[SecondPageTopBar alloc]initWithArray:@[@"图文详情",@"包装参数",@"商品评价"]];
        _topBar.frame=CGRectMake(0, NaviBarH, Screen_Width, TopTabBarH);
        _topBar.delegate=self;
        [self.view addSubview:_topBar];
    }
    return _topBar;
}

#pragma mark--UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.tag == 100){
        if(scrollView.contentOffset.y<0){
            scrollView.contentOffset = CGPointMake(0, 0);//限制不能下拉
        }
        if(scrollView.contentOffset.y>=0){
            //上拖的时候改变导航栏背部的颜色
            CGFloat  fir_maxContentOffSet_Y=self.mainScrollView.contentSize.height-self.mainScrollView.frame.size.height;
            CGFloat  scal=scrollView.contentOffset.y/fir_maxContentOffSet_Y;
            self.NavBarView.backgroundColor=[UIColor whiteColor];
            self.NavBarView.alpha=scal;
        }
    }
    if (scrollView.tag==200) {
        //在0-60之间 懒加载子控件，并且随拖动的幅度改变子控件的标题和alpha
        CGFloat  mininumContenOffSet_Y=0;
        CGFloat  maxContentOffSet_Y=-dragStrength;
        if (scrollView.contentOffset.y>maxContentOffSet_Y&&scrollView.contentOffset.y<mininumContenOffSet_Y) {
            self.secPageHeaderLabel.text=@"下拉，回到宝贝详情";
            [self.view addSubview:self.secPageHeaderLabel];
            self.secPageHeaderLabel.alpha=scrollView.contentOffset.y/maxContentOffSet_Y;
            
        }
        if(scrollView.contentOffset.y<maxContentOffSet_Y){
            self.secPageHeaderLabel.text=@"释放，回到宝贝详情";
        }
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag==100) {
        CGFloat mininumContentset_Y=self.mainScrollView.contentSize.height-Screen_Height+BottomH +dragStrength;
        if(scrollView.contentOffset.y>mininumContentset_Y){
            //此时第一屏滑到底部 可调滑动手势强度
            [self setSecondPageView];
            self.topBar.hidden=NO;
            [self.view bringSubviewToFront:self.botomView];
            self.backToTopBtn.hidden=NO;
            [self.view addSubview:self.backToTopBtn];
            //然后懒加载第二屏
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.topBar.frame=CGRectMake(0, NaviBarH, Screen_Width, TopTabBarH);
                self.secScrollView.frame=CGRectMake(0, NaviBarH+TopTabBarH, Screen_Width, Screen_Height-NaviBarH-BottomH-TopTabBarH);
                self.mainScrollView.frame=CGRectMake(0, NaviBarH-contenSize, Screen_Width, Screen_Height-BottomH);
            } completion:^(BOOL finished) {
            }];
        }
    }
    if (scrollView.tag==200) {
        CGFloat  maxContentOffSet_Y=-dragStrength;
        if (scrollView.contentOffset.y<maxContentOffSet_Y) {
            
            self.backToTopBtn.hidden=YES;
            [self.view bringSubviewToFront:self.botomView];
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                self.topBar.frame=CGRectMake(0, Screen_Height, Screen_Width, TopTabBarH);
                self.secScrollView.frame=CGRectMake(0, Screen_Height+TopTabBarH, Screen_Width, Screen_Height-NaviBarH-BottomH-TopTabBarH);
                self.mainScrollView.frame=CGRectMake(0, 0, Screen_Width, Screen_Height-BottomH);
            } completion:^(BOOL finished) {
                self.topBar.hidden=YES;
            }];
        }
    }
}
#pragma mark---banner图的滚动回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.banerIndictor.text=[NSString stringWithFormat:@"%ld/%lu",index+1,imagesUrlArr.count];
}
#pragma mark---底部按钮
-(void)clickedBotomViewBtnWithBtnTag:(NSInteger)btnTag{
    DebugLog(@"底部的第%ld个",btnTag);
}
#pragma mark---第二页顶部按钮
-(void)tabBar:(SecondPageTopBar *)tabBar didSelectIndex:(NSInteger)index;{
    DebugLog(@"顶部的第%ld个",index);
}
#pragma mark---导航栏按钮的事件
-(void)navBarBtnAction:(UIButton*)sender{
    if (sender.tag==1) {
        [self.navigationController popViewControllerAnimated:NO];
    }
    if (sender.tag==2) {
        DebugLog(@"分享");
    }
}
#pragma mark---滚动到顶部
-(void)backToTopView{
    self.backToTopBtn.hidden=YES;
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.topBar.frame=CGRectMake(0, Screen_Height, Screen_Width, TopTabBarH);
        self.secScrollView.frame=CGRectMake(0, Screen_Height+TopTabBarH, Screen_Width, Screen_Height-NaviBarH-BottomH-TopTabBarH);
        self.mainScrollView.contentOffset=CGPointMake(0, 0);
        self.mainScrollView.frame=CGRectMake(0, 0, Screen_Width, Screen_Height-BottomH);
    } completion:^(BOOL finished) {
        self.topBar.hidden=YES;
    }];
}

@end
