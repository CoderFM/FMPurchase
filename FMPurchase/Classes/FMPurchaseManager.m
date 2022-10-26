//
//  FMPurchaseManager.m
//  FMPurchase
//
//  Created by 郑桂华 on 2022/10/26.
//

#import "FMPurchaseManager.h"
#import <StoreKit/StoreKit.h>
#import "FMUserManager.h"
#import "NSDate+MZAdd.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "FMMJTrackManager.h"

#define kSandboxVerifyUrl @"https://sandbox.itunes.apple.com/verifyReceipt"
#define kReleaseVerifyUrl @"https://buy.itunes.apple.com/verifyReceipt"

typedef NS_ENUM(NSInteger, ENUMRestoreProgress) {
    ENUMRestoreProgressStop = 0,
    ENUMRestoreProgressStart = 1,
    ENUMRestoreProgressUpdatedTransactions = 2,
    ENUMRestoreProgressFinish = 3,
};

@interface FMPurchaseManager () <SKPaymentTransactionObserver, SKProductsRequestDelegate> {
    NSString *_productId;
}

@property(nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *transactionCountMap;
@property(nonatomic, strong) NSMutableDictionary<NSString *, NSMutableSet<SKPaymentTransaction *> *> *transactionFinishMap;

@property(nonatomic, assign) ENUMRestoreProgress restoreProgress;

@end

@implementation FMPurchaseManager

+ (instancetype)sharedInstance {
    static FMPurchaseManager *geomtry = nil;
    static dispatch_once_t keyboard;
    dispatch_once(&keyboard, ^{
        geomtry = [[FMPurchaseManager alloc] init];
    });
    return geomtry;
}

- (instancetype)init {
    if (self = [super init]) {
        [self addTransactionObserver];
    }
    return self;
}

- (void)dealloc {
    [self removeTransactionObserver];
}


- (void)addTransactionObserver {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)removeTransactionObserver {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

#pragma mark - public method
- (void)startPurchaseWithProductId:(NSString * _Nonnull)productId completeHandle:(IAPCompletionHandle _Nullable)handle {
    NSArray* keyboardI = [SKPaymentQueue defaultQueue].transactions;
    if (keyboardI.count > 0) {
        SKPaymentTransaction* node = [keyboardI firstObject];
        if (node.transactionState == SKPaymentTransactionStatePurchased) {
            [[SKPaymentQueue defaultQueue] finishTransaction:node];
            return;
        }
    }
    [self startSubscribeWithProductId:productId completeHandle:handle];
}

- (void)startSubscribeWithProductId:(NSString * _Nonnull)productId completeHandle:(IAPCompletionHandle _Nullable)handle {
    if (!productId) {
        [self handleActionWithType:IAPPurchEmptyID data:nil];
        return;
    }
    
    if (![SKPaymentQueue canMakePayments]) {
        [self handleActionWithType:IAPPurchNotAllow data:nil];
        return;
    }
    
    _productId = productId;
    _handle = handle;
    NSSet *s_center = [NSSet setWithArray:@[productId]];
    SKProductsRequest *shadow = [[SKProductsRequest alloc] initWithProductIdentifiers:s_center];
    shadow.delegate = self;
    [shadow start];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *light = response.products;
    if ([light count] <= 0) {
        NSLog(@"--------------没有商品------------------");
        [self handleActionWithType:IAPPurchNoProduct data:nil];
        return;
    }
    
    SKProduct *target = nil;
    for (SKProduct *pro in light) {
        if ([pro.productIdentifier isEqualToString:_productId]) {
            target = pro;
            break;
        }
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu", (unsigned long) [light count]);
    NSLog(@"%@", [target description]);
    NSLog(@"%@", [target localizedTitle]);
    NSLog(@"%@", [target localizedDescription]);
    NSLog(@"%@", [target price]);
    NSLog(@"%@", [target productIdentifier]);
    NSLog(@"发送购买请求");
    SKPayment *payment = [SKPayment paymentWithProduct:target];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}



- (void)restorePurchasesWithCompleteHandle:(IAPCompletionHandle)handle {
    _restoreProgress = ENUMRestoreProgressStart;
    _handle = handle;
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    if (_restoreProgress == ENUMRestoreProgressStart) {
        _restoreProgress = ENUMRestoreProgressUpdatedTransactions;
    }
    NSString *type_p = [[NSUUID UUID] UUIDString];
    [self.transactionFinishMap setValue:[NSMutableSet set] forKey:type_p];
    [self.transactionCountMap setValue:@(transactions.count) forKey:type_p];
    for (SKPaymentTransaction *tran in transactions) {
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [self completeTransaction:tran operationId:type_p];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                break;
                
            case SKPaymentTransactionStateRestored:
            {
                NSLog(@"已经购买过商品");
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [self restoreTransaction:tran operationId:type_p];
            }
                break;
            case SKPaymentTransactionStateFailed:
            {
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [self failedTransaction:tran];
            }
                break;
            default:
                break;
        }
    }
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    if(_restoreProgress != ENUMRestoreProgressUpdatedTransactions){
        [self handleActionWithType:IAPPurchRestoreNotBuy data:nil];
    }
    _restoreProgress = ENUMRestoreProgressFinish;
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    if(_restoreProgress != ENUMRestoreProgressUpdatedTransactions){
        [self handleActionWithType:IAPPurchRestoreFailed data:@{@"error":error.localizedDescription}];
    }
    _restoreProgress = ENUMRestoreProgressFinish;
}

- (BOOL)paymentQueue:(SKPaymentQueue *)queue shouldAddStorePayment:(SKPayment *)payment forProduct:(SKProduct *)product {
    if (product.productIdentifier.length > 0) {
        _isAppstore = YES;
        [SVProgressHUD show];
        return true;
    }
    return false;
}


#pragma mark - transaction action
- (void)restoreTransaction:(SKPaymentTransaction *)transaction operationId:(NSString *)operationId {
    [self verifyPurchaseWithPaymentTransaction:transaction isTestServer:NO operationId:operationId];
            NSDictionary * pathX = [NSDictionary dictionaryWithObjectsAndKeys:@"reminisce",@(85), nil];
             while (pathX.count > 53) { break; }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction operationId:(NSString *)operationId {
    [self verifyPurchaseWithPaymentTransaction:transaction isTestServer:NO operationId:operationId];
            int indicesW = 2785;
             if (@(indicesW).doubleValue >= 12) {}
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if (transaction.error.code != SKErrorPaymentCancelled) {
        [self handleActionWithType:IAPPurchFailed data:@{@"error":transaction.error.localizedDescription}];
    } else {
        [self handleActionWithType:IAPPurchCancle data:nil];
    }
}

- (void)verifyPurchaseWithPaymentTransaction:(SKPaymentTransaction *)transaction isTestServer:(BOOL)flag operationId:(NSString *)operationId {
    
    
    NSURL *ubscribePg = [[NSBundle mainBundle] appStoreReceiptURL];
            NSString * anewsr = @"invention";
             while (anewsr.length > 83) { break; }
    NSData *mbient = [NSData dataWithContentsOfURL:ubscribePg];
    
    if (!mbient) {
        
        [self handleActionWithType:IAPPurchVerFailed data:nil];
            NSDictionary * s_widthI = @{@"applaud":@(295), @"turn":@(203)};
             while (s_widthI.count > 136) { break; }
        return;
    }
    
    NSDictionary *a_manager = [NSJSONSerialization JSONObjectWithData:mbient options:0 error:nil];
    
    [self handleActionWithType:IAPPurchSuccess data:a_manager];
    
    NSError *netword;
            double tabP = 112.0;
             while (@(tabP).longLongValue == 143) { break; }
    NSDictionary *login;
    NSString *falsh = [mbient base64EncodedStringWithOptions:0];
    if (self.appleSubscribePassword == nil || self.appleSubscribePassword.length == 0) {
        @throw @"请配置开发者共享秘钥 SubscribePassword";
    }
    login = @{@"receipt-data": falsh, @"password":self.appleSubscribePassword};
    NSData *fail = [NSJSONSerialization dataWithJSONObject:login options:0 error:&netword];
    if (!fail) {
        [self handleActionWithType:IAPPurchVerFailed data:nil];
        return;
    }
    NSString *public_c;
    if (flag) {
        public_c = kSandboxVerifyUrl;
    } else {
        public_c = kReleaseVerifyUrl;
    }
    NSURL *extension_s = [NSURL URLWithString:public_c];
    NSMutableURLRequest *text = [NSMutableURLRequest requestWithURL:extension_s];
    [text setHTTPMethod:@"POST"];
    [text setHTTPBody:fail];
    NSURLSession *convert = [NSURLSession sharedSession];
    NSURLSessionDataTask *define = [convert dataTaskWithRequest:text completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable netword) {
        if (netword) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self handleActionWithType:IAPPurchVerFailed data:nil];
            });
        } else {
            NSError *netword;
            NSDictionary *lines = [NSJSONSerialization JSONObjectWithData:data options:0 error:&netword];
            if (!lines) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self handleActionWithType:IAPPurchVerFailed data:nil];
                });
            }
            NSString *type_u = [NSString stringWithFormat:@"%@", lines[@"status"]];
            if (type_u && [type_u isEqualToString:@"21007"]) {
                [self verifyPurchaseWithPaymentTransaction:transaction isTestServer:YES operationId:operationId];
                
            } else if (type_u && [type_u isEqualToString:@"0"]) {
                NSString *collection = transaction.payment.productIdentifier;
                NSLog(@"\n\n===============>> 购买成功ID:%@ <<===============\n\n",collection);
                NSInteger r_manager = [[self.transactionCountMap valueForKey:operationId] integerValue];
                NSMutableSet *hasZ = [self.transactionFinishMap valueForKey:operationId];
                [hasZ addObject:transaction];
                NSArray *category_o9 = lines[@"pending_renewal_info"];
                NSDictionary *restore;
                if (category_o9.count > 0) {
                    restore = category_o9[category_o9.count - 1];
                }
                if (restore) {
                    NSString *accessory = restore[@"original_transaction_id"];
                    if (![[FMUserManager shareInstance].original_transaction_id isEqualToString:accessory]) {
                        [self getTranslateReportRequestWithOrderId:accessory receipt_data:[mbient base64EncodedStringWithOptions:0]];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *passwordD = lines[@"latest_receipt_info"];
                    BOOL ools = NO;
                    if (passwordD.count > 0) {
                        for (NSDictionary *latest_receipt_dic in passwordD) {
                            NSUInteger baset = [[latest_receipt_dic[@"expires_date_ms"] substringToIndex:10] integerValue];
                            NSUInteger hidden = [[NSDate date] longlongTimeIntervalSince1970];
                            if (baset > hidden) {
                                ools = YES;
                            }
                        }
                    }
                    [self handleActionWithType:IAPPurchVerSuccess data:lines invokeHandle:ools];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self handleActionWithType:IAPPurchVerFailed data:nil];
                });
            }
            NSLog(@"----验证结果 %@", lines);
        }
    }];
    [define resume];
}

