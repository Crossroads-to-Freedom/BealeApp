//
//  DrawerTableViewController.m
//  CrossRoads
//
//  Created by Will Cobb on 10/8/14.
//  Copyright (c) 2014 Apprentice Media LLC. All rights reserved.
//

#import "DrawerTableViewController.h"

@interface DrawerTableViewController ()

@end

@implementation DrawerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil || YES) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = cell.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                                                    (id)[[UIColor colorWithRed:60.0/256 green:61.0/256 blue:66.0/256 alpha:1]CGColor],
                                                    (id)[[UIColor colorWithRed:53.0/256 green:52.0/256 blue:56.0/255 alpha:1]CGColor], nil];
        //[cell.layer addSublayer:gradient];
        [cell setBackgroundView:[[UIView alloc] init]];
        [cell.backgroundView.layer insertSublayer:gradient atIndex:0];
        
        CAGradientLayer *selectedGrad = [CAGradientLayer layer];
        selectedGrad.frame = cell.bounds;
        selectedGrad.colors = [NSArray arrayWithObjects:
                                                    (id)[[UIColor colorWithRed:17.0/256 green:172.0/256 blue:227.0/256 alpha:1]CGColor],
                                                    (id)[[UIColor colorWithRed:7.0/256 green:162.0/256 blue:217.0/256 alpha:1]CGColor], nil];

        [cell setSelectedBackgroundView:[[UIView alloc] init]];
        [cell.selectedBackgroundView.layer insertSublayer:selectedGrad atIndex:0];
        if (indexPath.row == 0) {
            UIImageView * home = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            home.image = [UIImage imageNamed:@"Home200x200"];
            [cell addSubview:home];
        }
        
    }        
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
