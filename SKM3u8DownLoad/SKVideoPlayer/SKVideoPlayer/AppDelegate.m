//
//  AppDelegate.m
//  SKVideoPlayer
//
//  Created by shavekevin on 2018/6/13.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "AppDelegate.h"
#import <HTTPServer.h>

#import "SKHeaderFile.h"

@interface AppDelegate ()

@property (strong, nonatomic) HTTPServer *httpServer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 可以自己在rootvc开启。开启和关闭时机可以根据视频播放的时机。
    [self openLocalServer];

    return YES;
}

- (void)openLocalServer {
    
    self.httpServer = [[HTTPServer alloc] init ];
    [self.httpServer setType:@"_http._tcp."];
    [self.httpServer setPort:9999];
    NSString *webPath = [kDocPath stringByAppendingString:kVedioListPath];
    [self.httpServer setDocumentRoot:webPath];
    NSLog(@"服务器路径：%@", webPath);// 注意这个路径很重要。开启本地服务以后 视频的m3u8的服务器地址就是localhost:port了。
    NSError *error;
    if ([self.httpServer start:&error]) {
        NSLog(@"开启HTTP服务器 端口:%hu",[self.httpServer listeningPort]);
    }
    else{
        NSLog(@"服务器启动失败错误为:%@",error);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
