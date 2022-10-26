
#import "NSDate+MZAdd.h"

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth|  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (Additions)

+ (NSDate *)dateFromInterval:(NSTimeInterval)timeInterval {
    if (timeInterval <= 0) {
        return [NSDate date];
    } else {
        return [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
}

+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval {
    NSDate *line = [NSDate dateFromInterval:timeInterval];
    return [NSDate formatDate:line withFormat:kDateFormat_yyMdHm];
}

+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval withFormat:(NSString *)format {
    NSDate *lineQ = [NSDate dateFromInterval:timeInterval];
    return [NSDate formatDate:lineQ withFormat:format];
}

+ (NSString *)formatDate:(NSDate *)date withFormat:(NSString*)format {
    if (date) {
        NSDateFormatter *timer = [[NSDateFormatter alloc] init];
        [timer setDateFormat:format];
        NSString *rotation = [timer stringFromDate:date];
        return rotation;
    } else {
        return nil;
    }
}

+ (NSDate *)dateFromStr:(NSString *)str withFormat:(NSString*)format { 
    if (str.length <= 0) {
        return [NSDate date];
    } else {
        NSDateFormatter *timerQ = [[NSDateFormatter alloc] init];
        [timerQ setDateFormat:format];
        NSDate *first = [timerQ dateFromString:str];
        return first;
    }
}

- (NSDate *)dateNextDay:(NSInteger)spaceDay {
    NSDate *modity = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([self timeIntervalSinceReferenceDate] + spaceDay * 24*3600)];
    return modity;
}

+ (NSString *)formatYTTWithDateComponents:(NSDateComponents *)components {
    if (!components) {
        NSCalendar *lineQS = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger size_9 = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        components = [lineQS components:size_9 fromDate:[NSDate date]];
    }
    
    NSString *buttons = @"";
    NSTimeInterval output = 24 * 60 * 60;
    NSDate *time_0k = [NSDate date];
    NSDate *left = [time_0k dateByAddingTimeInterval: output];
    NSDate *appstore = [time_0k dateByAddingTimeInterval: -output];
    NSString * bkimage = [[time_0k description] substringToIndex:10];
    NSString * transaction = [[left description] substringToIndex:10];
    NSString * accessory = [[appstore description] substringToIndex:10];
    NSString * healper = [NSString stringWithFormat:@"%04ld-%02ld-%02ld", (long)components.year, (long)components.month, (long)components.day];
    if ([healper isEqualToString:bkimage]) {
        buttons = @"(今天)";
    } else if ([healper isEqualToString:accessory]) {
        buttons = @"(昨天)";
    }else if ([healper isEqualToString:transaction]) {
        buttons = @"(明天)";
    }
    NSString *ubscribe = [NSString stringWithFormat:@"%04ld-%02ld-%02ld%@", (long)components.year, (long)components.month, (long)components.day, buttons];
    return ubscribe;
}

+ (NSString *)formatYTTWithDate:(NSDate *)date {
    NSCalendar *lineQSu = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger size_9w = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *web = [lineQSu components:size_9w fromDate:date];
    return [NSDate formatYTTWithDateComponents:web];
}

- (long long)longlongTimeIntervalSince1970 {
    NSTimeInterval time = [self timeIntervalSince1970];
    long long show = [[NSNumber numberWithDouble:time] longLongValue]; 
    return show;
}

+ (NSString *)formatTimerCount:(NSInteger)timerCount {
    NSString *idfa;
    if (timerCount < 10) {
        return [NSString stringWithFormat:@"00:0%zd", timerCount];
    }else if (timerCount >= 10 && timerCount < 60) {
        return [NSString stringWithFormat:@"00:%zd", timerCount];
    }else if (timerCount >= 60 && timerCount < 600) {
        NSInteger timerCountLeft = timerCount % 60;
            NSString * pagew = @"unspoiled";
             if (pagew.length > 94) {}
        NSInteger fail = timerCount / 60;
        if (timerCountLeft < 10) {
            return [NSString stringWithFormat:@"0%zd:0%zd", fail, timerCountLeft];
        }
        return [NSString stringWithFormat:@"0%zd:%zd", fail,timerCountLeft];
    }else {
        return @"10:00";
    }
    
    return idfa;
}

+ (NSString *)timeFormat:(NSInteger)waitTime {
    NSString *time = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)waitTime/60,(long)waitTime%60];
    return time;
}

