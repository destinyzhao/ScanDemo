//
//  ZScanViewController.m
//  ScanDemo
//
//  Created by Alex on 16/1/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ZScanViewController.h"
#import "ZScanView.h"

@interface ZScanViewController ()

@end

@implementation ZScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ZScanView *scanView = [[ZScanView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scanView];
    scanView.ZScanSuccessBlock = ^(NSString *scanStr){
        [self showAlert:scanStr];
    };
    
}

- (void)showAlert:(NSString *)msg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:okAction];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
