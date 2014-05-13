//
//  TestChromeCastViewController.h
//  TestUpnp
//
//  Created by udntv on 2014/5/12.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleCast/GoogleCast.h>

@interface TestChromeCastViewController : UITableViewController <GCKDeviceScannerListener, UITableViewDataSource, UITableViewDelegate>
{
    GCKDeviceScanner *_deviceScanner;
    NSMutableArray *_deviceArray;
}

@end
