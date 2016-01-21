//
//  TouchIDAuthTool.m
//  TouchIDDemo
//
//  Created by Realank on 16/1/21.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "TouchIDAuthTool.h"
#import <UIKit/UIKit.h>

#define OS_HIGHER_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation TouchIDAuthTool



- (void)authUser {
    
    if (OS_HIGHER_8) {
        LAContext *context = [[LAContext alloc]init];
        
        NSError *error = nil;
        
        if ([context canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //支持指纹识别
            [context evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请输入指纹以验证身份" reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    //成功
                    NSLog(@"验证成功");
                }else {
                    NSLog(@"验证失败：%@",error);
                    //验证失败
                    switch (error.code) {
                        case kLAErrorAuthenticationFailed:
                        {
                            NSLog(@"校验失败");
                            break;
                        }
                        case kLAErrorUserCancel:
                        {
                            NSLog(@"用户取消校验");
                            break;
                        }
                        case kLAErrorUserFallback:
                        {
                            NSLog(@"用户回退校验（选择使用密码校验）");
                            break;
                        }
                        case kLAErrorSystemCancel:
                        {
                            NSLog(@"系统取消校验");
                            break;
                        }
                        case kLAErrorAppCancel:
                        {
                            NSLog(@"应用取消校验");
                            break;
                        }
                        case kLAErrorTouchIDLockout:
                        {
                            NSLog(@"TouchID验证失败次数过多已锁定，需要输入设备密码恢复");
                            break;
                        }
                        case kLAErrorInvalidContext:
                        {
                            NSLog(@"LAContext对象被意外释放");
                            break;
                        }
                        default:
                        {
                            NSLog(@"校验失败");
                            break;
                        }
                    }
                }
            }];
        }else {
            //不支持指纹识别
            switch (error.code) {
                case kLAErrorPasscodeNotSet:
                {
                    NSLog(@"用户没有设置密码");
                    break;
                }
                case kLAErrorTouchIDNotAvailable:
                {
                    NSLog(@"TouchID功能不可用");
                    break;
                }
                case kLAErrorTouchIDNotEnrolled:
                {
                    NSLog(@"TouchID没有可用指纹");
                    break;
                }
                default:
                {
                    NSLog(@"不支持指纹识别");
                    break;
                }
            }
        }
        
    }
    
    
}



+ (void)authUserSuccess:(void(^)())successBlock andFailure:(void(^)(NSInteger errorCode, NSString* errorMessage))failureBlock {
    
    if (OS_HIGHER_8) {
        LAContext *context = [[LAContext alloc]init];
        
        NSError *error = nil;
        __block NSInteger errorCode = kLAErrorAuthenticationFailed;
        __block NSString *errorMessage = @"校验失败";
        
        if ([context canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //支持指纹识别
            [context evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请输入指纹以验证身份" reply:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    //成功
                    //                    NSLog(@"验证成功");
                    if (success) {
                        successBlock();
                    }
                }else {
                    
                    //验证失败
                    switch (error.code) {
                        case kLAErrorAuthenticationFailed:
                        {
                            //                            NSLog(@"校验失败");
                            errorCode = error.code;
                            errorMessage = @"校验失败";
                            break;
                        }
                        case kLAErrorUserCancel:
                        {
                            //                            NSLog(@"用户取消校验");
                            errorCode = error.code;
                            errorMessage = @"用户取消校验";
                            break;
                        }
                        case kLAErrorUserFallback:
                        {
                            //                            NSLog(@"用户回退校验（选择使用密码校验）");
                            errorCode = error.code;
                            errorMessage = @"用户回退校验（选择使用密码校验）";
                            break;
                        }
                        case kLAErrorSystemCancel:
                        {
                            //                            NSLog(@"系统取消校验");
                            errorCode = error.code;
                            errorMessage = @"系统取消校验";
                            break;
                        }
                        case kLAErrorAppCancel:
                        {
                            //                            NSLog(@"应用取消校验");
                            errorCode = error.code;
                            errorMessage = @"应用取消校验";
                            break;
                        }
                        case kLAErrorTouchIDLockout:
                        {
                            //                            NSLog(@"TouchID验证失败次数过多已锁定，需要输入设备密码恢复");
                            errorCode = error.code;
                            errorMessage = @"TouchID验证失败次数过多已锁定，需要输入设备密码恢复";
                            break;
                        }
                        case kLAErrorInvalidContext:
                        {
                            //                            NSLog(@"LAContext对象被意外释放");
                            errorCode = error.code;
                            errorMessage = @"LAContext对象被意外释放";
                            break;
                        }
                        default:
                        {
                            //                            NSLog(@"校验失败");
                            errorCode = error.code;
                            errorMessage = @"校验失败-未知错误";
                            break;
                        }
                    }
                    
                    if (failureBlock) {
                        failureBlock(errorCode, errorMessage);
                    }
                    
                }
            }];
        }else {
            //不支持指纹识别
            switch (error.code) {
                case kLAErrorPasscodeNotSet:
                {
                    //                    NSLog(@"用户没有设置密码");
                    errorCode = error.code;
                    errorMessage = @"用户没有设置密码";
                    break;
                }
                case kLAErrorTouchIDNotAvailable:
                {
                    //                    NSLog(@"TouchID功能不可用");
                    errorCode = error.code;
                    errorMessage = @"TouchID功能不可用";
                    break;
                }
                case kLAErrorTouchIDNotEnrolled:
                {
                    //                    NSLog(@"TouchID没有可用指纹");
                    errorCode = error.code;
                    errorMessage = @"TouchID没有可用指纹";
                    break;
                }
                default:
                {
                    //                    NSLog(@"不支持指纹识别");
                    errorCode = error.code;
                    errorMessage = @"不支持指纹识别-未知错误";
                    break;
                }
            }
            
            if (failureBlock) {
                failureBlock(errorCode, errorMessage);
            }
        }
        
    }else {
        failureBlock(kLAErrorTouchIDNotAvailable, @"当前系统不支持Touch ID");
    }
    
    
}


@end