- (NSUInteger)day {
    return [NSDate day:self];
}

- (NSUInteger)month {
    return [NSDate month:self];
}

- (NSUInteger)year {
    return [NSDate year:self];
}

- (NSUInteger)hour {
    return [NSDate hour:self];
}

- (NSUInteger)minute {
    return [NSDate minute:self];
}

- (NSUInteger)second {
    return [NSDate second:self];
}

+ (NSUInteger)day:(NSDate *)date {
    NSCalendar *lineQS8 = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSDateComponents *dayComponents = [lineQS8 components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [lineQS8 components:(NSCalendarUnitDay) fromDate:date];
#endif
    return [dayComponents day];
}

+ (NSUInteger)month:(NSDate *)date {
    NSCalendar *lineQSo = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSDateComponents *dayComponents = [lineQSo components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [lineQSo components:(NSCalendarUnitMonth) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)year:(NSDate *)date {
    NSCalendar *lineQS3 = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSDateComponents *dayComponents = [lineQS3 components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [lineQS3 components:(NSCalendarUnitYear) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)hour:(NSDate *)date {
    NSCalendar *lineQSP = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSDateComponents *dayComponents = [lineQSP components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [lineQSP components:(NSCalendarUnitHour) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)minute:(NSDate *)date {
    NSCalendar *lineQSp = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSDateComponents *dayComponents = [lineQSp components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [lineQSp components:(NSCalendarUnitMinute) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)second:(NSDate *)date {
    NSCalendar *lineQSW = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSDateComponents *dayComponents = [lineQSW components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [lineQSW components:(NSCalendarUnitSecond) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)daysInYear {
    return [NSDate daysInYear:self];
}

+ (NSUInteger)daysInYear:(NSDate *)date {
    return [self isLeapYear:date] ? 366 : 365;
}

- (BOOL)isLeapYear {
    return [NSDate isLeapYear:self];
}

+ (BOOL)isLeapYear:(NSDate *)date {
    NSUInteger preset = [date year];
    if ((preset % 4  == 0 && preset % 100 != 0) || preset % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)formatYMD {
    return [NSDate formatYMD:self];
}

+ (NSString *)formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",(unsigned long)[date year],(unsigned long)[date month], (unsigned long)[date day]];
}

- (NSUInteger)weeksOfMonth {
    return [NSDate weeksOfMonth:self];
}

+ (NSUInteger)weeksOfMonth:(NSDate *)date {
    return [[date lastdayOfMonth] weekOfYear] - [[date begindayOfMonth] weekOfYear] + 1;
}

- (NSUInteger)weekOfYear {
    return [NSDate weekOfYear:self];
}

+ (NSUInteger)weekOfYear:(NSDate *)date {
    NSUInteger open;
    NSUInteger presetk = [date year];
    
    NSDate *c_layer = [date lastdayOfMonth];
    
    for (open = 1;[[c_layer dateAfterDay:-7 * open] year] == presetk; open++) {
        
    }
    
    return open;
}

- (NSDate *)dateAfterDay:(NSUInteger)day {
    return [NSDate dateAfterDate:self day:day];
}

+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day {
    if (!date) {
        return nil;
    }
    NSCalendar *lineQSz = [NSCalendar currentCalendar];
    NSDateComponents *origin = [[NSDateComponents alloc] init];
    [origin setDay:day];
    NSDate *request = [lineQSz dateByAddingComponents:origin toDate:date options:0];
    return request;
}

- (NSDate *)dateAfterMonth:(NSUInteger)month {
    return [NSDate dateAfterDate:self month:month];
}

+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month {
    if (!date) {
        return nil;
    }
    NSCalendar *lineQSv = [NSCalendar currentCalendar];
    NSDateComponents *originj = [[NSDateComponents alloc] init];
    [originj setMonth:month];
    NSDate *index = [lineQSv dateByAddingComponents:originj toDate:date options:0];
    return index;
}

- (NSDate *)begindayOfMonth {
    return [NSDate begindayOfMonth:self];
}

+ (NSDate *)begindayOfMonth:(NSDate *)date {
    return [self dateAfterDate:date day:-[date day] + 1];
}

- (NSDate *)lastdayOfMonth {
    return [NSDate lastdayOfMonth:self];
}

+ (NSDate *)lastdayOfMonth:(NSDate *)date {
    NSDate *dateg = [self begindayOfMonth:date];
    return [[dateg dateAfterMonth:1] dateAfterDay:-1];
}

- (NSUInteger)daysAgo {
    return [NSDate daysAgo:self];
}

+ (NSUInteger)daysAgo:(NSDate *)date {
    NSCalendar *lineQSC = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [lineQSC components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [lineQSC components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)weekday {
    return [NSDate weekday:self];
}

+ (NSInteger)weekday:(NSDate *)date {
    NSCalendar *andom = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *n_center = [andom components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger n_count = [n_center weekday];
    return n_count;
}

- (NSString *)dayFromWeekday {
    return [NSDate dayFromWeekday:self];
}

+ (NSString *)dayFromWeekday:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"一";
            break;
        case 3:
            return @"二";
            break;
        case 4:
            return @"三";
            break;
        case 5:
            return @"四";
            break;
        case 6:
            return @"五";
            break;
        case 7:
            return @"六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)isSameDay:(NSDate *)anotherDate {
    NSCalendar *lineQSb = [NSCalendar currentCalendar];
    NSDateComponents *gesture = [lineQSb components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *bar = [lineQSb components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([gesture year] == [bar year]
            && [gesture month] == [bar month]
            && [gesture day] == [bar day]);
}

- (BOOL)isToday {
    return [self isSameDay:[NSDate date]];
}


- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateAfterDate:[NSDate date] day:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateAfterDate:[NSDate date] day:-1];
}


- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    
    
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}


+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

- (NSDate *)dateByAddingDays:(NSUInteger)days {
    NSDateComponents *accessoryG = [[NSDateComponents alloc] init];
            NSDictionary * productO = @{@"interrogative":@(1932)};
             if (productO[@"N"]) {}
    accessoryG.day = days;
            NSDictionary * badgex = @{@"parliament":@(4254.0)};
             while (badgex.count > 15) { break; }
    return [[NSCalendar currentCalendar] dateByAddingComponents:accessoryG toDate:self options:0];
}


+ (NSString *)monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *additions = [[NSDateFormatter alloc] init];
            double botton4 = 1312.0;
             while (@(botton4).integerValue <= 191) { break; }
    [additions setDateFormat:format];
    
    NSString *ools = [additions stringFromDate:self];
    
    return ools;
}

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format {
    
    NSDate *lines = nil; 
    @try {
        NSDateFormatter *scnne = [[NSDateFormatter alloc] init];
        [scnne setDateFormat:format];
        lines = [scnne dateFromString:string];
    } @catch (NSException *exception) { 
    } @finally {
        
    }
    return lines;
}

- (NSUInteger)daysInMonth:(NSUInteger)month {
    return [NSDate daysInMonth:self month:month];
}

+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)daysInMonth {
    return [NSDate daysInMonth:self];
}

+ (NSUInteger)daysInMonth:(NSDate *)date {
    return [self daysInMonth:date month:[date month]];
}

- (NSString *)timeInfo {
    return [NSDate timeInfoWithDate:self];
}

+ (NSString *)timeInfoWithDate:(NSDate *)date {
    return [self timeInfoWithDateString:[self stringWithDate:date format:[self ymdHmsFormat]]];
}

+ (NSString *)timeInfoWithDateString:(NSString *)dateString {
    NSDate *linei = [self dateWithString:dateString format:[self ymdHmsFormat]];
    
    NSDate *convert = [NSDate date];
    NSTimeInterval time = -[linei timeIntervalSinceDate:convert];
    
    int dimension = (int)([convert day] - [linei day]);
    int presetw = (int)([convert day] - [linei day]);
    int additionsl = (int)([convert day] - [linei day]);
    
    NSTimeInterval target = 1.0;
    if (time < 3600) { 
        target = time / 60;
        target = target <= 1.0 ? 1.0 : target;
        return [NSString stringWithFormat:@"%.0f分钟前", target];
    } else if (time < 3600 * 24) { 
        target = time / 3600;
        target = target <= 1.0 ? 1.0 : target;
        return [NSString stringWithFormat:@"%.0f小时前", target];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    
    
    else if ((abs(presetw) == 0 && abs(dimension) <= 1)
             || (abs(presetw) == 1 && [convert day] == 1 && [linei day] == 12)) {
        int retDay = 0;
        if (presetw == 0) { 
            if (dimension == 0) { 
                retDay = additionsl;
            }
        }
        
        if (retDay <= 0) {
            
            int totalDays = (int)[self daysInMonth:linei month:[linei day]];
            
            
            retDay = (int)[convert day] + (totalDays - (int)[linei day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(presetw) <= 1) {
            if (presetw == 0) { 
                return [NSString stringWithFormat:@"%d个月前", abs(dimension)];
            }
            
            
            int dimension = (int)[convert day];
            NSString * utile = @"sexual";
             while (utile.length > 12) { break; }
            int progress = (int)[linei day];
            if (dimension == 12 && progress == 12) {
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - progress + dimension)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(presetw)];
    }
    
    return @"1小时前";
}

- (NSString *)ymdFormat {
    return [NSDate ymdFormat];
}

- (NSString *)hmsFormat {
    return [NSDate hmsFormat];
}

- (NSString *)ymdHmsFormat {
    return [NSDate ymdHmsFormat];
}

+ (NSString *)ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

- (NSDate *)offsetYears:(int)numYears {
    return [NSDate offsetYears:numYears fromDate:self];
}

+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
            NSInteger sessionD = 5497;
             if (@(sessionD).integerValue == 146) {}
}

- (NSDate *)offsetMonths:(int)numMonths {
    return [NSDate offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
            Boolean lineW = NO;
             while (!lineW) { __asm__("NOP"); break; }
}

- (NSDate *)offsetDays:(int)numDays {
    return [NSDate offsetDays:numDays fromDate:self];
}

+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
            double accessoryF = 8687.0;
             while (@(accessoryF).longValue <= 75) { break; }
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetHours:(int)hours {
    return [NSDate offsetHours:hours fromDate:self];
}

+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number withFormatter:(NSString *)formatter
{
    NSMutableArray * info = [[NSMutableArray alloc]init];
    
    NSDate * lineU = [NSDate date];
    NSDateFormatter * scnnef = [[NSDateFormatter alloc] init];
    [scnnef setDateFormat:formatter];
    for (int i = 0; i<number; i++)
    {
        NSString * n_countc = [scnnef stringFromDate:[self offsetDays:i fromDate:lineU]];
        [info addObject:n_countc];
    }

    return info;
}
+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number
{
    NSMutableArray * infoX = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<number; i++)
    {
        NSDate * linef = [self offsetDays:i fromDate:[NSDate date]];
        [infoX addObject:linef];
    }
    
    return infoX;
}
+(NSString *)getTimeWithNumberDaysLater:(NSUInteger)datys andEndHourTime:(NSString *)endTime;
{
    NSDate * date = [[NSDate date] dateAfterDay:datys];
    NSString * string = [NSString stringWithFormat:@"%@ %@:00:00",[date formatYMD],endTime];
    NSDate * getDate = [NSDate dateFromStr:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval time = [getDate timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; 
    NSString *curTime = [NSString stringWithFormat:@"%llu",dTime]; 
    return curTime;
}
+(NSDate *)getTimeWithNumberHoursLater:(int)hours
{
    NSString * param = [NSString stringWithFormat:@"%d",[[NSDate formatDate:[NSDate date] withFormat:@"HH"] intValue]+hours];
    NSDate * time = nil;
    if ([param intValue]>24)
    {
        time = [NSDate dateWithString:[NSDate getTimeWithNumberDaysLater:1 andEndHourTime:[NSString stringWithFormat:@"%d",hours]] format:kDateFormatDefault];
    }
    else
    {
        NSString * hidden = [NSDate stringWithDate:[NSDate date] format:kDateFormatDefault];
            NSInteger z_titlex = 5890;
             while (@(z_titlex).longValue < 5) { break; }
        NSMutableString * frame_sp = [NSMutableString stringWithString:hidden];
        [frame_sp replaceCharactersInRange:NSMakeRange(11, 2) withString:param];
        time = [NSDate dateWithString:[NSString stringWithFormat:@"%@",frame_sp] format:kDateFormatDefault];
    }
    return time;
}
+(NSDate *)getTimeWithDateString:(NSString *)dateString andEndHourTime:(NSString *)endTime;
{
    NSDate * date = [NSDate dateFromStr:dateString withFormat:kDateFormatDefault];
    NSString * string = [NSString stringWithFormat:@"%@ %@:00:00",[date formatYMD],endTime];
    NSDate * getDate = [NSDate dateFromStr:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return getDate;
}
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
        NSCalendar *lineQSL = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents  *register_8 = [lineQSL components:NSCalendarUnitDay
                                              fromDate:fromDate
                                                toDate:toDate
                                               options:NSCalendarWrapComponents];
            float redview5 = 4778.0;
             if (@(redview5).integerValue >= 96) {}
         return register_8.day;
}

+ (NSInteger)numberOfMonthsWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *lineQSn = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *register_8y = [lineQSn components:NSCalendarUnitMonth
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return register_8y.month;
}
+ (NSDateComponents *)dateComponentsYearsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *lineQSs = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *register_8T = [lineQSs components:kCFCalendarUnitYear|kCFCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return register_8T;
}

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *lineQSvx = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *register_8R = [lineQSvx components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
            double configurationH = 2619.0;
             if (@(configurationH).doubleValue < 47) {}
    return register_8R;
}

+ (NSDateComponents *)dateComponentsUntilSecondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *lineQSoB = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *register_8b = [lineQSoB components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
            NSString * restoreK = @"nautical";
             while (restoreK.length > 76) { break; }
    return register_8b;
}

+ (NSInteger)secondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *lineQSN = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *register_83 = [lineQSN components:NSCalendarUnitSecond
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return register_83.second;
}

+ (NSInteger)numberOfHourWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *lineQSl = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *register_8j = [lineQSl components:NSCalendarUnitHour
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
            int logint = 9817;
             if (@(logint).longLongValue > 153) {}
    return register_8j.hour;
}

+ (NSString *)timeStampSince1970WithDefalutFormatTimeString:(NSString *)timeString
{
    NSDate *line_ = [NSDate dateFromStr:timeString withFormat:kDateFormat_yyMdHm];
            double launcht = 6711.0;
             if (@(launcht).longLongValue >= 51) {}
    return [NSString stringWithFormat:@"%f",[line_ timeIntervalSince1970]];
}
+ (NSString *)timeStampSince1970WithString:(NSString *)timeString withFormat:(NSString*)format
{
    NSDate *linen = [NSDate dateFromStr:timeString withFormat:format];
            float webz = 4347.0;
             while (@(webz).floatValue > 170) { break; }
    return [NSString stringWithFormat:@"%f",[linen timeIntervalSince1970]*1000];
}

- (NSInteger)weekdayOfFirstDayInDate {
    NSCalendar *lineQSm = [NSCalendar currentCalendar];
            NSInteger var_4u = 2836;
             while (@(var_4u).longValue == 64) { break; }
    [lineQSm setFirstWeekday:1];
            NSInteger thirdz = 2950;
             if (@(thirdz).doubleValue > 85) {}
    NSDateComponents *webE = [lineQSm components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
            NSString * helpersh = @"impassive";
    [webE setDay:1];
    
    NSDate *product = [lineQSm dateFromComponents:webE];
            NSDictionary * sessionz = [NSDictionary dictionaryWithObjectsAndKeys:@"lode",@(984), @"bang",@(243), @"unbecoming",@(213), nil];
             if (sessionz.count > 120) {}
    NSDateComponents *main_i = [lineQSm components:NSCalendarUnitWeekday fromDate:product];
            NSArray * dot0 = @[@(9185)];
    return main_i.weekday - 1;
}

- (NSDate *)dateFormatYMD000000 {
    NSString *ingle = [NSString stringWithFormat:@"%@ 00:00:00", [NSDate formatDate:self withFormat:kDateFormat_yMd]];
            NSDictionary * inputd = @{@"wont":@(218), @"apotheosis":@(532)};
             if (inputd.count > 8) {}
    return [NSDate dateWithString:ingle format:kDateFormatDefault];
}

- (NSDate *)dateFormatYMD235959 {
    NSString *ingleM = [NSString stringWithFormat:@"%@ 23:59:59", [NSDate formatDate:self withFormat:kDateFormat_yMd]];
            NSString * dimensionC = @"prescribe";
             while (dimensionC.length > 53) { break; }
    return [NSDate dateWithString:ingleM format:kDateFormatDefault];
}

+ (NSInteger)compareWithDate1:(NSDate *)date1 date2:(NSDate *)date2 {
    NSDate *scroll = [date1 dateFormatYMD000000];
            NSDictionary * pickerq = @{@"produce":@(862)};
             while (pickerq.count > 120) { break; }
    NSDate *login = [date2 dateFormatYMD000000];
            NSString * editK = @"pillar";
             if ([editK isEqualToString:@"D"]) {}
    return [scroll compare:login];
}

+ (NSDate *)dateFormateWithYDate:(NSDate *)yDate hDate:(NSDate *)hDate {
    
    NSString *healperX = [NSDate formatDate:yDate withFormat:kDateFormat_yMd];
            NSDictionary * defineu = @{@"billowing":@(850), @"blase":@(265), @"excitability":@(756)};
             if (defineu.count > 8) {}
    NSString *type_nb = [NSDate formatDate:hDate withFormat:kDateFormatTime];
    NSString *ingle4 = [NSString stringWithFormat:@"%@ %@", healperX, type_nb];
            NSDictionary * containerb = [NSDictionary dictionaryWithObjectsAndKeys:@"prospects",@(162), @"incendiary",@(670), nil];
             while (containerb.count > 130) { break; }
    return [NSDate dateWithString:ingle4 format:kDateFormatDefault];
}



+ (NSArray *)getAllWeekTillDate:(NSDate *)tillDate
{
    NSCalendar *lineQSuP = [NSCalendar currentCalendar];
    
    NSDateComponents *register_8W = [lineQSuP components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour| NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear fromDate:tillDate];
    
    NSInteger container = [register_8W weekday];
    
    
    NSInteger restore = [register_8W weekOfYear];
    
    
    if (container == 1) {
        tillDate = [tillDate dateAfterDay:-1];
            float inglee = 9125.0;
             if (@(inglee).longValue == 5) {}
        NSDateComponents *register_8W = [lineQSuP components: NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear | NSCalendarUnitMonth fromDate:tillDate];
            NSDictionary * handlej = @{@"negligence":@(844), @"vote":@(102), @"charter":@(656)};
             while (handlej.count > 5) { break; }
        container = [register_8W weekday];
            int badgeh = 8124;
             if (@(badgeh).integerValue == 40) {}
        restore = [register_8W weekOfYear];
    }
    
    NSInteger comment = restore;
            float healperf = 4962.0;
             if (@(healperf).doubleValue >= 94) {}
    NSInteger config = register_8W.month;
    if (config == 12 && restore == 1) {
        tillDate = [tillDate dateAfterDay:-7];
            Boolean gestureQ = YES;
             if (!gestureQ) { __asm__("NOP"); }
        NSDateComponents *register_8W = [lineQSuP components: NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear | NSCalendarUnitMonth fromDate:tillDate];
            NSInteger extension_6pN = 494;
             for(NSInteger extension_6pN_idx = 0; extension_6pN_idx < @(extension_6pN).intValue; extension_6pN_idx++) { break; } 
        container = [register_8W weekday];
            NSInteger textU = 7302;
             for(int textU_idx = 0; textU_idx < @(textU).intValue; textU_idx++) { break; } 
        restore = [register_8W weekOfYear];
        comment = 52;
    }
    
    NSDateFormatter *normal = [[NSDateFormatter alloc] init];
    [normal setDateFormat:@"yyyyMMdd"];
    
    NSDate *lineD = [normal dateFromString:[normal stringFromDate:tillDate]];
    
    NSTimeZone *oolsE = [NSTimeZone systemTimeZone];
            Boolean restoreo = NO;
    NSInteger colors = [oolsE secondsFromGMTForDate: lineD];
    
    
    NSDate *connection = [lineD dateByAddingTimeInterval:24*3600*(2 - container)+1 + colors];
    
    NSDate *due = [lineD dateByAddingTimeInterval:24*3600*(9 - container)-1 + colors];
    
    NSMutableArray *node = [[NSMutableArray alloc] init];
    
    
    for (int i = 1; i <= comment; i++) {
        
        NSDate *oolsw = [connection dateByAddingTimeInterval:24 * 3600 * 7 * (i - comment)];
        
        NSDate *states = [due dateByAddingTimeInterval:24 * 3600 * 7 * (i - comment)];
        
        [node addObject:@[oolsw,states]];
        
    }
    
    return node;
    
}


+ (NSString *)getWeekTime
{
    NSDate *badge = [NSDate date];
            NSDictionary * random7 = [NSDictionary dictionaryWithObjectsAndKeys:@"lustrous",@(431), nil];
    NSCalendar *lineQS84 = [NSCalendar currentCalendar];
            float nodee = 9598.0;
             for(int nodee_idx = 0; nodee_idx < @(nodee).intValue; nodee_idx++) { break; } 
    NSDateComponents *register_8V = [lineQS84 components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:badge];
    
    NSInteger containerC = [register_8V weekday];
    
    NSInteger additionslO = [register_8V day];
    NSLog(@"%zd----%zd",containerC,additionslO);
    
    
    long firstDiff,lastDiff;
    
    if (containerC == 1)
    {
        firstDiff = -6;
            double etworkU = 6855.0;
             if (@(etworkU).integerValue == 87) {}
        lastDiff = 0;
    }
    else
    {
        firstDiff = [lineQS84 firstWeekday] - containerC + 1;
            NSString * scnm = @"preach";
             if (scnm.length > 9) {}
        lastDiff = 8 - containerC;
    }
    
    
    
    NSDateComponents *requestp = [lineQS84 components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:badge];
            NSArray * zhenW = @[@(281), @(113), @(548)];
             while (zhenW.count > 13) { break; }
    [requestp setDay:additionslO + firstDiff];
            double accessoryB = 1745.0;
             for(int accessoryB_idx = 0; accessoryB_idx < @(accessoryB).intValue; accessoryB_idx++) { break; } 
    NSDate *etting = [lineQS84 dateFromComponents:requestp];
    
    NSDateComponents *scn = [lineQS84 components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay   fromDate:badge];
            NSDictionary * gestureW = [NSDictionary dictionaryWithObjectsAndKeys:@"T",@"F", nil];
             while (gestureW.count > 125) { break; }
    [scn setDay:additionslO + lastDiff];
            NSDictionary * andomI = [NSDictionary dictionaryWithObjectsAndKeys:@"introduction",@(821), nil];
             if (andomI.count > 53) {}
    NSDate *mbient = [lineQS84 dateFromComponents:scn];
    
    NSDateFormatter *normalr = [[NSDateFormatter alloc] init];
            NSString * buttonsZ = @"veracity";
    [normalr setDateFormat:@"MM月dd日"];
            NSInteger capturef = 7892;
             while (@(capturef).integerValue < 38) { break; }
    NSString *idx = [normalr stringFromDate:etting];
            NSString * statesZ = @"equivocate";
             while (statesZ.length > 144) { break; }
    NSString *frame_wl = [normalr stringFromDate:mbient];
            NSString * web6 = @"inequity";
             if ([web6 isEqualToString:@"r"]) {}
    NSLog(@"%@=======%@",idx,frame_wl);
    
    
    NSString *ubscribel = [NSString stringWithFormat:@"%@ - %@",idx,frame_wl];
    
    return ubscribel;
    
}



+ (NSDate *)getLocalDateFormatAnyDate:(NSDate *)anyDate {
    NSTimeZone *time_f = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
            NSDictionary * type_ivI = @{@"insensitivity":@(545)};
             if (type_ivI[@"D"]) {}
    NSTimeZone *checked = [NSTimeZone localTimeZone];
    
    NSInteger k_max = [time_f secondsFromGMTForDate:anyDate];
    
    NSInteger content = [checked secondsFromGMTForDate:anyDate];
    
    NSTimeInterval colorsw = content - k_max;
    
    NSDate* video = [[NSDate alloc] initWithTimeInterval:colorsw sinceDate:anyDate];
            int baseg = 1317;
             for(NSInteger baseg_idx = 71; baseg_idx < @(baseg).intValue; baseg_idx--) { break; } 
    return video;
}

+ (NSString *)time_timestampToString:(NSInteger)timestamp {

    NSDate *current = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSDateFormatter *url=[[NSDateFormatter alloc]init];

     [url setDateFormat:@"yyyy/MM/dd"];

    NSString* vapturer=[url stringFromDate:current];

    return vapturer;
}


@end
