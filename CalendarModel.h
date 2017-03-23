//
//  CalendarModel.h
//  测试程序
//
//  Created by 雨天记忆 on 16/9/6.
//  Copyright © 2016年 雨天记忆. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CalendarType) {
    CalendarTypeNormal, //普通状态
    CalendarTypeOld,    //不显示(表示不是本月的日期，空余补充上个月的)
    CalendarTypeLast,   //不显示(表示不是本月的日期，空余补充下个月的)
    CalendarTypeToday   //代表是今天
};

@interface CalendarModel : NSObject

@property (nonatomic, assign) CalendarType type;//日历的样式

@property (nonatomic, strong ,readonly) NSString *day;//天
@property (nonatomic, strong ,readonly) NSString *month;//月
@property (nonatomic, strong ,readonly) NSString *year;//年
@property (nonatomic, strong ,readonly) NSString *week;//周
@property (nonatomic, strong ,readonly) NSString *lunarMonth;//农历月
@property (nonatomic, strong ,readonly) NSString *lunarDay;//农历日
@property (nonatomic, strong ,readonly) NSString *lunarHoliday;//农历节日
@property (nonatomic, strong ,readonly) NSString *dateHoliday;//阳历节日
@property (nonatomic, strong ,readonly) NSDate *date;//返回该Model的NSDate对象

//返回当天的对象
- (instancetype)initWithDate:(NSDate *)date;

//返回当天该月份的对象
+ (NSMutableArray *)calendarsWithDate:(NSDate *)date;

//返回当月有多少天
+ (NSUInteger)monthDaysForYear:(int)year month:(int)month;

//返回当月有多少天。外加缺省天数
+ (NSUInteger)monthDefaultDaysForMonthDays:(NSDate *)date;



//自己使用另外添加的对象
//上午档期的内容
@property (nonatomic, strong) NSString *am;
//下午档期的内容
@property (nonatomic, strong) NSString *pm;
//上午档期的ID
@property (nonatomic, strong) NSNumber *amID;
//下午档期的ID
@property (nonatomic, strong) NSNumber *pmID;

@end
