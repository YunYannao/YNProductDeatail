//
//  BuyBotomView.h
//  GongDoo_iphone
//
//  Created by 员延孬 on 16/6/1.
//  Copyright © 2016年 路之遥网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BotomViewDelegate <NSObject>

@required
-(void)clickedBotomViewBtnWithBtnTag:(NSInteger)btnTag;

@end
@interface BuyBotomView : UIView

@property(nonatomic,weak)id<BotomViewDelegate>botomViewDelegate;
+(id)botomViewWithFrame:(CGRect)frame withDelegate:(id<BotomViewDelegate>)delegate;

@end
