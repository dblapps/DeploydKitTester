//
//  DKTViewController.m
//  DeploydKitTester
//
//  Created by David Levi on 8/27/13.
//  Copyright (c) 2013 Double Apps Inc. All rights reserved.
//

#import "DKTViewController.h"

@interface DKTViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)queryOnMain:(id)sender;
- (IBAction)queryOnBackground:(id)sender;
@end

@implementation DKTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)queryOnMain:(id)sender
{
	NSError* error = nil;
	DKQuery* query = [DKQuery queryWithEntityName:@"my-objects"];
	NSArray* results = [query findAll:&error];
	self.textView.text = [NSString stringWithFormat:@"ERROR:\n%@\n\nRESULTS:\n%@", error, results];
}

- (IBAction)queryOnBackground:(id)sender {
	DKQuery* query = [DKQuery queryWithEntityName:@"my-objects"];
	[query findAllInBackgroundWithBlock:^(NSArray* results, NSError* error) {
		dispatch_async(dispatch_get_main_queue(), ^() {
			self.textView.text = [NSString stringWithFormat:@"ERROR:\n%@\n\nRESULTS:\n%@", error, results];
		});
	}];
}

@end
