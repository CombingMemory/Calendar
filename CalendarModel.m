//
//  CalendarModel.m
//  测试程序
//
//  Created by 雨天记忆 on 16/9/6.
//  Copyright © 2016年 雨天记忆. All rights reserved.
//

#import "CalendarModel.h"

#define DAY_TIME 86400

@interface CalendarModel ()

@property (nonatomic, assign) NSInteger weekDay;

@end

@implementation CalendarModel

#pragma 初始化方法
- (instancetype)initWithDate:(NSDate *)date{
    if (date == nil) {
        return nil;
    }
    if ([super init]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone systemTimeZone];
        formatter.dateFormat = @"yyyy";
        //年份赋值
        _year = [formatter stringFromDate:date];
        formatter.dateFormat = @"MM";
        //月份赋值
        _month = [formatter stringFromDate:date];
        formatter.dateFormat = @"dd";
        //天数赋值
        _day = [formatter stringFromDate:date];
        //周几赋值
        formatter.dateFormat = @"e";
        _week = [self getWeekStringForInteger:[formatter stringFromDate:date].intValue];
        //data赋值。这个date保存的是当天的0点0分
        formatter.dateFormat = @"yyyyMMdd";
        _date = [formatter dateFromString:[_year stringByAppendingFormat:@"%@%@",_month,_day]];
        //农历赋值
        [self getChineseCalendarWithDate:date];
        //农历节假日
        _lunarHoliday = [self judgeLunarHoliday:[_lunarMonth stringByAppendingString:_lunarDay]];
        //阳历节日
        _dateHoliday = [self judgeDateHoliday:[_month stringByAppendingString:_day]];
        //判断Model是不是当天
        NSString *todayStr = [formatter stringFromDate:[NSDate date]];
        NSDate *todayDate = [formatter dateFromString:todayStr];
        if ([todayDate isEqualToDate:_date]) {
            self.type = CalendarTypeToday;
        }
    }
    return self;
}

#pragma mark 通过数字返回星期几
- (NSString *)getWeekStringForInteger:(NSInteger)week{
    NSString *str_week;
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    return str_week;
}

