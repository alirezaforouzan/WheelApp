//
//  BVC.m
//  WheelApp
//
//  Created by Alireza Forouzan on 12/14/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import "BVC.h"

@interface BVC ()
@property (strong,nonatomic) UILabel *text;
@end

@implementation BVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"View B did load");
    self.view.backgroundColor=[UIColor greenColor];
    self.text=[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    self.text.font=[UIFont boldSystemFontOfSize:20];
    self.text.text=@"BVC";
    [self.view addSubview:self.text];
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"View B appeared");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"View B will disappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"View B disappeared");
}

@end
