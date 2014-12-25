//
//  ViewController.h
//  WheelApp
//
//  Created by Alireza Forouzan on 12/14/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelViewController : UIViewController

@property (strong, nonatomic) UIActivityIndicatorView *actionAI;
@property (strong, nonatomic) NSArray *viewcontrollers;

- (void)initWithTitles:(NSArray *)titles actionImages:(NSArray *)actionImages viewcontrollers:(NSArray *)viewcotrollers;
@end

