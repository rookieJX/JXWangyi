//
//  JXMainController.m
//  JXWangyi
//
//  Created by 王加祥 on 16/5/21.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXMainController.h"
#import "JXOneController.h"
#import "JXTwoController.h"
#import "JXThreeController.h"
#import "JXFourController.h"
#import "JXFiveController.h"
#import "JXSixController.h"
#import "JXSevenController.h"
#import "UIView+Frame.h"
#import "JXLabel.h"
@interface JXMainController ()<UIScrollViewDelegate>
/** 标题栏 */
@property (nonatomic,weak) UIScrollView * titleScrollView;
/** 内容栏 */
@property (nonatomic,weak) UIScrollView * contentVc;
@end

@implementation JXMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupAddChilds];
    [self setupTitleVc];
    
    // 直接默认显示第一个
    [self scrollViewDidEndScrollingAnimation:self.contentVc];
    [self scrollViewDidScroll:self.contentVc];
}

#pragma mark - 创建页面
/**
 *  创建导航界面
 */
- (void)setupTitleVc {
    // 一共7个控件
    NSInteger count = 7;
    // 控件宽高
    CGFloat width = 80.0;
    CGFloat height = 30.0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i<count; i++) {
        JXLabel * label = [[JXLabel alloc] init];
        x = i * width;
        label.frame = CGRectMake(x, y, width, height);
        // 取出当前控制器的title，命名导航栏
        label.text = [self.childViewControllers[i] title];
        
        // label添加tag值
        label.tag = i;
        // label添加点按手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:tap];
        label.backgroundColor = [UIColor lightGrayColor];
        [self.titleScrollView addSubview:label];
    }
    self.titleScrollView.contentSize = CGSizeMake(count * width, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    
    // 设置内容视图的大小
    self.contentVc.contentSize = CGSizeMake(count * self.view.width, 0);
    
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

#pragma mark - 添加控制器
- (void)setupAddChilds {
    // 这里只是添加控制器，实际上控制器上的view并没有添加，因为控制器上的view是懒加载添加
    JXOneController * one = [[JXOneController alloc] init];
    one.title = @"政治";
    [self addChildViewController:one];
    
    JXTwoController * two = [[JXTwoController alloc] init];
    two.title = @"军事";
    [self addChildViewController:two];
    
    JXThreeController * three = [[JXThreeController alloc] init];
    three.title = @"教育";
    [self addChildViewController:three];
    
    JXFourController * four = [[JXFourController alloc] init];
    four.title = @"财经";
    [self addChildViewController:four];
    
    JXFiveController * five = [[JXFiveController alloc] init];
    five.title = @"社会";
    [self addChildViewController:five];
    
    JXSixController * six = [[JXSixController alloc] init];
    six.title = @"国际";
    [self addChildViewController:six];
    
    JXSevenController * seven = [[JXSevenController alloc] init];
    seven.title = @"民生";
    [self addChildViewController:seven];
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
        contentScrollView.backgroundColor = [UIColor lightGrayColor];
        contentScrollView.pagingEnabled = YES;
        contentScrollView.delegate = self;
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

#pragma mark - UIScrollViewDelegate
// 这个方法只是在人为拖动界面的时候才会调用，代码添加的不会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

// scrollView 结束滚动的时候就会调用这个方法，比如（[self.contentVc setContentOffset:offset animated:YES]）执行完毕之后就会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 当前需要显示的控制器索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    // 取出当前控制器
    UIViewController * willShowVc = self.childViewControllers[index];
    
    // 上下控制器相关联
    // 取出当前label
    JXLabel * currentLabel = self.titleScrollView.subviews[index];
    // 取出当前的偏移量
    CGPoint titleContentOffset = self.titleScrollView.contentOffset;
    // 设置偏移x
    titleContentOffset.x = currentLabel.centerX - scrollView.width * 0.5;
    // 当偏移量小于0的时候说明偏移到最左边，
    if (titleContentOffset.x < 0) titleContentOffset.x = 0;
    // 最右边偏移
    CGFloat maxContentOffsetX = self.titleScrollView.contentSize.width - self.view.width;
    if (titleContentOffset.x > maxContentOffsetX) titleContentOffset.x = maxContentOffsetX;
    [self.titleScrollView setContentOffset:titleContentOffset animated:YES];
    
    
    
    // 如果当前控制器已经显示过了，我们就不需要再次进行计算它的frame，可以直接返回
    if ([willShowVc isViewLoaded]) return;
    
    // 另一种办法
//    if (willShowVc.view.superview) return;
    
    // 计算控制器view的frame
    willShowVc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.width, scrollView.height);
    [self.contentVc addSubview:willShowVc.view];
}

// 当滑动的时候调用,计算偏移颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x / scrollView.width;
    NSInteger index = offset;
    // 左边label
    JXLabel * leftLabel = self.titleScrollView.subviews[index];
    CGFloat leftScale = offset - index;
    leftLabel.scale = leftScale;
    
    // 右边label
    JXLabel * rightLabel = (index == self.titleScrollView.subviews.count - 1) ? nil : self.titleScrollView.subviews[index + 1];
    CGFloat rightScale = 1 - leftScale;
    rightLabel.scale = rightScale;
}
@end
