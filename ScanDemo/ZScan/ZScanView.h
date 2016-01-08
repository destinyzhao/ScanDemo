//
//  ZScanView.h
//  ScanDemo
//
//  Created by Alex on 16/1/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

/**
 *  扫描二维码
 *
 *  @param result
 *
 *  @return
 */

#import <UIKit/UIKit.h>

//typedef void(^SuccessBack)(id result);

@interface ZScanView : UIView

//@property (copy, nonatomic) SuccessBack successBlock;
@property (copy, nonatomic)  void (^ZScanSuccessBlock)(NSString *);

@end
