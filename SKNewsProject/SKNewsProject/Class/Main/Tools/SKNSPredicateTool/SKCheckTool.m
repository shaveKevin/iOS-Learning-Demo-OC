//
//  SKCheckTool.m
//  NSPredicateDemo
//
//  Created by shavekevin on 16/4/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKCheckTool.h"

//#import <sys/param.h>
#import <sys/mount.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  定义保存资源路径
 *
 *  @param NSDocumentDirectory
 *  @param NSUserDomainMask
 *  @param YES                 YES
 *
 *  @return 定义保存资源路径
 */
#ifndef kDocPath
#define kDocPath  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]
#endif

#ifndef kCachPath
#define kCachPath        [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]
#endif


#ifndef kTmpPath
#define kTmpPath          NSTemporaryDirectory()
#endif

@implementation SKCheckTool


+ (BOOL)isValidatePassWrod:(NSString *)password num:(int)num{
    
    NSString *mystring = password;
    if (num == 1) {
        //    判断密码是否 字母或数字  !#$%^&*.~,><:;+-_|'"=`(){}[]
        //     - [] /\ "这些不能用的
        
        NSString *numRegex = @"^[A-Za-z0-9^*()%&+{}_|!#~<>、:'.@,;=?$x22]+$";
        NSPredicate * charAndnum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
        
        if ([charAndnum evaluateWithObject:mystring] == YES) {
            return YES;
        }
        return NO;
        
    } else if (num == 2){
        // 中文和字母
        NSString *strRegex = @"^[\u4e00-\u9fa5]+|[A-Za-z]+$";
        NSPredicate *strText = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",strRegex];
        if ([strText evaluateWithObject:mystring] == YES) {
            return YES;
        }
        return NO;
    }
    
    return YES;
}


+ (BOOL)isChinese:(NSString *)str{
    NSString *strRegex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *strText = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",strRegex];
    NSString *mystring = str;
    if ([strText evaluateWithObject:mystring] == YES) {
        return YES;
    }
    return NO;
    
}

+ (BOOL) isEnglish:(NSString *)str {
    NSString *strRegex = @"[A-Za-z]+$";
    NSPredicate *strText = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",strRegex];
    NSString *mystring = str;
    if ([strText evaluateWithObject:mystring] == YES) {
        return YES;
    }
    return NO;
}


+ (BOOL)isNumber:(NSString *)str {
    NSString *strRegex = @"^[0-9]*$";
    NSPredicate *strText = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",strRegex];
    NSString *mystring = str;
    if ([strText evaluateWithObject:mystring] == YES) {
        return YES;
    }
    
    return NO;
   
}


+ (BOOL)checkIsChineseAndEnglish:(NSString *)str{
    
    if([SKCheckTool isChinese:str] || [SKCheckTool isEnglish:str] || [str isEqualToString:@""]){
        return YES;
    }
    return NO;

}


+ (BOOL)checkIsNumberAndIsEnglist:(NSString *)str{
    
    if([SKCheckTool isNumber:str] || [SKCheckTool isEnglish:str] || [str isEqualToString:@""]){
        
        return YES;
    }

    return NO;

}

+ (BOOL) isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailText = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailText evaluateWithObject:email];
}

+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13，15，18开头，八个 \d 数字字符  ^(13[0-9]|15[0-9]|18[0|6|8|9])\d{8}$
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(19[0-9])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL) isBlankString:(id )string {
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (string == nil || string == NULL || [string length] == 0) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]){
        return YES;
    }
    return NO;
}

+ (void)lockAnimationForView:(UIView*)view {
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}

+ (BOOL)isValidString:(NSString *)string withLength:(NSInteger)length{
    
    if ([string length] > 0 && string.length <= length) {
        return YES;
    }
    return NO;
}

+ (BOOL)isLengthString:(NSString *)string strType:(NSInteger)num {
    if (num == 1 && [string length] > 49) {
        return NO;
    }
    else if (num == 2 && ([string length] < 6 || [string length] >20)){
        return NO;
    }
    return YES;
}



+ (NSString *)getCarrierCode {
    // 判断是否能够取得运营商
    Class telephoneNetWorkClass = (NSClassFromString(@"CTTelephonyNetworkInfo"));
    if (telephoneNetWorkClass != nil)
    {
        CTTelephonyNetworkInfo *telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
        
        // 获得运营商的信息
        Class carrierClass = (NSClassFromString(@"CTCarrier"));
        if (carrierClass != nil)
        {
            CTCarrier *carrier = telephonyNetworkInfo.subscriberCellularProvider;
            NSString * carrierName = [carrier carrierName];
            return carrierName;
        }
    }
    
    return nil;
}


