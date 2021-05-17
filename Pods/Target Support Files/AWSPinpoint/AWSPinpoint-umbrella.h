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

#import "AWSPinpoint.h"
#import "AWSPinpointAnalyticsClient.h"
#import "AWSPinpointConfiguration.h"
#import "AWSPinpointEndpointProfile.h"
#import "AWSPinpointEvent.h"
#import "AWSPinpointEventRecorder.h"
#import "AWSPinpointNotificationManager.h"
#import "AWSPinpointService.h"
#import "AWSPinpointSessionClient.h"
#import "AWSPinpointTargetingClient.h"
#import "AWSPinpointTargeting.h"
#import "AWSPinpointTargetingModel.h"
#import "AWSPinpointTargetingResources.h"
#import "AWSPinpointTargetingService.h"

FOUNDATION_EXPORT double AWSPinpointVersionNumber;
FOUNDATION_EXPORT const unsigned char AWSPinpointVersionString[];

