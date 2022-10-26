//
//  FMUserManager.m
//  FMPurchase
//
//  Created by 郑桂华 on 2022/10/26.
//

#import "FMUserManager.h"

static NSString * const KEY_USER = @"TranslateOfficer";

@implementation FMUserManager

- (BOOL)isSubscribe {
    if (self.isTest) {
        return YES;
    }
    return _vipDueDate > [NSDate dateWithTimeIntervalSinceNow:0].timeIntervalSince1970;
}

- (void)saveUserData{
    NSData *normal = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *input = [NSUserDefaults standardUserDefaults];
    [input setObject:normal forKey:KEY_USER];
    [input synchronize];
}

+ (instancetype)shareInstance {
    static FMUserManager *helper = nil;
    static dispatch_once_t top;
    dispatch_once(&top, ^{
        NSUserDefaults *inputX = [NSUserDefaults standardUserDefaults];
        FMUserManager *q_width = [NSKeyedUnarchiver unarchiveObjectWithData:[inputX objectForKey:KEY_USER]] ;
        if (q_width) {
            helper = q_width;
        } else {
            helper = [[self alloc] init];
            [helper resetUid];
        }
    });
    return helper;
}

- (void)setHasShowedWelcome:(BOOL)hasShowedWelcome{
    _hasShowedWelcome = hasShowedWelcome;
    [self saveUserData];
}

- (void)clearUserData {
    NSUserDefaults *inputD = [NSUserDefaults standardUserDefaults];
    [inputD removeObjectForKey:KEY_USER];
    [inputD synchronize];
}

- (void)resetUid{
    if (self.uid.length > 0) {
        return;
    }
    self.uid = [self getUuid];
    [self saveUserData];
}

- (NSString *)getUuid {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int base = 0;
    Ivar *vector = class_copyIvarList([self class], &base);
    for (int i = 0; i < base; i ++) {
        Ivar var = vector[i];
        const char *button = ivar_getName(var);
        NSString *stack = [NSString stringWithUTF8String:button];
        id date = [self valueForKey:stack];
        if (date) {
            [aCoder encodeObject:date forKey:stack];
        }
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int basem = 0;
        Ivar *vectort = class_copyIvarList([self class], &basem);
        for (int i = 0; i < basem; i ++) {
            Ivar var = vectort[i];
            const char *buttonG = ivar_getName(var);
            NSString *stackk = [NSString stringWithUTF8String:buttonG];
            id dateI = [aDecoder decodeObjectForKey:stackk];
            if (dateI) {
                [self setValue:dateI forKey:stackk];
            }
        }
    }
    return self;
}

@end
