//
//  FMPurchaseManager.h
//  FMPurchase
//
//  Created by 郑桂华 on 2022/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FMIAPPurchType) {
    FMIAPPurchSuccess        = 0,
    FMIAPPurchFailed         = 1,
    FMIAPPurchCancle         = 2,
    FMIAPPurchVerFailed      = 3,
    FMIAPPurchVerSuccess     = 4,
    FMIAPPurchNotAllow       = 5,
    FMIAPPurchRestoreNotBuy  = 6,
    FMIAPPurchRestoreFailed  = 7,
    FMIAPPurchEmptyID        = 8,
    FMIAPPurchNoProduct      = 9,
};

#define kNotificationBuySuccess @"kNotificationBuySuccess"

typedef void (^FMIAPCompletionHandle)(FMIAPPurchType type, NSDictionary *dict);

@interface FMPurchaseManager : NSObject

@property (nonatomic, assign) BOOL isAppstore;
@property (nonatomic, copy)NSString *appleSubscribePassword;

@property (copy, nonatomic) FMIAPCompletionHandle handle;


+ (instancetype)sharedInstance;


- (void)addTransactionObserver;


- (void)removeTransactionObserver;


- (void)startPurchaseWithProductId:(NSString * _Nonnull)productId
                    completeHandle:(FMIAPCompletionHandle _Nullable)handle;


- (void)startSubscribeWithProductId:(NSString * _Nonnull)productId completeHandle:(FMIAPCompletionHandle _Nullable)handle;


- (void)restorePurchasesWithCompleteHandle:(FMIAPCompletionHandle _Nullable)handle;

+ (NSString *_Nullable)tipWithType:(FMIAPPurchType)type;

@end

NS_ASSUME_NONNULL_END