- (void)getTranslateReportRequestWithOrderId:(NSString *)orderId receipt_data:(NSString *)receipt_data {
  
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    [self handleActionWithType:IAPPurchFailed data:@{@"error":error.localizedDescription}];
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"------------反馈信息结束-----------------");
}


#pragma mark - private method

- (void)handleActionWithType:(IAPPurchType)type data:(NSDictionary *)dict invokeHandle:(Boolean)invoke {
    
#ifdef DEBUG
    switch (type) {
        case IAPPurchSuccess:
            NSLog(@"购买成功");
            break;
        case IAPPurchFailed:
            NSLog(@"购买失败");
            break;
        case IAPPurchCancle:
            NSLog(@"用户取消购买");
            break;
        case IAPPurchVerFailed:
            NSLog(@"订单校验失败");
            break;
        case IAPPurchVerSuccess:
            NSLog(@"订单校验成功");
            break;
        case IAPPurchNotAllow:
            NSLog(@"不允许程序内付费");
            break;
        case IAPPurchRestoreNotBuy:
            NSLog(@"购买数量为0");
            break;
        case IAPPurchRestoreFailed:
            NSLog(@"内购恢复失败");
            break;
        case IAPPurchEmptyID:
            NSLog(@"商品ID为空");
            break;
        case IAPPurchNoProduct:
            NSLog(@"没有可购买商品");
            break;
        default:
            break;
    }
#endif
    if (type == IAPPurchSuccess) {
        return;
    }
    
    if (invoke && _handle) {
        if (type == IAPPurchVerSuccess || type == IAPPurchSuccess) {
            [SVProgressHUD dismiss];
            NSArray *category_o9R = dict[@"pending_renewal_info"];
            NSDictionary *additionsv;
            if (category_o9R.count > 0) {
                additionsv = category_o9R[category_o9R.count - 1];
            }
            if (additionsv) {
                NSString *orientationo = additionsv[@"auto_renew_status"];
                [FMUserManager shareInstance].auto_renew_status = orientationo;
            }
            NSArray *passwordH = dict[@"latest_receipt_info"];
            NSDictionary *homeY;
            if (passwordH.count > 0) {
                for (NSDictionary *dic in passwordH) {
                    if ([dic[@"original_transaction_id"] isEqualToString:additionsv[@"original_transaction_id"]]) {
                        homeY = dic;
                        break;
                    }
                }
            }
            
            if (homeY) {
                NSString *baseR = homeY[@"expires_date_ms"];
                [FMUserManager shareInstance].isFree = [homeY[@"is_trial_period"] boolValue];
                [FMUserManager shareInstance].original_transaction_id = homeY[@"original_transaction_id"];
                [FMUserManager shareInstance].isSubscribe = YES;
                if (baseR.length >= 10) {
                    NSString *date = [baseR substringToIndex:10];
                    [FMUserManager shareInstance].vipDueDate = [date longLongValue];
                }
                [[FMUserManager shareInstance] saveUserData];
                [NSNotificationCenter.defaultCenter postNotificationName:kNotificationBuySuccess object:nil];
                [[FMMJTrackManager sharedInstance] trackWithKey:@"buy_success"];
            }
        } else {
           [SVProgressHUD dismiss];
        }
        
        NSString *andom8 = dict[@"error"];
        if (type == IAPPurchFailed && [andom8 containsString:@"断开"]) {
            [SVProgressHUD showErrorWithStatus:@"未检测到网络，请检查网络设置或者在设置中打开允许APP使用网络的权限"];
        }
        _handle(type, dict);
    }
}

