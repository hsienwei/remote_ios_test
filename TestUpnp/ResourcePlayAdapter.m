//
//  ResourcePlayAdapter.m
//  TestUpnp
//
//  Created by udntv on 2014/5/12.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import "ResourcePlayAdapter.h"

@implementation ChromecastPlayAdapter

-(id) initWithDevice:(GCKDevice*) device
{
    self = [super init];
    if (self) {
        NSString *packageName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        _manager = [[GCKDeviceManager alloc] initWithDevice:device
                                          clientPackageName:packageName];
        _manager.delegate = self;
    }
    return self;
}


-(void) playImage:(NSString*) urlStr;
{
    //http://dobrochan.ru/src/jpg/1011/fuuuuuuuuuu.jpg
    GCKMediaMetadata *metaData = [[GCKMediaMetadata alloc]initWithMetadataType:GCKMediaMetadataTypePhoto];
    [metaData addImage: [[GCKImage alloc] initWithURL:[NSURL URLWithString:@"http://dobrochan.ru/src/jpg/1011/fuuuuuuuuuu.jpg"] width:300 height:300]];
    [metaData setString:@"fuuuuuu..." forKey:kGCKMetadataKeyTitle];
    
    GCKMediaInformation *mediaInformation = [[GCKMediaInformation alloc] initWithContentID:urlStr
                                                                                streamType:GCKMediaStreamTypeNone
                                                                               contentType:@"image/png"
                                                                                  metadata:metaData
                                                                            streamDuration:0
                                                                                customData:nil];

    [_channel loadMedia:mediaInformation autoplay:YES playPosition:0];
}

-(void) playVideo:(NSString*) urlStr;
{
    //http://www.808.dk/pics/video/gizmo.mp4
    GCKMediaMetadata *metaData = [[GCKMediaMetadata alloc]initWithMetadataType:GCKMediaMetadataTypeMovie];
    [metaData addImage: [[GCKImage alloc] initWithURL:[NSURL URLWithString:@"http://dobrochan.ru/src/jpg/1011/fuuuuuuuuuu.jpg"] width:300 height:300]];
    [metaData setString:@"fuuuuuu..." forKey:kGCKMetadataKeyTitle];
    
    GCKMediaInformation *mediaInformation = [[GCKMediaInformation alloc] initWithContentID:urlStr
                                                                                streamType:GCKMediaStreamTypeNone
                                                                               contentType:@"video/mp4"
                                                                                  metadata:metaData
                                                                            streamDuration:0
                                                                                customData:nil];
    
    [_channel loadMedia:mediaInformation autoplay:YES playPosition:0];
}


- (void)deviceManager:(GCKDeviceManager *)deviceManager
didConnectToCastApplication:(GCKApplicationMetadata *)applicationMetadata
            sessionID:(NSString *)sessionID
  launchedApplication:(BOOL)launchedApplication
{
    _channel = [[GCKMediaControlChannel alloc] init];
    _channel.delegate = self;
    [_manager addChannel:_channel];
}



- (void)mediaControlChannel:(GCKMediaControlChannel *)mediaControlChannel
didCompleteLoadWithSessionID:(NSInteger)sessionID
{
    
}
@end

@implementation AdapterUtil
static id<ResourcePlayAdapter> _adapter = nil;

+(void) setSharedAdapter:(id<ResourcePlayAdapter>) adapter
{
    _adapter = adapter;
}

+(id<ResourcePlayAdapter>) getSharedAdapter
{
    return _adapter;
}

@end
