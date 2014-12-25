//
//  ViewController.m
//  WheelApp
//
//  Created by Alireza Forouzan on 12/14/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import "WheelViewController.h"
#import "WheelAnimator.h"
#import "WheelTransitionContext.h"

#define BottomBarHeight 100
#define BottomBarTopPadding 10
#define TitlePadding 20

@interface WheelViewController ()<UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) UIView *childView;
@property (strong, nonatomic) UIScrollView *titlesScrollView;
@property (strong, nonatomic) UIView *bottomBar;
@property (strong, nonatomic) UIView *selectorView;
@property (strong, nonatomic) UIButton *actionButton;

@property (nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *actionImages;
@property (strong, nonatomic) NSMutableArray *titleButtons;

@property BOOL shouldInitialScroll;
@end

@implementation WheelViewController

- (UIScrollView *)titlesScrollView{
    if (!_titlesScrollView){
        CGRect frame=CGRectMake(0,BottomBarTopPadding,self.view.bounds.size.width,BottomBarHeight-BottomBarTopPadding);
        _titlesScrollView=[[UIScrollView alloc] initWithFrame:frame];
    }
    return _titlesScrollView;
}

- (UIView *)bottomBar{
    if (!_bottomBar){
        CGRect frame=CGRectMake(0,self.view.bounds.size.height-BottomBarHeight,self.view.bounds.size.width,BottomBarHeight);
        _bottomBar=[[UIView alloc] initWithFrame:frame];
        _bottomBar.backgroundColor=[UIColor blackColor];
    }
    return _bottomBar;
}

- (UIView *)selectorView{
    if (!_selectorView){
        CGRect frame=CGRectMake(self.view.frame.size.width/2-2.5,5,5,5);
        _selectorView=[[UIView alloc] initWithFrame:frame];
        _selectorView.backgroundColor=[UIColor yellowColor];
        _selectorView.layer.cornerRadius=2.5;
    }
    return _selectorView;
}

- (UIButton *)actionButton{
    if (!_actionButton){
        CGRect frame=CGRectMake((self.view.frame.size.width-65)/2,BottomBarHeight-65-5,65,65);
        _actionButton=[[UIButton alloc] initWithFrame:frame];
        _actionButton.backgroundColor=[UIColor clearColor];
        _actionButton.layer.cornerRadius=32.5;
        [_actionButton addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

- (UIActivityIndicatorView *)actionAI{
    if (!_actionAI){
        _actionAI=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(9,9,50,50)];
        _actionAI.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        _actionAI.color=[UIColor blackColor];
    }
    return _actionAI;
}

- (NSMutableArray *)titleButtons{
    if (!_titleButtons){
        _titleButtons=[[NSMutableArray alloc] init];
    }
    return _titleButtons;
}

- (UIView *)childView{
    if (!_childView){
        CGRect frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-BottomBarHeight-1);
        _childView=[[UIView alloc] initWithFrame:frame];
        _childView.backgroundColor=[UIColor clearColor];
    }
    return _childView;
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    NSInteger previousIndex=_currentIndex;
    _currentIndex=currentIndex;
    [self transitionToTitle:self.titleButtons[_currentIndex]];
    [self transitionToActionButton:self.actionImages[_currentIndex]];
    if (_currentIndex!=previousIndex){
        [self transitionToViewController:self.viewcontrollers[_currentIndex]];
    }
}

- (void)setViewcontrollers:(NSArray *)viewcontrollers{
    _viewcontrollers=viewcontrollers;
    for (UIViewController *viewcontroller in _viewcontrollers){
        viewcontroller.transitioningDelegate=self;
    }
}

- (void)initWithTitles:(NSArray *)titles actionImages:(NSArray *)actionImages viewcontrollers:(NSArray *)viewcotrollers{
    self.titles=titles;
    self.actionImages=actionImages;
    self.viewcontrollers=viewcotrollers;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor=[UIColor whiteColor];
    self.shouldInitialScroll=YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.shouldInitialScroll){
        self.currentIndex=self.titles.count/2;
        self.shouldInitialScroll=NO;
    }
}

- (void)setupUI{
    //Setup gestures for the page
    UISwipeGestureRecognizer *swipeRightGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(swiped:)];
    swipeRightGesture.direction=UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(swiped:)];
    swipeLeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRightGesture];
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    //Setup the labels
    UIFont *titleFont=[UIFont systemFontOfSize:14];
    NSDictionary *titleNormalAttributes=@{NSFontAttributeName : titleFont,
                                          NSForegroundColorAttributeName: [UIColor whiteColor],
                                          NSKernAttributeName : @(2.3f)};
    NSDictionary *titleSelectedAttributes=@{NSFontAttributeName : titleFont,
                                            NSForegroundColorAttributeName: [UIColor yellowColor],
                                            NSKernAttributeName : @(2.3f)};
    
    CGFloat leftOffset=TitlePadding;
    for (NSString* title in self.titles){
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        CGSize stringSize=[title sizeWithAttributes:titleNormalAttributes];
        button.frame=CGRectMake(leftOffset,0,stringSize.width,stringSize.height);
        button.titleLabel.font=titleFont;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
        
        NSAttributedString *titleNormalAttributed=[[NSAttributedString alloc] initWithString:title
                                                                                  attributes:titleNormalAttributes];
        NSAttributedString *titleSelectedAttributed=[[NSAttributedString alloc] initWithString:title
                                                                                    attributes:titleSelectedAttributes];
        [button setAttributedTitle:titleNormalAttributed forState:UIControlStateNormal];
        [button setAttributedTitle:titleSelectedAttributed forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=[self.titles indexOfObject:title];
        leftOffset=leftOffset+button.frame.size.width+20;
        [self.titlesScrollView addSubview:button];
        [self.titleButtons addObject:button];
    }
    
    //Add views to parent
    [self.bottomBar addSubview:self.titlesScrollView];
    [self.bottomBar addSubview:self.selectorView];
    [self.actionButton addSubview:self.actionAI];
    [self.bottomBar addSubview:self.actionButton];
    
    [self.view addSubview:self.bottomBar];
    
    //Setup child View
    [self.view addSubview:self.childView];
}

