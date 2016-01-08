//
//  ZScanView.m
//  ScanDemo
//
//  Created by Alex on 16/1/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ZScanView.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanNetAnimation.h"
#import "ScanLineAnimation.h"
#import "ZScanCoverView.h"

@interface ZScanView()<AVCaptureMetadataOutputObjectsDelegate>

// 硬件设备
@property (strong, nonatomic) AVCaptureDevice *captureDevice;
// 输入设备
@property (strong, nonatomic) AVCaptureDeviceInput *caputreInput;
// 输出设备
@property (strong, nonatomic) AVCaptureMetadataOutput *captureOuput;
// 管理输入和输出设备
@property (strong, nonatomic) AVCaptureSession *captureSession;
// 预览
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
//网格扫码动画封装
@property (strong, nonatomic) ScanNetAnimation *scanNetAnimation;
// 线条扫描动画
@property (strong, nonatomic) ScanLineAnimation *scanLineAnimation;

@end

@implementation ZScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSError *error;
   
    // 物理输入设备,包括摄像头和麦克风
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 管理输入与输出之间的数据流，以及在出现问题时生成运行时错误。
    _captureSession = [[AVCaptureSession alloc]init];
    
   // 使用该对象从AVCaptureDevice设备获取数据,该对象将会被添加给AVCaptureSession管理.
    _caputreInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    
    // 启用检测人脸和二维码
    _captureOuput = [[AVCaptureMetadataOutput alloc]init];
    
    if ([_captureSession canAddInput:_caputreInput]) {
        [_captureSession addInput:_caputreInput];
    }
    
    if ([_captureSession canAddOutput:_captureOuput]) {
        [_captureSession addOutput:_captureOuput];
    }
    
    [_captureOuput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置条形码类型
    [_captureOuput setMetadataObjectTypes:[_captureOuput availableMetadataObjectTypes]];
    
    // 实现拍摄预览
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_captureSession];
    [_captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    _captureVideoPreviewLayer.frame = self.bounds;
    [self.layer addSublayer:_captureVideoPreviewLayer];
    
    CGFloat weidth = 250.;
    CGFloat height = 250.;
    
    // 扫描框区域
    CGRect scanRetangleRect =  CGRectMake((self.frame.size.width-weidth)/2., (self.frame.size.height-height)/2., weidth, height);
    
    // 覆盖一层黑色半透明View
    ZScanCoverView *sacnCoverView = [[ZScanCoverView alloc]initWithScanRect:scanRetangleRect];
    [self addSubview:sacnCoverView];
    
    // 背景框
    UIImageView *scanBgImgView = [[UIImageView alloc]init];
    scanBgImgView.frame = scanRetangleRect;
    scanBgImgView.image = [UIImage imageNamed:@"pick_bg"];
    [self addSubview:scanBgImgView];
    
    //网格动画
    /*
     if (!_scanNetAnimation){
     // 网格图片
     UIImage *imgFullNet = [UIImage imageNamed:@"qrcode_scan_full_net"];
     self.scanNetAnimation = [[ScanNetAnimation alloc]init];
     [_scanNetAnimation startAnimatingWithRect:scanRetangleRect
     InView:self.view
     Image:imgFullNet];
     }
     */
    
    if (!_scanLineAnimation) {
        UIImage *lineImg = [UIImage imageNamed:@"line"];
        _scanLineAnimation = [[ScanLineAnimation alloc]init];
        [_scanLineAnimation startAnimatingWithRect:scanRetangleRect
                                            InView:self
                                             Image:lineImg];
    }
    
    // 开始捕获
    [_captureSession startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 判断是否有数据
    if (metadataObjects != nil &&[metadataObjects count]> 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
//        NSLog(@"扫描结果%@",metadataObj.stringValue);
        if (metadataObj.stringValue && ![metadataObj.stringValue isEqualToString:@""] && metadataObj.stringValue.length > 0)
        {
            //self.successBlock(metadataObj.stringValue);
            [_scanLineAnimation stopAnimating];
            self.ZScanSuccessBlock(metadataObj.stringValue);
        }
        // 获得扫描的数据,结束扫描
        [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
    }
}

- (void)stopReading
{
    [_captureSession stopRunning];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
