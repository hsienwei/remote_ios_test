//
//  TestChromeCastViewController.m
//  TestUpnp
//
//  Created by udntv on 2014/5/12.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import "TestChromeCastViewController.h"
#import <GoogleCast/GoogleCast.h>
#import "ResourcePlayAdapter.h"

@interface TestChromeCastViewController ()

@end

@implementation TestChromeCastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _deviceArray = [NSMutableArray array];
    
    _deviceScanner = [[GCKDeviceScanner alloc] init];
    
    [_deviceScanner addListener:self];
    [_deviceScanner startScan];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)deviceDidComeOnline:(GCKDevice *)device
{
    [_deviceArray addObject:device];
}

/**
 * Called when a device has gone offline.
 *
 * @param device The device.
 */
- (void)deviceDidGoOffline:(GCKDevice *)device
{
    [_deviceArray removeObject:device];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_deviceArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    
    GCKDevice *device = [_deviceArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:device.friendlyName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCKDevice *device = [_deviceArray objectAtIndex:indexPath.row];
    ChromecastPlayAdapter *adapter = [[ChromecastPlayAdapter alloc] initWithDevice:device];
    [AdapterUtil setSharedAdapter:adapter];
}

@end
