//
//  TestUpnpViewController.m
//  TestUpnp
//
//  Created by udntv on 2014/5/5.
//  Copyright (c) 2014年 pd. All rights reserved.
//

#import "TestUpnpViewController.h"
#import <CyberLink/UPnP.h>
#import <CyberLink/CGUpnpAvController.h>
#import "ServerContentViewController.h"
#import "TestUpnpAppDelegate.h"

@interface TestUpnpViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TestUpnpViewController

static CGUpnpAvController *ctrlPoint ;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    listData = [NSMutableArray array];
    
    ctrlPoint = [[CGUpnpAvController alloc] init];
    ctrlPoint.delegate = self;
//    [ctrlPoint start];
    [ctrlPoint search];

    NSArray *devArray = [ctrlPoint devices];
    for (CGUpnpDevice *dev in devArray)
        NSLog(@"%@", [dev friendlyName]);
    [self.tableView reloadData];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
-(void) dealloc
{
//   [ctrlPoint stop];
    ctrlPoint = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceAdded:(NSString *)deviceUdn
{
    NSLog(@"deviceAdded %@", deviceUdn);
    NSLog(@"%@", [[controlPoint deviceForUDN:deviceUdn] friendlyName]);
    
    NSInteger findIdx = [listData indexOfObject:deviceUdn];
    if(findIdx == NSNotFound )
        [listData addObject:deviceUdn];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}
- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceUpdated:(NSString *)deviceUdn
{
//    if([[controlPoint deviceForUDN:deviceUdn] isDeviceType:@CG_UPNPAV_DMR_DEVICE_TYPE] )
        
        
    NSLog(@"deviceUpdated %@", deviceUdn);
    NSLog(@"%@", [[controlPoint deviceForUDN:deviceUdn] friendlyName]);
    if([listData indexOfObject:deviceUdn] == NSNotFound )
        [listData addObject:deviceUdn];
//        [self.tableView reloadData];
//    [self.tableView setNeedsDisplay];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    avController = (CGUpnpAvController*)controlPoint;
    renderers =  [avController renderers];
    dataSource = [avController servers];
}
- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceRemoved:(NSString *)deviceUdn
{
     NSLog(@"deviceRemoved %@", deviceUdn);
    NSLog(@"%@", [[controlPoint deviceForUDN:deviceUdn] friendlyName]);
    [listData removeObject:deviceUdn];
[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];}
- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceInvalid:(NSString *)deviceUdn
{
     NSLog(@"deviceInvalid %@", deviceUdn);
    NSLog(@"%@", [[controlPoint deviceForUDN:deviceUdn] friendlyName]);
    [listData removeObject:deviceUdn];
[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [renderers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    [cell.textLabel setText:((CGUpnpDevice*)[renderers objectAtIndex:indexPath.row]).friendlyName   ];
    
    return cell;
}

- (IBAction)clickShowDeviceInfo:(id)sender {
    NSLog(@"renders:");
    for (id r in renderers)
    {
        NSLog(@"%@ - %@", [r deviceType], [r friendlyName]);
    }
    NSLog(@"resource:");
    for (id s in dataSource)
    {
        NSLog(@"%@ - %@", [s deviceType], [s friendlyName]);
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGUpnpDevice *device = [avController deviceForUDN:  [listData objectAtIndex:indexPath.row]];
    
    TestUpnpAppDelegate* appDelagete = [[UIApplication sharedApplication] delegate];
    appDelagete.avRenderer = (CGUpnpAvRenderer*)[renderers objectAtIndex:0];
    
    for(id resource in dataSource)
    {
        if([[device friendlyName] isEqualToString:[resource friendlyName]])
        {
            NSLog(@"%@ %@", [device friendlyName], [resource friendlyName]);

                ServerContentViewController *detailViewController = [[ServerContentViewController alloc] initWithAvServer:resource atIndexPath:indexPath objectId:@"0"] ;
                //}
                
                //[self.detailViewController setDetailItem:[self.dataSource objectAtIndex:indexPath.row]];
                
                [self presentViewController:detailViewController animated:YES completion:nil];


        }
    }
    for(id renderer in renderers)
    {
        if([[device friendlyName] isEqualToString:[renderer friendlyName]])
        {
            NSLog(@"%@ %@", [device friendlyName], [renderer friendlyName]);
            
            if ([renderer setAVTransportURI:@"http://techslides.com/demos/sample-videos/small.mp4"]){
                [renderer play];
                //        self.isPlay = [self.renderer isPlaying];
            }
            
        }
    }
    
    
    
    
    
}

@end
