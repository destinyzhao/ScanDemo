//
//  CreateQrCodeViewController.m
//  ScanDemo
//
//  Created by Alex on 16/1/8.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "CreateQrCodeViewController.h"
#import "UIImage+CreateQrImage.h"

@interface CreateQrCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *qrImgView;

@end

@implementation CreateQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _qrImgView.image = [UIImage createRRcode:@"www.baidu.com"];
    
    _qrImgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
    _qrImgView.layer.shadowRadius=1;//设置阴影的半径
    _qrImgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    _qrImgView.layer.shadowOpacity=0.3;
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
