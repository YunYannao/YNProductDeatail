//
//  LoadMoreView.m
//  GongDoo_iphone
//
//  Created by 员延孬 on 16/6/2.
//  Copyright © 2016年 路之遥网络科技有限公司. All rights reserved.
//

#import "LoadMoreView.h"

@implementation LoadMoreView
+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LoadMoreView" owner:nil options:nil] lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
