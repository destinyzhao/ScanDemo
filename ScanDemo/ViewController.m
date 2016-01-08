//
//  ViewController.m
//  ScanDemo
//
//  Created by Alex on 16/1/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  扫描二维码
 *
 *  @param sender sender
 */
- (IBAction)sacnBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"ScanVC" sender:nil];
}

/**
 *  生成二维码
 *
 *  @param sender sender
 */
- (IBAction)createQrCodeBtnClicked:(id)sender {
    [self performSegueWithIdentifier:@"CreateQrCodeVC" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
