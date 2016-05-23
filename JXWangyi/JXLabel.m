//
//  JXLabel.m
//  JXWangyi
//
//  Created by 王加祥 on 16/5/23.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXLabel.h"

@implementation JXLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        // label颜色
        self.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:1.0];
    }
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:scale blue:1 - scale alpha:1.0];
    CGFloat transformScale = 1 + (1 - scale) * 0.3;
    self.transform = CGAffineTransformMakeScale(transformScale , transformScale);
}
@end
