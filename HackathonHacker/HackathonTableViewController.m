//
//  HackathonTableViewController.m
//  HackathonHacker
//
//  Created by David Fontenot on 9/20/14.
//  Copyright (c) 2014 Dave Fontenot. All rights reserved.
//

#import "HackathonTableViewController.h"
#import "HackathonDetailViewController.h"

@interface HackathonTableViewController ()

@end

@implementation HackathonTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hackathonsArray = [NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Hackathon"];
    //**should change to Hackathons at some point
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %d hackathons.", objects.count);
            // Do something with the found objects
            /*
            for (PFObject *object in objects) {
                NSLog(@"%@", object);
                [self.hackathons addObject: object];
            }
             */
            [self addHackathons:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    //self.hackathons = ;
    NSLog(@"%@", self.hackathons);

    
    //self.hackathonsArray[0] = @[@"MHacks", @"PennApps", @"HackTheNorth", @"YHacks"];
    //self.hackathonsArray = [NSMutableArray arrayWithObjects:@"hackNY", @"HackGT", @"CalHacks", @"HackTX", @"BoilerMake", nil];
    NSLog(@"%@", self.hackathonsArray);
    NSLog(@"%d", [self.hackathonsArray count]);
    //self.hackathonsArray[2] = [NSArray arrayWithObjects:@"hackNY", @"HackDuke", @"HackPrinceton", nil];
    //self.hackathonsArray[3] = [NSArray arrayWithObjects:@"HackMIT", @"HackTECH", @"LAHacks", nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)addHackathons:(NSArray *)hackathons
{
    NSLog(@"%@", self.hackathonsArray);
    for (PFObject *hackathon in hackathons) {
        [self.hackathonsArray addObject: hackathon];
    }
    NSLog(@"%@", self.hackathonsArray);
    //NSLog(@"%@", [self.hackathonsArray count]);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    //return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    //return [[self.hackathonsArray objectAtIndex:section] count];
    NSLog(@"%lu", (unsigned long)section);
    //NSLog(@"%lu", (unsigned long)[[self.hackathonsArray objectAtIndex:section] count]);
    //return [[self.hackathonsArray objectAtIndex:section] count];
    return [self.hackathonsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
//    cell.textLabel.text = [self.hackathons objectAtIndex:indexPath.row];
    //NSLog(@"%@", [self.hackathonsArray objectAtIndex:0]);
    //cell.textLabel.text = [[self.hackathonsArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.text = [[self.hackathonsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    //cell.textLabel.text = [self.hackathons objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = [self.hackathonsArray[0] objectAtIndex:indexPath.row];
    //NSLog(@"%@", cell.textLabel.text);
    //instead check hackathon date and determine
    /*
    self.hackathons = [self.hackathonsArray objectAtIndex:indexPath.section];
    switch (indexPath.section) {
        case 0:
            // Configure the cell...
            cell.textLabel.text = [self.hackathons objectAtIndex:indexPath.row];
            break;
        case 1:
            // Configure the cell...
            cell.textLabel.text = [self.hackathons objectAtIndex:indexPath.row];
            break;
        case 2:
            // Configure the cell...
            cell.textLabel.text = [self.hackathons objectAtIndex:indexPath.row];
            break;
        case 3:
            // Configure the cell...
            cell.textLabel.text = [self.hackathons objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
     */
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"toHackathonDetailView"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //**eventually will be a dictionary instead of a string
        //NSString *hackathon = [[self.hackathonsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSMutableDictionary *hackathon = [self.hackathonsArray objectAtIndex:indexPath.row];
        // Get reference to the destination view controller
        HackathonDetailViewController *vc = [segue destinationViewController];
        [vc setHackathon:hackathon];
        
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:hackathon];
    }
}



@end
