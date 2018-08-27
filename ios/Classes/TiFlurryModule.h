/**
 * Ti.Flurry Module
 * Copyright (c) 2010-2013 by Appcelerator, Inc. All Rights Reserved.
 * Please see the LICENSE included with this distribution for details.
 */

#import <UIKit/UIKit.h>

#import "TiModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"

@interface TiFlurryModule : TiModule

@property(nonatomic,readonly) NSNumber* LOG_LEVEL_NONE;
@property(nonatomic,readonly) NSNumber* LOG_LEVEL_ALL;
@property(nonatomic,readonly) NSNumber* LOG_LEVEL_DEBUG;
@property(nonatomic,readonly) NSNumber* LOG_LEVEL_CRITICAL;

@end
