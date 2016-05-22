//
//  UIView+Frame.h
//  JXLotteryTicket
//
//  Created by yuezuo on 16/5/11.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// @property如果在分类里面只会生成get,set方法的声明，并不会生成成员属性。
/** 高度 */
@property (nonatomic,assign) CGFloat height;

/** 宽度 */
@property (nonatomic,assign) CGFloat width;

/** x坐标 */
@property (nonatomic,assign) CGFloat x;

/** y坐标 */
@property (nonatomic,assign) CGFloat y;

/** 中心X */
@property (nonatomic,assign) CGFloat centerX;

/** 中心Y */
@property (nonatomic,assign) CGFloat centerY;
@end
