//
//  ViewController.m
//  TangoSampleApp
//
//  Created by Raul Hahn on 31/10/16.
//  Copyright © 2016 Tangotargeting. All rights reserved.
//

#import "ViewController.h"
#import <Tango/Tango.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)triggerCampaign:(id)sender {
    [Tango trigger:@"yourTrigger"];
}

- (IBAction)addSegments:(id)sender {
    [Tango addSegments:@[@"yourListOfTags"]]; // Each tag should be a separate object in the array.
}

@end
