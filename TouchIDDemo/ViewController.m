//
//  ViewController.m
//  TouchIDDemo
//
//  Created by Realank on 16/1/21.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "ViewController.h"
#import "TouchIDAuthTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)validateTouchID:(id)sender {
//    [self authUser];
    [TouchIDAuthTool authUserSuccess:^{
        NSLog(@"验证成功");
    } andFailure:^(NSInteger errorCode, NSString *errorMessage) {
        NSLog(@"错误：%@",errorMessage);
    }];
}



@end
