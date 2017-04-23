//
//  OCRootViewController.m
//  POE
//
//  Created by Benjamin Erhart on 06.04.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

#import "OCRootViewController.h"

@implementation OCRootViewController

- (id)init
{
    if (self = [super initWithNibName: @"LaunchScreen" bundle: [NSBundle bundleForClass: [OCRootViewController classForCoder]]])
    {
        self.introVC = [[IntroViewController alloc] init];
        self.conctVC = [[ConnectingViewController alloc] init];
        self.errorVC = [[ErrorViewController alloc] init];
    }

    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];

    if (!self.nextVC)
    {
        self.nextVC = self.introVC;
    }

    [self presentViewController: self.nextVC animated: animated completion: nil];
    
    if (self.nextVC == self.conctVC)
    {
        // For this demo: "finish" Tor connection after 6 seconds.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.conctVC connectionFinished];
        });
    }
}

- (void)introFinished:(BOOL)useBridge
{
    self.nextVC = self.conctVC;
    [self.conctVC connectionStarted];

    [self dismissViewControllerAnimated: true completion: nil];
}

// POEDelegate callback when user clicks "Continue"
- (void)userFinishedConnecting
{
    self.nextVC = self.errorVC;

    [self dismissViewControllerAnimated: true completion: nil];
}

@end
