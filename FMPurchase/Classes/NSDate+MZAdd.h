
#import <Foundation/Foundation.h>



#pragma mark - 时间格式
#define kDateFormatDefault     @"yyyy-MM-dd HH:mm:ss"
#define kDateFormat_yyMdHm     @"yy-MM-dd HH:mm"
#define kDateFormat_yyyyMdHm   @"yyyy-MM-dd HH:mm"
#define kDateFormat_yMd        @"yyyy-MM-dd"
#define kDateFormat_MdHms      @"MM-dd HH:mm:ss"
#define kDateFormat_MdHm       @"MM-dd HH:mm"
#define kDateFormat_MdHm1      @"MM/dd HH:mm"
#define kDateFormatTime        @"HH:mm:ss"
#define kDateFormat_Hm         @"HH:mm"
#define kDateFormat_Md         @"MM-dd"
#define kDateFormat_yyMd       @"yy-MM-dd"
#define kDateFormat_YYMMdd     @"yyyyMMdd"
#define kDateFormat_yyyyMdHms  @"yyyyMMddHHmmss"
#define kDateFormat_yyyyMMddHHmmssSSS   @"yyyy-MM-dd HH:mm:ss.SSS"
#define kDateFormat_yyyyMdHm_ForPoint   @"yyyy.MM.dd HH:mm"
#define kDateFormat_yyyyMMddHHmm        @"yyyy/MM/dd HH:mm"
#define KDateFormat_yyyy @"yyyy"
#define kDateFormat_M_dHm @"MM月dd HH:mm"
#define kDateFormat_MdE @"MM-dd EE"
#define kDateFormat_E_Md @"EE HH:mm"
#define kDateFormat_M_yyyy @"MM'月 'yyyy"
#define kDateFormat_yMd_Hm_E @"yyyy年MM月dd HH:mm EE"
 


static NSString * const FORMAT_PAST_SHORT = @"yyyy/MM/dd";
static NSString * const FORMAT_PAST_TIME = @"ahh:mm";
static NSString * const FORMAT_THIS_WEEK = @"eee ahh:mm";
static NSString * const FORMAT_THIS_WEEK_SHORT = @"eee";
static NSString * const FORMAT_YESTERDAY = @"ahh:mm";
static NSString * const FORMAT_TODAY = @"ahh:mm";

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Additions)



+ (NSDate *)dateFromInterval:(NSTimeInterval)timeInterval;



+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval;


+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval withFormat:(NSString*)format;


+ (NSString *)formatDate:(NSDate *)date withFormat:(NSString*)format;


+ (NSDate *)dateFromStr:(NSString *)str withFormat:(NSString*)format;


- (NSDate *)dateNextDay:(NSInteger)spaceDay;



+ (NSString *)formatYTTWithDateComponents:(NSDateComponents *)components;

+ (NSString *)formatYTTWithDate:(NSDate *)date;


- (long long)longlongTimeIntervalSince1970;


+ (NSString *)formatTimerCount:(NSInteger)timerCount;
+ (NSString *)timeFormat:(NSInteger)waitTime;


+ (NSString *)timeStampSince1970WithDefalutFormatTimeString:(NSString *)timeString;


+ (NSString *)timeStampSince1970WithString:(NSString *)timeString withFormat:(NSString*)format;



- (NSInteger)weekdayOfFirstDayInDate;



- (NSDate *)dateFormatYMD000000;


- (NSDate *)dateFormatYMD235959;


+ (NSInteger)compareWithDate1:(NSDate *)date1 date2:(NSDate *)date2;




- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;


- (NSUInteger)daysInYear;
+ (NSUInteger)daysInYear:(NSDate *)date;


- (BOOL)isLeapYear;
+ (BOOL)isLeapYear:(NSDate *)date;


- (NSUInteger)weekOfYear;
+ (NSUInteger)weekOfYear:(NSDate *)date;


- (NSString *)formatYMD;
+ (NSString *)formatYMD:(NSDate *)date;


- (NSUInteger)weeksOfMonth;
+ (NSUInteger)weeksOfMonth:(NSDate *)date;


- (NSDate *)begindayOfMonth;
+ (NSDate *)begindayOfMonth:(NSDate *)date;


- (NSDate *)lastdayOfMonth;
+ (NSDate *)lastdayOfMonth:(NSDate *)date;


- (NSDate *)dateAfterDay:(NSUInteger)day;
+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day;


- (NSDate *)dateAfterMonth:(NSUInteger)month;
+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month;


- (NSDate *)offsetYears:(int)numYears;
+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate;


- (NSDate *)offsetMonths:(int)numMonths;
+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;


- (NSDate *)offsetDays:(int)numDays;
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate;


- (NSDate *)offsetHours:(int)hours;
+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate;


- (NSUInteger)daysAgo;
+ (NSUInteger)daysAgo:(NSDate *)date;


- (NSInteger)weekday;
+ (NSInteger)weekday:(NSDate *)date;


- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;


- (BOOL)isSameDay:(NSDate *)anotherDate;


- (BOOL)isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isThisWeek;

- (NSDate *)dateByAddingDays:(NSUInteger)days;


+ (NSString *)monthWithMonthNumber:(NSInteger)month;


+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;


- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;


- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;


- (NSString *)timeInfo;
+ (NSString *)timeInfoWithDate:(NSDate *)date;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;


- (NSString *)ymdFormat;
- (NSString *)hmsFormat;
- (NSString *)ymdHmsFormat;
+ (NSString *)ymdFormat;
+ (NSString *)hmsFormat;
+ (NSString *)ymdHmsFormat;


+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number withFormatter:(NSString *)formatter;


+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number;


+(NSString *)getTimeWithNumberDaysLater:(NSUInteger)datys andEndHourTime:(NSString *)endTime;


+(NSDate *)getTimeWithDateString:(NSString *)dateString andEndHourTime:(NSString *)endTime;


+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;


+ (NSInteger)numberOfMonthsWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSDateComponents *)dateComponentsYearsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSDateComponents *)dateComponentsUntilSecondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSInteger)secondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

+ (NSInteger)numberOfHourWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;


+ (NSDate *)dateFormateWithYDate:(NSDate *)yDate hDate:(NSDate *)hDate;


+ (NSArray *)getAllWeekTillDate:(NSDate *)tillDate;

+ (NSString *)getWeekTime;


+ (NSDate *)getLocalDateFormatAnyDate:(NSDate *)anyDate;

+ (NSString *)time_timestampToString:(NSInteger)timestamp;

@end
