//
//  BuyBotomView.m
//  GongDoo_iphone
//
//  Created by 员延孬 on 16/6/1.
//  Copyright © 2016年 路之遥网络科技有限公司. All rights reserved.
//

#import "BuyBotomView.h"

@implementation BuyBotomView

+(id)botomViewWithFrame:(CGRect)frame withDelegate:(id<BotomViewDelegate>)delegate{
    BuyBotomView * botomView=[[BuyBotomView alloc]initWithFrame:frame];
    botomView.botomViewDelegate=delegate;
    
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-BottomH+0.5, Screen_Width,0.5)];
    lineView.backgroundColor=[UIColor lightGrayColor];
    [botomView addSubview:lineView];

    NSArray * btnCollerArr=@[[UIColor orangeColor],[UIColor redColor]];
    NSArray * btnImgArr=@[@"tmall_search_collection_normal_new@2x",@"tbmirror_share@2x",@"lf_tabbar_cart@2x"];
    NSArray * btnTitleArr=@[@"加入购物车",@"立即购买"];
    NSArray * labelTieleArr=@[@"关注",@"分享",@"购物车"];
    for (int i=0; i<5; i++) {
        if (i<=2) {
        UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(i*BottomH+12, 5, 20, 20)];
        [botomView addSubview:btn];
        btn.tag=i;
            [btn setImage:[UIImage imageNamed:btnImgArr[i]] forState:UIControlStateNormal];
        [btn addTarget:botomView action:@selector(clikedBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel * titleLab=[[UILabel alloc]initWithFrame:CGRectMake(i*BottomH, CGRectGetMaxY(btn.frame)+3, BottomH, BottomH-5-20-3)];
            titleLab.textAlignment=NSTextAlignmentCenter;
            titleLab.font=[UIFont systemFontOfSize:10];
            [botomView addSubview:titleLab];
            titleLab.text=labelTieleArr[i];
        }
        else{
            CGFloat btnWidth=(Screen_Width-BottomH*3)/2;
            UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(BottomH*3+btnWidth*(i-3), 0, btnWidth, botomView.frame.size.height)];
            [botomView addSubview:btn];
            btn.tag=i;
            [btn setBackgroundColor:btnCollerArr[i-3]];
            [btn setTitle:btnTitleArr[i-3] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:16];
            [btn addTarget:botomView action:@selector(clikedBtn:) forControlEvents:UIControlEventTouchUpInside];

        }
    }
    return botomView;
}
-(void)clikedBtn:(UIButton*)btn{
    if ([self.botomViewDelegate respondsToSelector:@selector(clickedBotomViewBtnWithBtnTag:)]) {
        [self.botomViewDelegate clickedBotomViewBtnWithBtnTag:btn.tag];
    }
}
@end
