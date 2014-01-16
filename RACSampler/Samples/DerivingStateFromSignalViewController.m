//
//  DerivingStateFromSignalViewController.m
//  RACSampler
//
//  Created by jarinosuke on 1/16/14.
//  Copyright (c) 2014 jarinosuke. All rights reserved.
//

#import "DerivingStateFromSignalViewController.h"

@interface DerivingStateFromSignalViewController ()
@property (nonatomic) IBOutlet UITextField *emailField;
@property (nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation DerivingStateFromSignalViewController

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
    [self.emailField becomeFirstResponder];
    
    //Reactive Cocoa stuff...
    //1. Get signal of detecting valid email address.
    RACSignal *vaildEmailSignal = [self.emailField.rac_textSignal map:^id(id value) {
        //CAUTION: return BOOL as NSNumber.
        return @([value rangeOfString:@"@"].location != NSNotFound);
    }];
    
    //2. Bind signal to UIButton.enabled property.
    RAC(self.signupButton, enabled) = vaildEmailSignal;
    
    //3. Bind mapped signal for UIColor to text field.
    RAC(self.emailField, textColor) = [vaildEmailSignal map:^id(id value) {
        BOOL isValid = [value boolValue];
        if (isValid) {
            return [UIColor greenColor];
        } else {
            return [UIColor redColor];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
