//
//  TestUpnpViewController.h
//  TestUpnp
//
//  Created by udntv on 2014/5/5.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CyberLink/UPnP.h>
@class CGUpnpAvController;


@interface TestUpnpViewController : UIViewController<CGUpnpControlPointDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *listData;
    CGUpnpAvController *avController;
    NSArray *renderers;
    NSArray *dataSource;
}

@end
