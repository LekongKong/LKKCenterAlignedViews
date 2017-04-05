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
    [self setCustomViews:views padding:padding viewSize:CGSizeZero];
}

- (void)setCustomViews:(NSArray<UIView *> *)views padding:(CGFloat)padding viewSize:(CGSize)size
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (!views || views.count == 0) {
        return;
    }
    
    __block UIView *preview = nil;
    __weak typeof(self) weakSelf = self;
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.tag = idx;
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clickView:)];
        [view addGestureRecognizer:gestureRecognizer];
        [weakSelf addSubview:view];
        [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:weakSelf attribute:NSLayoutAttributeCenterY  multiplier:1.0 constant:0]];
        if (size.width && size.height) {
            [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:weakSelf attribute:NSLayoutAttributeNotAnAttribute  multiplier:1.0 constant:size.width]];
            [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:weakSelf attribute:NSLayoutAttributeNotAnAttribute  multiplier:1.0 constant:size.height]];
        } else {
            [weakSelf addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
            [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        }
        if (preview) {
            [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:preview attribute:NSLayoutAttributeRight multiplier:1.0 constant:padding]];
        } else {
            [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:weakSelf attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        }
        
        if (idx == views.count - 1) {
            [weakSelf addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:weakSelf attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
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

- (void)clickView:(UIGestureRecognizer *)gestureRecognizer
{
    NSInteger index = gestureRecognizer.view.tag;
    if ([self.delegate respondsToSelector:@selector(centerAlignedView:didClickViewAtIndex:)]) {
        [self.delegate centerAlignedView:self didClickViewAtIndex:index];
    }
}

@end
