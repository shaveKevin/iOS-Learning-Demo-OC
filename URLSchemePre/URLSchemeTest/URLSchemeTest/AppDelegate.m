//
//  AppDelegate.m
//  URLSchemeTest
//
//  Created by shavekevin on 16/1/14.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    

    if ([url.scheme isEqualToString:@"URLSchemeTest"]) {
        // 完整的URL是这样的 URLSchemeTest://www.username=55555@example.com:passwordis333@xxx.com;param=value?query=value#ref
        //获取到的是完整的NSURL NSData 类型  可以转化成字符串 要写字符串编码格式UTF8
        NSLog(@"url.dataRepresentation is --> %@",url.dataRepresentation);
        NSString *pageSource = [[NSString alloc] initWithData:url.dataRepresentation encoding:NSUTF8StringEncoding];
        //打印出的是完整的URL 字符串类型
        NSLog(@"str --> %@",pageSource);
        //完整的URL字符串
        NSLog(@"-url.absoluteString---is %@",url.absoluteString);
        //完整的URL
        NSLog(@"---url.absoluteURL---is %@",url.absoluteURL);
        //官方文档说任何一个完整的URL 由两个组成结构 一个是 url.scheme  一个是url.resourceSpecifier
        //url.scheme 指的是 URL的前缀 包括：  例如 http://www.baidu.com/index.html  其中 url.scheme 指的就是 http: 而 url.resourceSpecifier 指的就是 //www.baidu.com
        NSLog(@"---url.scheme---is %@",url.scheme);
        NSLog(@"----url.resourceSpecifier is %@",url.resourceSpecifier);
        //  url.host  一般指的是完整URL中 第一个//之后的部分 可能为空 我们使用的时候应用间跳转可以通过这个来进行进程间的通信 那么我们可以在// 做一些传值的操作 然后可以在要跳转的应用中截取到指定的信息完成相应的操作

        NSLog(@"----url.host--is %@",url.host);
        //The path for the NSURL object (for example, /index.html). If the path begins with a tilde, you must first expand it by calling stringByExpandingTildeInPath.
        // url.path值得是URL后面你定义的 后缀 以/开头到结束后的  /index.html
        //This property contains the path, unescaped using the stringByReplacingPercentEscapesUsingEncoding: method. If the receiver does not conform to RFC 1808, this property contains nil.
        
//        If the receiver contains a file or file reference URL (as determined with isFileURL), this property’s value is suitable for input into methods of NSFileManager or NSPathUtilities. If the path has a trailing slash, it is stripped.
//            
//            If the receiver contains a file reference URL, this property’s value provides the current path for the referenced resource, which may be nil if the resource no longer exists.
//                
//                If the parameterString property contains a non-nil value, the path may be incomplete. If the receiver contains an unencoded semicolon, the path property ends at the character before the semicolon. The remainder of the URL is provided in the parameterString property.
//                
//                To obtain the complete path, if parameterString contains a non-nil value, append a semicolon, followed by the parameter string.
//                    
//                    Per RFC 3986, the leading slash after the authority (host name and port) portion is treated as part of the path. For example, in the URL http://www.example.com/index.html, the path is /index.html.
        NSLog(@"------url.path is %@",url.path);
        //.This property contains the user name, unescaped using the stringByReplacingPercentEscapesUsingEncoding: method. If the receiver’s URL does not conform to RFC 1808, this property returns nil. For example, in the URL ftp://username@www.example.com/, the user name is username.
        NSLog(@"---url.user--is %@",url.user);
        //This property contains the port number. If the receiver does not conform to RFC 1808, this property contains nil. For example, in the URL http://www.example.com:8080/index.php, the port number is 8080. 冒号后面的NSNumber 为 端口号
        NSLog(@"---url.port--is %@",url.port);
       // For example, in the URL http://username:password@www.example.com/index.html, the password is password.
        NSLog(@"---url.password--is %@",url.password);
        //This property contains the parameter string. If the receiver does not conform to RFC 1808, this property contains nil. For example, in the URL file:///path/to/file;foo, the parameter string is foo.
        // 三个 /// 分号之后的代表参数字符串
        NSLog(@"---url.parameterString--is %@",url.parameterString);
        //？后面的#之前的就是就是query
      //This property contains the query string. If the receiver does not conform to RFC 1808, this property contains nil. For example, in the URL http://www.example.com/index.php?key1=value1&key2=value2, the query string is key1=value1&key2=value2.
        NSLog(@"---url.query--is %@",url.query);
        //This property contains the relative path of the receiver’s URL without resolving against its base URL. If the path has a trailing slash it is stripped. If the receiver is an absolute URL, this property contains the same value as path. If the receiver does not conform to RFC 1808, it contains nil.
        NSLog(@"---url.relativePath--is %@",url.relativePath);
        // This property contains the URL’s fragment. If the receiver does not conform to RFC 1808, this property contains nil. For example, in the URL http://www.example.com/index.html#jumpLocation, the fragment identifier is jumpLocation.
        //#之后的就是fragment
        NSLog(@"---url.fragment--is %@",url.fragment);
        

    }
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
