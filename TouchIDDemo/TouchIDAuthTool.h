//
//  TouchIDAuthTool.h
//  TouchIDDemo
//
//  Created by Realank on 16/1/21.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDAuthTool : NSObject


/*  支持TouchID验证，但是验证失败
 kLAErrorAuthenticationFailed－用户校验失败
 kLAErrorUserCancel－用户取消校验
 kLAErrorUserFallback－用户回退校验（选择使用密码校验）
 kLAErrorSystemCancel－系统取消校验
 kLAErrorAppCancel－应用取消校验
 kLAErrorTouchIDLockout－TouchID验证失败次数过多已锁定，需要输入设备密码恢复
 kLAErrorInvalidContext－LAContext对象被意外释放
 */
/* 不支持TouchID验证
 kLAErrorPasscodeNotSet－用户没有设置密码
 kLAErrorTouchIDNotAvailable－TouchID功能不可用
 kLAErrorTouchIDNotEnrolled－TouchID没有可用指纹
 */

+ (void)authUserSuccess:(void(^)())successBlock andFailure:(void(^)(NSInteger errorCode, NSString* errorMessage))failureBlock ;

@end
