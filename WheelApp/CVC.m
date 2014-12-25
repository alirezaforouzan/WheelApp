//
//  CVCViewController.m
//  WheelApp
//
//  Created by Alireza Forouzan on 12/18/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import "CVC.h"

@interface CVC ()
@property (strong,nonatomic) UILabel *text;
@end

@implementation CVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    self.text=[[UILabel alloc] initWithFrame:CGRectMake(150, 150, 50, 50)];
    self.text.font=[UIFont boldSystemFontOfSize:20];
    self.text.text=@"CVC";
    [self.view addSubview:self.text];
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"View C appeared");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"View C will disappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"View C disappeared");
}

@end
