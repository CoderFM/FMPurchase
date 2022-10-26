//
//  FMMJTrackManager.m
//  FMPurchase
//
//  Created by 郑桂华 on 2022/10/26.
//

#import "FMMJTrackManager.h"
#import <AFNetworking/AFNetworking.h>
#import <WebKit/WebKit.h>
#import "FMUserManager.h"

@interface FMMJTrackManager ()

@property(nonatomic, strong)WKWebView *wkWebView;
@property(nonatomic, strong)AFHTTPSessionManager *sessionManager;

@end

@implementation FMMJTrackManager

- (void)trackWithKey:(NSString *)key {

    NSDateFormatter *normal = [[NSDateFormatter alloc] init];
    normal.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *time = [normal stringFromDate:[NSDate date]];
    NSString *ubscribe = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *botton = [[NSMutableDictionary alloc]init];
    [botton setValue:key forKey:@"key"];
    [botton setValue:self.sub_type forKey:@"sub_type"];
    [botton setValue:[self getNetworkIPAddress] forKey:@"ip"];
    [botton setValue:time forKey:@"event_time"];
    [botton setValue:[FMUserManager shareInstance].uid?:@"" forKey:@"uid"];
    [botton setValue:[FMUserManager shareInstance].ua?:@"" forKey:@"remark"];
    [botton setValue:self.sub_type forKey:@"app"];
    [botton setValue:ubscribe forKey:@"version"];
    [botton setValue:@"ios" forKey:@"source"];
    [self.sessionManager POST:self.baseUrl parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [botton.allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *andomt = [botton[key] dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:andomt name:key];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--------%@",responseObject);
        NSLog(@"---%@----", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *itemc = (NSDictionary *)obj;
            NSInteger v_positionR = [itemc[@"code"] integerValue];
            if (v_positionR == 200) {
                NSLog(@"埋点成功");
            } else {
                NSLog(@"埋点失败");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"埋点失败: %@", error.domain);
    }];
}

+ (instancetype)sharedInstance {
    static FMMJTrackManager *instance;
    static dispatch_once_t keyboard;
    dispatch_once(&keyboard, ^{
        instance = [[self alloc] init];
        [instance getUA];
    });
    return instance;
}


- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager manager] init];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_sessionManager.requestSerializer setValue:@"application/x.dingwei.v1+json" forHTTPHeaderField:@"Accept"];
        [_sessionManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    return _sessionManager;
}

- (WKWebView *)wkWebView{
    if (_wkWebView == nil) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
    }
    return _wkWebView;
}

- (NSString *)getNetworkIPAddress {
    NSString *states = @"0.0.0.0";
    NSError *netword;
    NSURL *tap = [NSURL URLWithString:[NSString stringWithFormat:@"http://states.taobao.com/outGetIpInfo?states=%@&accessKey=alibaba-inc",@"myip"]];
    NSMutableString *idfa = [NSMutableString stringWithContentsOfURL:tap encoding:NSUTF8StringEncoding error:&netword];
    if (idfa) {
        NSData *andom = [idfa dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *video = [NSJSONSerialization JSONObjectWithData:andom options:NSJSONReadingMutableContainers error:nil];
        NSString *btn = video[@"msg"];
        NSInteger v_position = [video[@"code"] intValue];
        if (v_position == 0 && [btn containsString:@"success"]) {
            NSDictionary *dataDic = video[@"data"];
            states = dataDic[@"queryIp"];
        }
    }
    return states;
}

- (void)getUA{
    NSURL *line = [NSURL URLWithString:@"http://www.baidu.com/"];
    NSURLRequest *shadow = [NSURLRequest requestWithURL:line
                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                             timeoutInterval:10.f];
    [self.wkWebView loadRequest:shadow];
    [self.wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *origin = result;
        if (origin.length > 0) {
            [FMUserManager shareInstance].ua = origin;
            [[FMUserManager shareInstance] saveUserData];
        }
    }];
}

@end
