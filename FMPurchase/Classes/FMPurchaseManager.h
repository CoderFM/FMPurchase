//
//  FMPurchaseManager.h
//  FMPurchase
//
//  Created by 郑桂华 on 2022/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IAPPurchType) {
    IAPPurchSuccess        = 0,
    IAPPurchFailed         = 1,
    IAPPurchCancle         = 2,
    IAPPurchVerFailed      = 3,
    IAPPurchVerSuccess     = 4,
    IAPPurchNotAllow       = 5,
    IAPPurchRestoreNotBuy  = 6,
    IAPPurchRestoreFailed  = 7,
    IAPPurchEmptyID        = 8,
    IAPPurchNoProduct      = 9,
};

#define kNotificationBuySuccess @"kNotificationBuySuccess"

typedef void (^IAPCompletionHandle)(IAPPurchType type, NSDictionary *dict);

@interface FMPurchaseManager : NSObject

@property (nonatomic, assign) BOOL isAppstore;
@property (nonatomic, copy)NSString *appleSubscribePassword;

@property (copy, nonatomic) IAPCompletionHandle handle;


+ (instancetype)sharedInstance;


- (void)addTransactionObserver;


- (void)removeTransactionObserver;


- (void)startPurchaseWithProductId:(NSString * _Nonnull)productId
                    completeHandle:(IAPCompletionHandle _Nullable)handle;


- (void)startSubscribeWithProductId:(NSString * _Nonnull)productId completeHandle:(IAPCompletionHandle _Nullable)handle;


- (void)restorePurchasesWithCompleteHandle:(IAPCompletionHandle _Nullable)handle;

+ (NSString *_Nullable)tipWithType:(IAPPurchType)type;

@end

NS_ASSUME_NONNULL_END
