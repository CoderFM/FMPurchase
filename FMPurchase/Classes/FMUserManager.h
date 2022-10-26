//
//  FMUserManager.h
//  FMPurchase
//
//  Created by 郑桂华 on 2022/10/26.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMUserManager : NSObject<NSCoding>

+ (instancetype)shareInstance;

@property (nonatomic, assign) BOOL isTest;
@property (nonatomic, assign) BOOL isSubscribe;
@property (nonatomic, assign) NSTimeInterval vipDueDate;
@property (nonatomic, copy) NSString *auto_renew_status;
@property (nonatomic, assign) BOOL isFree;
@property (nonatomic, copy) NSString *original_transaction_id;
@property (nonatomic, copy) NSString *product_id;

@property (copy, nonatomic) NSString *deviceToken;
@property (copy, nonatomic) NSString *ua;

@property (copy, nonatomic) NSString *uid;
@property(nonatomic, assign)BOOL hasShowedWelcome;

- (void)saveUserData;
- (void)clearUserData;
- (void)resetUid;

@end

NS_ASSUME_NONNULL_END
