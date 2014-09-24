//
//  HackathonDetailViewController.m
//  HackathonHacker
//
//  Created by David Fontenot on 9/20/14.
//  Copyright (c) 2014 Dave Fontenot. All rights reserved.
//

#import "HackathonDetailViewController.h"
#import <QuartzCore/QuartzCore.h>


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
    
    //loading webview
    [self loadWebView];
    //WebView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width -5, self.view.frame.size.height -5)];
}

- (void)setColor:(UIColor *)color forState:(UIControlState)state forButton:(UIButton*)button
{
    UIView *colorView = [[UIView alloc] initWithFrame:button.frame];
    colorView.backgroundColor = color;
    
    UIGraphicsBeginImageContext(colorView.bounds.size);
    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [button setBackgroundImage:colorImage forState:state];
}

- (void)loadWebView
{
    NSURL *url = [NSURL URLWithString:[self.hackathon objectForKey:@"website"]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
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
    
    //I DONT WANT TO BE SETTING THIS STATICALLY (different phone sizes)
    //grabbing screen size and then setting cgrect
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    button.frame = CGRectMake(0.0, screenHeight-80.0, screenWidth, 80.0);
    [self setColor:[UIColor blackColor] forState:(0) forButton:button];
    
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
    
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    
    NSString *confirmation = [ [@"As soon as " stringByAppendingString:[self.hackathon objectForKey:@"name"]] stringByAppendingString:@" registration opens, you'll receive a push notification!"];
    
    // Send push notification to query
    [PFPush sendPushMessageToQueryInBackground:pushQuery
                                   withMessage:confirmation];
}
@end
