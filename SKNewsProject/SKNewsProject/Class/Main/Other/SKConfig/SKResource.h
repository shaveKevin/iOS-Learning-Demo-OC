//
//  SKResource.h
//  SKNewsProject
//
//  Created by shavekevin on 2016/11/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#ifndef SKResource_h
#define SKResource_h

//=============================定义保存资源路径=========================

/// doc沙盒.
#define kDocPath         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]

/// Liberay.
#define kLibraryPath     [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]

/// cache沙盒.
#define kCachPath        [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]

/// temp沙盒.
#define kTmpPath          NSTemporaryDirectory()

//======================================================
// 图片路径
//======================================================
#define kImgDataPath    @"/Images"
#define kImgListPath    @"/Images/ImageList"


//======================================================
// 视频路径
//======================================================
#define kVedioDataPath  @"/DownLoad"
#define kVedioTempPath  @"/DownLoad/Temp"
#define kVedioListPath  @"/DownLoad/VideoList"


//======================================================
// 版本路径
//======================================================
#define kVersionDataDirectryPath    @"/Version"
#define kVersionDataPath            @"/Version/version"


//======================================================
// 数据库路径
//======================================================
#define DBPATH @"SKNews/DB"


#endif /* SKResource_h */
