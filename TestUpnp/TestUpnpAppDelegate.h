//
//  TestUpnpAppDelegate.h
//  TestUpnp
//
//  Created by udntv on 2014/5/5.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CyberLink/CGUpnpAvRenderer.h>

@interface TestUpnpAppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak)CGUpnpAvRenderer* avRenderer;

@end