- (void)getChineseCalendarWithDate:(NSDate *)date{
    NSArray *chineseMonths = @[@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月"];
    NSArray *chineseDays = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十"];
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    _lunarMonth = [chineseMonths objectAtIndex:localeComp.month - 1];
    _lunarDay = [chineseDays objectAtIndex:localeComp.day - 1];
}

#pragma mark 判断阴历节日
- (NSString *)judgeLunarHoliday:(NSString *)lunar{
    NSString *lunarHoliday;
    if ([lunar isEqualToString:@"正月初一"]) {
        lunarHoliday = @"春节";
    }
    if ([lunar isEqualToString:@"正月十五"]) {
        lunarHoliday = @"元宵";
    }
    if ([lunar isEqualToString:@"二月初二"]) {
        lunarHoliday = @"龙抬头";
    }
    if ([lunar isEqualToString:@"五月初五"]) {
        lunarHoliday = @"端午节";
    }
    if ([lunar isEqualToString:@"七月初七"]) {
        lunarHoliday = @"七夕";
    }
    if ([lunar isEqualToString:@"八月十五"]) {
        lunarHoliday = @"中秋";
    }
    if ([lunar isEqualToString:@"九月初九"]) {
        lunarHoliday = @"重阳节";
    }
    if ([lunar isEqualToString:@"腊月初八"]) {
        lunarHoliday = @"腊八节";
    }
    if ([lunar isEqualToString:@"腊月廿三"]) {
        lunarHoliday = @"小年";
    }
    if ([lunar isEqualToString:@"腊月三十"]) {
        lunarHoliday = @"除夕";
    }
    return lunarHoliday;
}

#pragma mark 判断阳历节日
- (NSString *)judgeDateHoliday:(NSString *)date{
    NSString *dateHoloday;
    if ([date isEqualToString:@"0101"]) {
        dateHoloday = @"元旦";
    }
    if ([date isEqualToString:@"0214"]) {
        dateHoloday = @"情人节";
    }
    if ([date isEqualToString:@"0308"]) {
        dateHoloday = @"妇女节";
    }
    if ([date isEqualToString:@"0312"]) {
        dateHoloday = @"植树节";
    }
    if ([date isEqualToString:@"0401"]) {
        dateHoloday = @"愚人节";
    }
    if ([date isEqualToString:@"0501"]) {
        dateHoloday = @"劳动节";
    }
    if ([date isEqualToString:@"0601"]) {
        dateHoloday = @"儿童节";
    }
    if ([date isEqualToString:@"0801"]) {
        dateHoloday = @"建军节";
    }
    if ([date isEqualToString:@"0910"]) {
        dateHoloday = @"教师节";
    }
    if ([date isEqualToString:@"1001"]) {
        dateHoloday = @"国庆节";
    }
    if ([date isEqualToString:@"1111"]) {
        dateHoloday = @"光棍节";
    }
    if ([date isEqualToString:@"1224"]) {
        dateHoloday = @"平安夜";
    }
    if ([date isEqualToString:@"1225"]) {
        dateHoloday = @"圣诞节";
    }
    return dateHoloday;
}

#pragma mark 返回本月所有天数的model。外加缺省天数。（拼接上个月。和下个月的）
+ (NSMutableArray *)calendarsWithDate:(NSDate *)date{
    if (date == nil) {
        return nil;
    }
    //当月的第一天
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMM";
    formatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *nowStr = [formatter stringFromDate:date];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *firstDate = [formatter dateFromString:[nowStr stringByAppendingString:@"01"]];
    NSTimeInterval time = [firstDate timeIntervalSince1970];
    //年份
    formatter.dateFormat = @"yyyy";
    int year = [formatter stringFromDate:date].intValue;
    //月份
    formatter.dateFormat = @"MM";
    int month = [formatter stringFromDate:date].intValue;
    //算出来这个月有多少天
    NSUInteger monthDays = [self monthDaysForYear:year month:month];
    //周几
    formatter.dateFormat = @"e";
    NSInteger weekDay = [formatter stringFromDate:date].integerValue;
    
    //算出这个月第一天（并不一定是1号。假如1号不是这个月的顶头显示，会去拼接上个月缺省的几天）
    NSTimeInterval firstTime = time - (weekDay - 1) * DAY_TIME;
    //本月的总天数。外加缺省的天数
    NSUInteger monthDefaultDays = [self monthDefaultDaysForMonthDays:monthDays weekDay:weekDay];
    
    //因为项目需求更改。每个月的的天数都会一样
    monthDefaultDays = 42;
    
    
    //数组初始化
    NSMutableArray *dateArray = [NSMutableArray arrayWithCapacity:monthDefaultDays];
    for (int i = 0; i < monthDefaultDays; i++) {
        CalendarModel *model = [[CalendarModel alloc] initWithDate:[NSDate dateWithTimeIntervalSince1970:firstTime]];
        //标记出来并不是本月的天数
        if (i < weekDay - 1 || i >= weekDay - 1 + monthDays) {
            if (i < weekDay - 1) {
                model.type = CalendarTypeOld;
            }else{
                model.type = CalendarTypeLast;
            }
        }
        firstTime += DAY_TIME;
        [dateArray addObject:model];
    }
    return dateArray;
}

#pragma mark 计算出当月有多少天
+ (NSUInteger)monthDaysForYear:(int)year month:(int)month{
    if ((year % 4 == 0 || year % 400 == 0) && year % 100 != 0) {
        if (month == 2) {
            return 29;
        }
    }else{
        if (month == 2) {
            return 28;
        }
    }
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        break;
        default:
            return 30;
            break;
    }
}

#pragma mark 计算这个月加上缺省的天数，总共多少天。
//monthDays 这个月本应该有多少天
//weekDay 这个月第一天是周几
+ (NSUInteger)monthDefaultDaysForMonthDays:(NSUInteger)monthDays weekDay:(NSInteger)weekDay{
    NSUInteger count = monthDays + weekDay - 1;
    NSUInteger row = count / 7;
    row = count % 7?row + 1:row;
    return row * 7;
}

+ (NSUInteger)monthDefaultDaysForMonthDays:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    //年份
    formatter.dateFormat = @"yyyy";
    int year = [formatter stringFromDate:date].intValue;
    //月份
    formatter.dateFormat = @"MM";
    int month = [formatter stringFromDate:date].intValue;
    //算出来这个月有多少天
    NSUInteger monthDays = [self monthDaysForYear:year month:month];
    //周几
    formatter.dateFormat = @"e";
    NSInteger weekDay = [formatter stringFromDate:date].integerValue;
    return [self monthDefaultDaysForMonthDays:monthDays weekDay:weekDay];
}

@end
