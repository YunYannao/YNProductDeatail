//
//  SecondPageTopBar.h
//  GongDoo_iphone
//
//  Created by 员延孬 on 16/6/1.
//  Copyright © 2016年 路之遥网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopBarButton.h"
@class SecondPageTopBar;
@protocol SecondPageTopBarDelegate <NSObject>

@required
-(void)tabBar:(SecondPageTopBar *)tabBar didSelectIndex:(NSInteger)index;

@end
@interface SecondPageTopBar : UIView
@property(nonatomic,weak) id<SecondPageTopBarDelegate> delegate;
/**
 静态方法初始化
 */
+(instancetype)tabbar;
/**
 使用数组初始化
 */
-(instancetype)initWithArray:(NSArray*)array;
-(void)AddTarBarBtn:(NSString *)name;//添加顶部标题项的名字
-(void)TabBtnClick:(TopBarButton *)sender;//监听tabbar的点击

@end
