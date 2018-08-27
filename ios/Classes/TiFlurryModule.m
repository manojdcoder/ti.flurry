/**
 * Ti.Flurry Module
 * Copyright (c) 2010-2013 by Appcelerator, Inc. All Rights Reserved.
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiFlurryModule.h"
#import "Flurry.h"

extern NSString * const TI_APPLICATION_VERSION;

@implementation TiFlurryModule

#pragma mark Lifecycle

-(void)startup
{
	[super startup];
}

-(void)shutdown:(id)sender
{
	[super shutdown:sender];
}

#pragma mark -
#pragma mark Public APIs
#pragma mark -
#pragma mark Public Lifecycle

-(void)initialize:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    FlurrySessionBuilder* builder = [FlurrySessionBuilder new];
    
    [builder withCrashReporting:[TiUtils boolValue:@"enableCrashReporting" properties:args def:YES]];
    [builder withAppVersion:[TiUtils stringValue:@"appVersion" properties:args def:TI_APPLICATION_VERSION]];
    
    if ([args objectForKey:@"timeout"]) {
        [builder withSessionContinueSeconds:[TiUtils intValue:@"timeout" properties:args]];
    }
    
    if ([args objectForKey:@"logLevel"]) {
        [builder withLogLevel:[args objectForKey:@"logLevel"]];
    }
    
    [Flurry startSession:[TiUtils stringValue:@"apiKey" properties:args]];
}

# pragma mark Public Properties

-(void)setUserID:(id)value
{
    ENSURE_SINGLE_ARG(value, NSString);
    [Flurry setUserID:value];
}

-(void)setAge:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    [Flurry setAge:[TiUtils intValue:value]];
}

-(void)setGender:(id)value
{
    ENSURE_SINGLE_ARG(value, NSString);
    [Flurry setGender:value];
}

-(void)setReportOnClose:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
	[Flurry setSessionReportsOnCloseEnabled:[TiUtils boolValue:value]];
}

-(void)setSessionReportsOnPauseEnabled:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
	[Flurry setSessionReportsOnPauseEnabled:[TiUtils boolValue:value]];
}

#pragma mark Deprecated Properties

-(void)setSecureTransportEnabled:(id)value
{
    NSLog(@"[ERROR] Ti.Flurry: The property `secureTransportEnabled` was removed in 2.0.0. SSL is now used automatically by the native SDK.");
}

-(void)setUserId:(id)value
{
    NSLog(@"[ERROR] Ti.Flurry: The property `userId` was removed in 2.0.0. Please use `userID` instead.");
}

# pragma mark Public Methods

-(void)trackLocation:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    [Flurry setLatitude:[TiUtils doubleValue:[args valueForKey:@"latitude"]]
              longitude:[TiUtils doubleValue:[args valueForKey:@"longitude"]]
     horizontalAccuracy:[TiUtils floatValue:[args valueForKey:@"horizontalAccuracy"]]
       verticalAccuracy:[TiUtils floatValue:[args valueForKey:@"verticalAccuracy"]]];
}

-(void)logEvent:(id)args
{
    ENSURE_UI_THREAD(logEvent, args);
    NSString *event = [args objectAtIndex:0];
    NSDictionary *props = nil;
    
    if ([args count] > 1) {
        props = [args objectAtIndex:1];
    }
	
    if (props == nil) {
        [Flurry logEvent:event];
    } else {
        [Flurry logEvent:event withParameters:props];
    }
}

-(void)logTimedEvent:(id)args
{
    ENSURE_UI_THREAD(logTimedEvent, args);
	NSString *event = [args objectAtIndex:0];
	NSDictionary *props = nil;
	if ([args count] > 1)
	{
		props = [args objectAtIndex:1];
	}
	if (props == nil)
	{
		[Flurry logEvent:event timed:YES];
	}
	else 
	{
		[Flurry logEvent:event withParameters:props timed:YES];
	}
}

-(void)endTimedEvent:(id)args
{
    ENSURE_UI_THREAD(endTimedEvent, args);
	NSString *event = [args objectAtIndex:0];
	NSDictionary *props = nil;
	if ([args count] > 1)
	{
		props = [args objectAtIndex:1];
	}
	if (props == nil)
	{
		[Flurry endTimedEvent:event withParameters:nil];
	}
	else 
	{
		[Flurry endTimedEvent:event withParameters:props];
	}
}

-(void)logAllPageViewsForTarget:(id)args
{
    ENSURE_UI_THREAD(logAllPageViewsForTarget, args);
	id target = [args objectAtIndex:0];
    [Flurry logAllPageViewsForTarget:target];
}

-(void)stopLogPageViewsForTarget:(id)args
{
    ENSURE_UI_THREAD(stopLogPageViewsForTarget, args);
	id target = [args objectAtIndex:0];
    [Flurry stopLogPageViewsForTarget:target];
}

-(void)logPageView:(id)args
{
    ENSURE_UI_THREAD(logPageView, args);
    [Flurry logPageView];
}

#pragma mark - Properties

MAKE_SYSTEM_PROP(LOG_LEVEL_NONE, FlurryLogLevelNone);
MAKE_SYSTEM_PROP(LOG_LEVEL_ALL, FlurryLogLevelAll);
MAKE_SYSTEM_PROP(LOG_LEVEL_DEBUG, FlurryLogLevelDebug);
MAKE_SYSTEM_PROP(LOG_LEVEL_CRITICAL, FlurryLogLevelCriticalOnly);

@end
