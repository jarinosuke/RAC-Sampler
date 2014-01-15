//
//  MasterViewController.m
//  RACSampler
//
//  Created by jarinosuke on 1/15/14.
//  Copyright (c) 2014 jarinosuke. All rights reserved.
//

#import "MasterViewController.h"

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
                         @{kItemKeyTitle: @"RXCollection Usage",
                           kItemKeyDescription: @"",
                           kItemKeyClass: [UIViewController class]}
                         ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor colorWithRed:0.063 green:0.848 blue:0.355 alpha:1.000];
    
    NSDictionary *sample = self.samples[indexPath.row];
    cell.textLabel.text = sample[kItemKeyTitle];
    cell.detailTextLabel.text = sample[kItemKeyDescription];
    
    return cell;
}

#pragma mark - UITableViewDelegate

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
