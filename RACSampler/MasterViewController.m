//
//  MasterViewController.m
//  RACSampler
//
//  Created by jarinosuke on 1/15/14.
//  Copyright (c) 2014 jarinosuke. All rights reserved.
//

#import "MasterViewController.h"
#import "FunctionalProgrammingViewController.h"
#import "SignalSubscriptionViewController.h"

#define kItemKeyTitle       @"title"
#define kItemKeyDescription @"description"
#define kItemKeyClass       @"class"

@interface MasterViewController ()
@property (nonatomic) NSArray *samples;
@end

@implementation MasterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"RAC Sampler";
        
        self.samples = @[
                         //RXCollection Usage
                         @{kItemKeyTitle: @"Functional Programming",
                           kItemKeyDescription: @"We need to learn functional programming before reactive functional programming.",
                           kItemKeyClass: [FunctionalProgrammingViewController class]},
                         
                         //Signal Subscription
                         @{kItemKeyTitle: @"Signal Subscription",
                           kItemKeyDescription: @"RAC serves signal to each UIKit components, we can receive their changes from it.",
                           kItemKeyClass: [SignalSubscriptionViewController class]}
                         ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.samples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithRed:0.063 green:0.848 blue:0.355 alpha:1.000];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    NSDictionary *sample = self.samples[indexPath.row];
    cell.textLabel.text = sample[kItemKeyTitle];
    cell.detailTextLabel.text = sample[kItemKeyDescription];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *sample = self.samples[indexPath.row];
    Class aClass = sample[kItemKeyClass];
    id viewController = [[aClass alloc] init];
    
    if ([viewController isKindOfClass:[UIViewController class]]) {
        
        [(UIViewController *)viewController setTitle:sample[kItemKeyTitle]];
        [self.navigationController pushViewController:(UIViewController *)viewController
                                             animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
