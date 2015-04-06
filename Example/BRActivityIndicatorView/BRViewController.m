//
//  BRViewController.m
//  BRActivityIndicatorView
//
//  Created by mitrenegade on 04/06/2015.
//  Copyright (c) 2014 mitrenegade. All rights reserved.
//

#import "BRViewController.h"

@interface BRViewController ()

@end

@implementation BRViewController

#define MAX_VAL 1000.0f

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.activityIndicator = [[CustomActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 169, 320, 20)];
    [self.activityIndicator setIsIndeterminate:NO];
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];

    [self.label setText:@"In progress..."];
    int step=0;
    [self increment:@(step)];
}

-(void)increment:(NSNumber *)stepNum {
    float step = [stepNum floatValue];
    float percent = step / MAX_VAL;
    [self.percent setText:[NSString stringWithFormat:@"%2.3f %%", percent*100]];
    [self.activityIndicator updateProgress:percent];

    NSLog(@"step: %@ percent %f", stepNum, percent);

    if (step >= MAX_VAL) {
        [self.activityIndicator stopAnimating];
        [self.label setText:@"Done"];
    }
    else {
        [self performSelector:@selector(increment:) withObject:@(step+1) afterDelay:.001];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
