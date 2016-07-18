//
//  LKKCenterAlignedView.m
//  Pods
//
//  Created by humian on 16/7/15.
//
//

#import "LKKCenterAlignedView.h"

@implementation LKKCenterAlignedView

- (void)setCustomViews:(NSArray<UIView *> *)views padding:(CGFloat)padding
{
    if (views.count == 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return;
    }
    
    __block UIView *preview = nil;
    __weak typeof(self) weakSelf = self;
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf addSubview:view];
        [weakSelf addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
        if (preview) {
            [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:preview attribute:NSLayoutAttributeRight multiplier:1.0 constant:padding]];
        }
        preview = view;
    }];
    NSInteger center = center = views.count / 2;
    if (views.count % 2 == 0) {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:views[center] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:padding/2]];
    } else {
        [self addConstraint:[NSLayoutConstraint constraintWithItem:views[center] attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX  multiplier:1.0 constant:0]];
    }
}

@end