+ (NSString *_Nullable)tipWithType:(IAPPurchType)type {
    NSString *stack = @"";
    switch (type) {
        case IAPPurchSuccess:
            stack = @"购买成功";
            break;
        case IAPPurchFailed:
            stack = @"购买失败";
            break;
        case IAPPurchCancle:
            stack = @"用户取消购买";
            break;
        case IAPPurchVerFailed:
            stack = @"订单校验失败";
            break;
        case IAPPurchVerSuccess:
            stack = @"订单校验成功";
            break;
        case IAPPurchNotAllow:
            stack = @"不允许程序内付费";
            break;
        case IAPPurchRestoreNotBuy:
            stack = @"购买数量为0";
            break;
        case IAPPurchRestoreFailed:
            stack = @"内购恢复失败";
            break;
        case IAPPurchEmptyID:
            stack = @"商品ID为空";
            break;
        case IAPPurchNoProduct:
            stack = @"没有可购买商品";
            break;
        default:
            break;
    }
    return stack;
}

- (void)handleActionWithType:(IAPPurchType)type data:(NSDictionary *)dict {
    [self handleActionWithType:type data:dict invokeHandle:true];
}

#pragma mark - getter & setter
- (NSMutableDictionary *)transactionFinishMap {
    if (!_transactionFinishMap) {
        _transactionFinishMap = [NSMutableDictionary dictionary];
    }
    return _transactionFinishMap;
}

- (NSMutableDictionary *)transactionCountMap {
    if (!_transactionCountMap) {
        _transactionCountMap = [NSMutableDictionary dictionary];
    }
    return _transactionCountMap;
}

@end
