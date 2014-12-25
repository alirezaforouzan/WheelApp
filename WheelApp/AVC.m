//
//  AVC.m
//  WheelApp
//
//  Created by Alireza Forouzan on 12/14/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import "AVC.h"

@interface AVC ()
@property (strong,nonatomic) UILabel *text;

@end

@implementation AVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    self.text=[[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    self.text.font=[UIFont boldSystemFontOfSize:20];
    self.text.text=@"AVC";
    [self.view addSubview:self.text];
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"View A appeared");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"View A will disappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"View A disappeared");
}

@end