- (void)transitionToTitle:(UIButton *)currentLabel{
    for (UIButton *button in self.titleButtons){
        button.selected=NO;
    }
    currentLabel.selected=YES;
    CGRect titleFrame=currentLabel.frame;
    CGFloat xOffset=titleFrame.origin.x+titleFrame.size.width/2-self.view.frame.size.width/2;
    [UIView animateWithDuration:0.25 animations:^{
        self.titlesScrollView.contentOffset = CGPointMake(xOffset,self.titlesScrollView.contentOffset.y);
    }];
}

- (void)transitionToActionButton:(UIImage *)toActionButtonImage{
    [UIView animateWithDuration:0.25 animations:^{
        [self.actionButton setBackgroundImage:toActionButtonImage forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
    }];
}


//Methods for transition
- (void)transitionToViewController:(UIViewController*)toViewController{
    toViewController.view.frame = self.childView.frame;
    //If it's the first time, no transition needed.
    if (!self.currentViewController){
        [self addChildViewController:toViewController];
        [self.childView addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        self.currentViewController=toViewController;
        return;
    }
    
    //Transition showing the next viewcontroller
    WheelAnimator *animator = [[WheelAnimator alloc] init];
    NSUInteger fromIndex=[self.viewcontrollers indexOfObject:self.currentViewController];
    NSUInteger toIndex=[self.viewcontrollers indexOfObject:toViewController];
    
    WheelTransitionContext *transitionContext = [[WheelTransitionContext alloc]
                                                 initWithFromViewController:self.currentViewController
                                                 toViewController:toViewController
                                                 goingRight:toIndex > fromIndex];
    
    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completionBlock = ^(BOOL didComplete) {
        [self.currentViewController.view removeFromSuperview];
        [self.currentViewController removeFromParentViewController];
        [self.currentViewController willMoveToParentViewController:nil];
        
        [self addChildViewController:toViewController];
        [self.childView addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        self.currentViewController=toViewController;
        
        if ([animator respondsToSelector:@selector (animationEnded:)]) {
            [animator animationEnded:didComplete];
        }
    };
    [animator animateTransition:transitionContext];
}

- (void)swiped:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction==UISwipeGestureRecognizerDirectionLeft && self.currentIndex<self.titles.count-1){
        self.currentIndex++;
    }
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight && self.currentIndex>0){
        self.currentIndex--;
    }
}

- (void)titleClicked:(UIButton *)sender{
    self.currentIndex=sender.tag;
}

- (void)actionButtonClicked:(UIButton *)sender{
    NSLog(@"Action button clicked");
    if ([self.viewcontrollers[self.currentIndex] respondsToSelector:@selector(actionButtonClicked:)]){
        [self.viewcontrollers[self.currentIndex] performSelector:@selector(actionButtonClicked:) withObject:sender];
        return;
    }
    if ([self.viewcontrollers[self.currentIndex] isKindOfClass:[UINavigationController class]]){
        UIViewController *currentVC=((UINavigationController *)self.viewcontrollers[self.currentIndex]).visibleViewController;
        if ([currentVC respondsToSelector:@selector(actionButtonClicked:)]){
            [currentVC performSelector:@selector(actionButtonClicked:) withObject:sender];
        }
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
