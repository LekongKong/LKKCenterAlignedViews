//
//  LKKCenterAlignedView.h
//  Pods
//
//  Created by humian on 16/7/15.
//
//

#import <UIKit/UIKit.h>

@class LKKCenterAlignedView;
@protocol LKKCenterAlignedViewDelegate <NSObject>

- (void)centerAlignedView:(LKKCenterAlignedView *)view didClickViewAtIndex:(NSUInteger)index;

@end

@interface LKKCenterAlignedView : UIView

@property (nonatomic, weak) id<LKKCenterAlignedViewDelegate> delegate;

/**
 *  默认每个view上下撑开，并且宽高相等
 */
- (void)setCustomViews:(NSArray<UIView *> *)views padding:(CGFloat)padding addTapGesture:(BOOL)addGesture;

/**
 *  自定义view的大小
 */
- (void)setCustomViews:(NSArray<UIView *> *)views padding:(CGFloat)padding viewSize:(CGSize)size addTapGesture:(BOOL)addGesture;

@end