+ (UIColor *)colorFromHexRGB:(NSString *)inColorString {
    
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}



+ (long long)fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager*manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:filePath]){
        return[[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (long long)folderSizeAtPath2:(NSString*)folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if(![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString*
        fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize;
    
}


+ (long long)spaceefPath:(NSString * )subPath {
    return [self folderSizeAtPath2:subPath];
}

+ (NSString *)usedSpaceAndfreeSpaceSubsefPath:(NSString * )subPath {
    
    long long fileSize = [self folderSizeAtPath2:subPath];
    
    NSString *str = nil;
    if (fileSize/1024.0/1024.0 > 1024) {
        str= [NSString stringWithFormat:@"%0.fG",fileSize/1024.0/1024.0/1024.0];
    } else {
        str= [NSString stringWithFormat:@"%0.fMB",fileSize/1024.0/1024.0];
    }
    
    return str;
}

+(void)deleteDirectoryAllFilePath:(NSString *)allFilePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:allFilePath error:nil];
}



+ (NSString *)getFileSizeString:(NSString *)size {
    
    if([size floatValue] >= 1024*1024)
    {
        //大于1M，则转化成M单位的字符串
        return [NSString stringWithFormat:@"%1.2fM",[size floatValue]/1024/1024];
    }
    else if([size floatValue] >= 1024&&[size floatValue]<1024*1024)
    {
        //不到1M,但是超过了1KB，则转化成KB单位
        return [NSString stringWithFormat:@"%1.2fK",[size floatValue]/1024];
    }
    else
    {
        //剩下的都是小于1K的，则转化成B单位
        return [NSString stringWithFormat:@"%1.2fB",[size floatValue]];
    }
}

+ (BOOL)CheckIsMy:(id)LogCustomerId isOther:(id)LogTempId {
    
    if ([[NSString stringWithFormat:@"%@",LogCustomerId] isEqualToString:[NSString stringWithFormat:@"%@",LogTempId]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)canChangeText:(NSString *)textCount maxTextCount:(NSInteger)maxtextCount {
    // 字符串长度为空
    if((self == nil) || ([textCount length] == 0))
    {
        return YES;
    }
    
    NSInteger characterLen = [SKCheckTool canChangeText:textCount];
    
    if(characterLen <= maxtextCount)
    {
        return YES;
    }
    return NO;
}


+ (NSInteger)canChangeText:(NSString *)textCount maxNumberCount:(NSInteger)maxtextCount {
    // 字符串长度为空
    
    NSInteger characterLen = 0;
    for(NSInteger i = 0; i < [textCount length]; i++) {
        
        unichar character = [textCount characterAtIndex:i];
        
        // 中文
        if((character >= 0x4e00) && (character <= 0x9fbb)) {
            // 一个中文算2个长度
            characterLen += 2;
        } else {
            characterLen += 1;
        }
    }
    
    return maxtextCount-characterLen;
}

+ (NSInteger)canChangeText:(NSString *)textCount {
    
    // 字符串长度为空
    BOOL wordNum = YES;  //开关 单数开始计数,2个非中文字符计数-1
    NSInteger characterLen = 0;
    for(NSInteger i = 0; i < [textCount length]; i++) {
        unichar character = [textCount characterAtIndex:i];
        //改变开关状态
        if(!((character >= 0x4e00) && (character <= 0x9fbb))) {
            wordNum = !wordNum;
        }
        //中文
        if((character >= 0x4e00) && (character <= 0x9fbb)) {
            // 一个中文算2个长度
            //            characterLen += 2;
            characterLen += 1;
        }
        //英文
        else {
            //            characterLen += 1;
            characterLen += (wordNum ? 1 : 0 );
        }
    }
    return characterLen;
}


+ (NSString *)getStringWithString:(NSString *)textCount InRange:(NSInteger)index {
    
    // 字符串长度为空
    BOOL wordNum = YES;  //开关 单数开始计数,2个非中文字符计数-1
    
    NSInteger characterLen = 0;
    for(NSInteger i = 0; i < [textCount length]; i++) {
        unichar character = [textCount characterAtIndex:i];
        //改变开关状态
        if(!((character >= 0x4e00) && (character <= 0x9fbb))) {
            wordNum = !wordNum;
        }
        //中文
        if((character >= 0x4e00) && (character <= 0x9fbb)) {
            characterLen += 1;
        } else {
            characterLen += (wordNum ? 1 : 0 );
        }
        if (characterLen > index) {
            return [textCount substringToIndex: index];
        }
    }
    
    return textCount;
    
}

+ (BOOL)canNumberText:(NSString *)textCount maxTextCount:(NSInteger)maxtextCount {
    
    if((self == nil) || ([textCount length] == 0)) {
        return YES;
    }
    
    NSInteger characterLen = 0;
    for(NSInteger i = 0; i < [textCount length]; i++) {
        characterLen += 1;
    }
    
    if(characterLen <= maxtextCount) {
        return YES;
    }
    return NO;
}

+ (NSInteger)canNumberText:(NSString *)textCount maxNumberCount:(NSInteger)maxtextCount {
    
    NSInteger characterLen = 0;
    for(NSInteger i = 0; i < [textCount length]; i++) {
        characterLen += 1;
    }
    return characterLen;
}

+ (NSInteger)canNumberText:(NSString *)textCount {
    
    NSInteger characterLen = 0;
    for(NSInteger i = 0; i < [textCount length]; i++) {
        characterLen += 1;
    }
    return characterLen;
}

+ (BOOL)compareStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate {
    
    NSTimeInterval _startDate = [startDate timeIntervalSince1970]*1;
    NSTimeInterval _endDate = [endDate timeIntervalSince1970]*1;
    if (_startDate - _endDate > 0) {
        return YES;
    }
    return NO;
}


+ (NSString *)voucherNumberStr:(NSString *)voucherNumber {
    NSMutableString * numStr = [NSMutableString stringWithFormat:@"%@",voucherNumber];
    
    if ([numStr length] == 24) {
        [numStr replaceCharactersInRange:NSMakeRange(4, [numStr length]-4) withString:@"*******************"];
    }
    else if ([numStr length] == 27){
        [numStr replaceCharactersInRange:NSMakeRange(4, [numStr length]-4) withString:@"**********************"];
    }
    else if([numStr length] > 5){
        [numStr replaceCharactersInRange:NSMakeRange(4, [numStr length]-4) withString:@"**********"];
    }
    else{
        return voucherNumber;
    }
    return numStr;
    
}


+ (NSString *)replaceUniqeChars:(NSString *)string {
    
    string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"</br>" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    
    return string;
}

+ (BOOL) checkPhoto{
    
    // 是否在设置里面关闭了相机
    BOOL isCameraDeviceAvailable = YES;
    
    isCameraDeviceAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    isCameraDeviceAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    NSLog(@"%f",[[UIDevice currentDevice].systemVersion doubleValue]);
    
#ifdef __IPHONE_7_0
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus != AVAuthorizationStatusAuthorized) {
        isCameraDeviceAvailable = NO;
    }
#endif
    
    [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    return isCameraDeviceAvailable;
}

+ (NSString *)spaceTotalCache {
    
    long long kTmpSize = [SKCheckTool spaceefPath:kTmpPath];
    long long kCacheSize = [SKCheckTool spaceefPath:kCachPath];
    long long kDocSize = [SKCheckTool spaceefPath:kDocPath];
    
    NSString *kTotalSize = nil;
    CGFloat totalSize = kTmpSize +
    kDocSize + kCacheSize;
    if (totalSize/1024.0/1024.0/1024.0 > 1) {
        kTotalSize= [NSString stringWithFormat:@"%0.fG",totalSize/1024.0/1024.0/1024.0];
    } else {
        kTotalSize= [NSString stringWithFormat:@"%0.fMB",totalSize/1024.0/1024.0];
    }
    return kTotalSize;
}


+ (NSString *)freeDiskSpaceInBytes {
    
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/private/var", &buf) >= 0)
    {
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    
    if (freespace/1024.0/1024.0 > 1024) {
        return [NSString stringWithFormat:@"%0.fG",freespace/1024.0/1024.0/1024.0];
    } else {
        return [NSString stringWithFormat:@"%0.fMB",freespace/1024.0/1024.0];
    }
}

+ (BOOL)hasEnoughFreeSpace {
    
    NSString *spaceRemained = [SKCheckTool freeDiskSpaceInBytes];
    double spaceRemainedValue = 0.;// kb
    if([spaceRemained hasSuffix:@"MB"]) {
        spaceRemainedValue = [spaceRemained floatValue] * 1024;
    }
    if([spaceRemained hasSuffix:@"G"]) {
        spaceRemainedValue = [spaceRemained floatValue] * 1024 * 1024;
    }
    
    if(spaceRemainedValue <= 50*1024) {
        return NO;
    }
    return YES;
}


+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString {
    
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}
@end
