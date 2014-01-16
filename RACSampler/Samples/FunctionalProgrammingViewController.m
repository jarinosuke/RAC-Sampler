//
//  FunctionalProgrammingViewController.m
//  RACSampler
//
//  Created by jarinosuke on 1/15/14.
//  Copyright (c) 2014 jarinosuke. All rights reserved.
//

#import "FunctionalProgrammingViewController.h"

@interface FunctionalProgrammingViewController ()
@property (nonatomic) IBOutlet UILabel *sequenceLabel;
@property (nonatomic) IBOutlet UILabel *answerLabel;
@property (nonatomic) RACSequence *sequence;
@end

@implementation FunctionalProgrammingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //You don't need to understand RACSequence.
        self.sequence = @[@(1), @(2), @(3), @(4), @(5)].rac_sequence;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sequenceLabel.text = [self buildTextFromNumberArray:[self.sequence array]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action
- (IBAction)mapButtonTapped:(id)sender
{
    //1. Map
    NSArray *mappedArray = [[self.sequence map:^id(id value) {
        return @(pow([value integerValue], 2));
    }] array];
    self.answerLabel.text = [self buildTextFromNumberArray:mappedArray];
}

- (IBAction)filterButtonTapped:(id)sender
{
    //2. Filter
    NSArray *filteredArray = [[self.sequence filter:^BOOL(id value) {
        return ([value integerValue] % 2 == 0);
    }] array];
    self.answerLabel.text = [self buildTextFromNumberArray:filteredArray];
}

#pragma mark - Private

- (NSString *)buildTextFromNumberArray:(NSArray *)array
{
    //3. Fold
    return [[array rac_sequence] foldLeftWithStart:@"(" reduce:^id(id accumulator, id value) {
        if ([value isEqual:[array lastObject]]) {
            return [accumulator stringByAppendingFormat:@"@(%@))", value];
        } else {
            return [accumulator stringByAppendingFormat:@"@(%@), ", value];
        }
    }];
}

@end
