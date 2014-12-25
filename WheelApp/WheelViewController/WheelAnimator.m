//
//  MyAnimator.m
//  WheelApp
//
//  Created by Alireza Forouzan on 12/14/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import "WheelAnimator.h"
#import "WheelTransitionContext.h"
#define TransitionDuration 0.25

@implementation WheelAnimator
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return TransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    [[transitionContext containerView] addSubview:fromViewController.view];
    
    fromViewController.view.frame=[transitionContext initialFrameForViewController:fromViewController];
    toViewController.view.frame=[transitionContext initialFrameForViewController:toViewController];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame=[transitionContext finalFrameForViewController:fromViewController];
        toViewController.view.frame=[transitionContext finalFrameForViewController:toViewController];
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
