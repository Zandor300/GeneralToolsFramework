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

#import "PINCache.h"
#import "PINCacheMacros.h"
#import "PINCacheObjectSubscripting.h"
#import "PINCaching.h"
#import "PINDiskCache.h"
#import "PINMemoryCache.h"

FOUNDATION_EXPORT double ZSPINCacheVersionNumber;
FOUNDATION_EXPORT const unsigned char ZSPINCacheVersionString[];

