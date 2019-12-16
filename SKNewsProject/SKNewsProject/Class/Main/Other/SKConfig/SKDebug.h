//
//  SKDebug.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#ifndef SKDebug_h
#define SKDebug_h

/// 打印日志.
#ifdef DEBUG
#define debugLog( s, ... ) NSLog( @"%@ \r\n Class: %@   Line: %d ", \
[NSString stringWithFormat:(s), ##__VA_ARGS__],  \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__ )
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(s, ...)
#define debugMethod()
#endif

#endif /* SKDebug_h */
