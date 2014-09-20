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
    [self addHellYeahButton];
}

- (void)addHellYeahButton
{
    //**still need to set background color of button and drop it the bottom**//
    //[self.hellYeahButton setBackgroundColor:[UIColor colorWithRed:128.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:0.7]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(clickedHellYeah:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"HELL YEAH" forState:UIControlStateNormal];
    //**I DONT WANT TO BE SETTING THIS STATICALLY (different phone sizes)
    //grabbing screen size and then setting cgrect
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    button.frame = CGRectMake(80.0, screenHeight-40.0, 160.0, 40.0);
    //button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.view addSubview:button];
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
