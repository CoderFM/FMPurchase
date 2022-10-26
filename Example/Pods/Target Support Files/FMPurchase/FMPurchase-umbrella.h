#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FMPurchase.h"
#import "FMPurchaseManager.h"
#import "FMUserManager.h"
#import "NSDate+MZAdd.h"
#import "FMMJTrackManager.h"

FOUNDATION_EXPORT double FMPurchaseVersionNumber;
FOUNDATION_EXPORT const unsigned char FMPurchaseVersionString[];

