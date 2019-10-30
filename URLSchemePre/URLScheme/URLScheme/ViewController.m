//
//  ViewController.m
//  URLScheme
//
//  Created by shavekevin on 16/1/14.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)pressAction:(id)sender {
    NSString *passValue = @"URLSchemeTest://www.username=55555@example.com:passwordis333@xxx.com;param=value?query=value#ref";
    NSURL *testURLScheme = [NSURL URLWithString:passValue];
    if ([[UIApplication sharedApplication] canOpenURL:testURLScheme]) {
        [[UIApplication sharedApplication] openURL:testURLScheme];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
