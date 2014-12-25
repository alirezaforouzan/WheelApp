//
//  UploadViewController.m
//  WheelApp
//
//  Created by Alireza Forouzan on 12/18/14.
//  Copyright (c) 2014 Kateb. All rights reserved.
//

#import "MainViewController.h"
#import "AVC.h"
#import "BVC.h"
#import "CVC.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVC *avc=[[AVC alloc] init];
    UIImage *aimage=[UIImage imageNamed:@"defaultConfirmNormal.png"];
    BVC *bvc=[[BVC alloc] init];
    UIImage *bimage=[UIImage imageNamed:@"cameraConfirmNormal.png"];
    CVC *cvc=[[CVC alloc] init];
    UIImage *cimage=[UIImage imageNamed:@"defaultConfirmNormal.png"];
    
    [self initWithTitles:[NSArray arrayWithObjects:@"Gallery",@"Photo",@"Text",nil]
            actionImages:[NSArray arrayWithObjects:aimage,bimage,cimage, nil]
         viewcontrollers:[NSArray arrayWithObjects:avc,bvc,cvc,nil]];
}

@end
