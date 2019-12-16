//
//  SKZodiacChartModel.h
//  SKNewsProject
//
//  Created by shavekevin on 2017/8/15.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKZodiacChartModel : NSObject
// 公历日期
@property (nonatomic, copy) NSString *gongli;
//  nongli	String	二零一五年 三月(小)初五	农历日期
@property (nonatomic, copy) NSString *nongli;
// ganzhi	String	乙未年 庚辰月 己巳日	干支
@property (nonatomic, copy) NSString *ganzhi;
//  nayin	String	[年]砂石金 [月]白腊金 [日]大林木	纳音
@property (nonatomic, copy) NSString *nayin;
//  shengxiao	String	属羊	生肖
@property (nonatomic, copy) NSString *shengxiao;
// xingzuo	String	金牛座	星座
@property (nonatomic, copy) NSString *xingzuo;
// sheng12	String	除执位	十二神
@property (nonatomic, copy) NSString *sheng12;
// zhiri	String	明堂(黄道日)	值日
@property (nonatomic, copy) NSString *zhiri;
//chongsha	String	冲猪[正冲癸亥]煞东	冲煞
@property (nonatomic, copy) NSString *chongsha;
//  tszf	String	占门床外正南	胎神吉方
@property (nonatomic, copy) NSString *tszf;
// pzbj	String	己不破券二比并亡 巳不远行财物伏藏	彭祖百忌
@property (nonatomic, copy) NSString *pzbj;
// jrhh	String	今日与属鸡半三合，与属猴六合，与属猪相冲，与属虎相害，与属虎属猴相刑。	今日合害
@property (nonatomic, copy) NSString *jrhh;
// yi	String	结婚 祭祀 祈福	宜
@property (nonatomic, copy) NSString *yi;
// ji	String	开光 掘井 开仓	忌
@property (nonatomic, copy) NSString *ji;
// jsyq	String	月德 天恩	吉神宜趋
@property (nonatomic, copy) NSString *jsyq;
// jieqi24	String	清明：4月5日	24节气
@property (nonatomic, copy) NSString *jieqi24;
// jieri	String	公历节日: 世界图书和版权日	节日
@property (nonatomic, copy) NSString *jieri;
//  t23	String	\r\n 吉凶：吉\r\n 时柱：乙丑(海中金)\r\n 冲煞：冲羊煞东\r\n 正冲	子时 23-1
@property (nonatomic, copy) NSString *t23;
// t1	String		丑时 1-3
@property (nonatomic, copy) NSString *t1;
//t3	String		寅时 3-5
@property (nonatomic, copy) NSString *t3;
//t5	String		卯时 5-7
@property (nonatomic, copy) NSString *t5;
//t7	String		辰时 7-9
@property (nonatomic, copy) NSString *t7;
//t9	String		巳时 9-11
@property (nonatomic, copy) NSString *t9;
//t11	String		午时 11-13
@property (nonatomic, copy) NSString *t11;
//t13	String		未时 13-15
@property (nonatomic, copy) NSString *t13;
//t15	String		申时 15-17
@property (nonatomic, copy) NSString *t15;
//t17	String		酉时 17-19

@property (nonatomic, copy) NSString *t17;
//t19	String		戌时 19-21
@property (nonatomic, copy) NSString *t19;
//t21	String		亥时 21-23
@property (nonatomic, copy) NSString *t21;



@end
