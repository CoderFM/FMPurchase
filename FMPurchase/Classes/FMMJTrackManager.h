//
//  FMMJTrackManager.h
//  FMPurchase
//
//  Created by 郑桂华 on 2022/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMMJTrackManager : NSObject

@property(nonatomic, copy)NSString *sub_type;/// 应用名字
@property(nonatomic, copy)NSString *baseUrl; /// 埋点接口地址

- (void)trackWithKey:(NSString *_Nullable)key;

+ (instancetype _Nullable )sharedInstance;

@end

NS_ASSUME_NONNULL_END
