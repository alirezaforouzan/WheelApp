//
//  MyTransitionContext.m
//  WheelApp
//
//  Created by Alireza Forouzan on 12/14/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import "WheelTransitionContext.h"

@interface WheelTransitionContext()

@end

@implementation WheelTransitionContext

- (id)initWithFromViewController:(UIViewController *)fromViewController 
                toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight {
    
    if (!([fromViewController isViewLoaded] && fromViewController.view.superview)){
        NSLog(@"The fromViewController view must reside in the container view upon initializing the transition context.");
        return nil;
    }
    
    if ((self = [super init])) {
        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        self.privateViewControllers = @{UITransitionContextFromViewControllerKey:fromViewController,
                                        UITransitionContextToViewControllerKey:toViewController,
                                        };
        CGFloat travelDistance = (goingRight ? -self.containerView.bounds.size.width : self.containerView.bounds.size.width);
        self.privateDisappearingFromRect = self.containerView.bounds;
        self.privateDisappearingToRect = CGRectOffset (self.containerView.bounds, travelDistance, 0);
        
        self.privateAppearingFromRect = CGRectOffset (self.containerView.bounds, -travelDistance, 0);
        self.privateAppearingToRect = self.containerView.bounds;
        self.isRight=goingRight;
    }
    return self;
}

- (CGRect)initialFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingFromRect;
    } else {
        return self.privateAppearingFromRect;
    }
}

- (CGRect)finalFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingToRect;
    } else {
        return self.privateAppearingToRect;
    }
}

- (UIViewController *)viewControllerForKey:(NSString *)key {
    return self.privateViewControllers[key];
}

- (UIView *)viewForKey:(NSString *)key{
    return ((UIViewController *)self.privateViewControllers[key]).view;
}

- (void)completeTransition:(BOOL)didComplete {
    NSLog(@"Transition completed.");
    if (self.completionBlock) {
        self.completionBlock (didComplete);
    }
}

- (BOOL)transitionWasCancelled{
    return NO;
}

- (CGAffineTransform)targetTransform{
    return CGAffineTransformIdentity;
}

// Implement empty method for interactive mode to supress warning.
- (void)updateInteractiveTransition:(CGFloat)percentComplete {}
- (void)finishInteractiveTransition {}
- (void)cancelInteractiveTransition {}
@end
