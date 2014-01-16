//
//  SignalSubscriptionViewController.m
//  RACSampler
//
//  Created by jarinosuke on 1/16/14.
//  Copyright (c) 2014 jarinosuke. All rights reserved.
//

#import "SignalSubscriptionViewController.h"

@interface SignalSubscriptionViewController ()
@property (nonatomic) IBOutlet UILabel *inputtedTextLabel;
@property (nonatomic) IBOutlet UITextField *textField;
@end

@implementation SignalSubscriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textField becomeFirstResponder];
    
    
    //Reactive Cocoa stuff
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        self.inputtedTextLabel.text = x;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
