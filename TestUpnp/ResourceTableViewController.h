//
//  ResourceTableViewController.h
//  TestUpnp
//
//  Created by udntv on 2014/5/12.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourcePlayAdapter.h"

@interface ResourceTableViewController : UITableViewController
{
    id<ResourcePlayAdapter> adapter;
}

@property (nonatomic, readwrite) id<ResourcePlayAdapter> adapter;

@end
