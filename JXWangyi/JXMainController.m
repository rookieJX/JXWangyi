//
//  JXMainController.m
//  JXWangyi
//
//  Created by 王加祥 on 16/5/21.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXMainController.h"
#import "UIView+Frame.h"
@interface JXMainController ()
/** 标题栏 */
@property (nonatomic,weak) UIScrollView * titleScrollView;
/** 内容栏 */
@property (nonatomic,weak) UIScrollView * contentVc;
@end

@implementation JXMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupTitleVc];
    [self setupContentVc];
}

#pragma mark - 创建页面
- (void)setupTitleVc {
    // 一共7个控件
    NSInteger count = 7;
    // 控件宽高
    CGFloat width = 80.0;
    CGFloat height = 30.0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i<count; i++) {
        UILabel * label = [[UILabel alloc] init];
        x = i * width;
        label.frame = CGRectMake(x, y, width, height);
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        label.text = [NSString stringWithFormat:@"标题%ld",i];
        // label添加tag值
        label.tag = i;
        // label添加点按手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:tap];
        label.backgroundColor = [self randColor];
        [self.titleScrollView addSubview:label];
    }
    self.titleScrollView.contentSize = CGSizeMake(count * width, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容视图的大小
    self.contentVc.contentSize = CGSizeMake(count * self.view.width, 0);
    
}

- (void)setupContentVc {
    UISwitch * sw = [[UISwitch alloc] init];
    sw.center = self.view.center;
    [self.contentVc addSubview:sw];
    
    
    UISwitch * sw2 = [[UISwitch alloc] init];
    sw2.centerX = 90;
    sw2.centerY = 300;
    [self.contentVc addSubview:sw2];
    
    UISwitch * sw3 = [[UISwitch alloc] init];
    sw3.centerX = 500;
    sw3.centerY = 300;
    [self.contentVc addSubview:sw3];
}
/**
 *  点击事件
 */
- (void)tap:(UITapGestureRecognizer *)gesture {
    NSLog(@"%s",__func__);
    // 取出点击tag值
    NSInteger index = gesture.view.tag;
    // 根据tag值偏移内容视图
    CGPoint offset = self.contentVc.contentOffset;
    offset.x = index * self.view.width;
    [self.contentVc setContentOffset:offset animated:YES];
    
}

#pragma mark - 懒加载
- (UIScrollView *)titleScrollView {
    if (_titleScrollView == nil) {
        UIScrollView * titleScrollView = [[UIScrollView alloc] init];
        titleScrollView.frame = CGRectMake(0, 64, self.view.width, 30);
        titleScrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:titleScrollView];
        _titleScrollView = titleScrollView;
    }
    return _titleScrollView;
}

- (UIScrollView *)contentVc {
    if (_contentVc == nil) {
        UIScrollView * contentScrollView = [[UIScrollView alloc] init];
        contentScrollView.frame = CGRectMake(0, 94, self.view.width, self.view.height - 94);
        [self.view addSubview:contentScrollView];
        contentScrollView.backgroundColor = [UIColor orangeColor];
        _contentVc = contentScrollView;
    }
    return _contentVc;
}

#pragma mark - 颜色
- (UIColor *)randColor {
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
@end
