//
//  ResourcePlayAdapter.h
//  TestUpnp
//
//  Created by udntv on 2014/5/12.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleCast/GoogleCast.h>

@protocol ResourcePlayAdapter
@required
-(void) playImage:(NSString*) urlStr;
-(void) playVideo:(NSString*) urlStr;
@end



@interface ChromecastPlayAdapter : NSObject<ResourcePlayAdapter, GCKDeviceManagerDelegate, GCKMediaControlChannelDelegate>
{
    GCKDevice* _device;
    GCKDeviceManager *_manager;
    GCKMediaControlChannel *_channel;
    
}
-(id) initWithDevice:(GCKDevice*) device;
-(void) playImage:(NSString*) urlStr;
-(void) playVideo:(NSString*) urlStr;

@end



@interface AdapterUtil : NSObject

+(void) setSharedAdapter:(id<ResourcePlayAdapter>) adapter;
+(id<ResourcePlayAdapter>) getSharedAdapter;

@end
