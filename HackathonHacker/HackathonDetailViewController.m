//
//  HackathonDetailViewController.m
//  HackathonHacker
//
//  Created by David Fontenot on 9/20/14.
//  Copyright (c) 2014 Dave Fontenot. All rights reserved.
//

#import "HackathonDetailViewController.h"


@interface HackathonDetailViewController ()

@end

@implementation HackathonDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = [self.hackathon objectForKey:@"name"];
    //self.hellYeah.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(clickedHellYeah:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"HELL YEAH" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    //[self.hellYeahButton setBackgroundColor:[UIColor colorWithRed:128.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.7]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedHellYeah:(id)sender {
    NSLog(@"%@", @"HELL YEAH");
    //save to Parse
    PFObject *gameScore = [PFObject objectWithClassName:@"intent"];
    gameScore[@"hackathonName"] = [self.hackathon objectForKey:@"name"];
    gameScore[@"user"] = @"me";
    [gameScore saveInBackground];
}
@end
