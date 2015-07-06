//
//  eSignVC.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eSignVC.h"
#import "FormCell.h"
#import "formsDetails.h"

#import "DataClass.h"

@interface eSignVC (){
    DataClass *obj;
}

@end

@implementation eSignVC{
    NSMutableArray* forms;
}

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
    
    obj = [DataClass getInstance];
    
    //NSLog(@"TTTT%@",[[obj.eAppData objectForKey:@"eSign"] objectForKey:@"COA"]);
    
    //if ([[obj.eAppData objectForKey:@"eSign"] objectForKey:@"COA"] != Nil){}
    
	forms = [NSMutableArray arrayWithCapacity:10];
    
    formsDetails *form = [[formsDetails alloc] init];
    if ([[obj.eAppData objectForKey:@"eSign"] objectForKey:@"COA"] != Nil){
        form.formName = @"Confirmation of Advice";
        form.formDesc = @"Agent signed";
        form.formStatus = 1;
        [forms addObject:form];
    }
    else{
        form.formName = @"Confirmation of Advice";
        form.formDesc = @"Agent signature is required";
        form.formStatus = 0;
        [forms addObject:form];
    }
    
    form = [[formsDetails alloc] init];
	form.formName = @"Customer Fact Find";
	form.formDesc = @"Customer and agent signatures are required";
	form.formStatus = 0;
	[forms addObject:form];
    
    form = [[formsDetails alloc] init];
	form.formName = @"Proposal Form";
	form.formDesc = @"Customer and agent signatures are required";
	form.formStatus = 0;
	[forms addObject:form];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [forms count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Forms";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" forIndexPath:indexPath];
    //cell = [tableView dequeueReusableCellWithIdentifier:PolicyOwnerCellIdentifier forIndexPath:indexPath];

	formsDetails *form = [forms objectAtIndex:indexPath.row];
    cell.formLabel.text = form.formName;
    cell.formDesc.text = form.formDesc;
    if (form.formStatus == 1){
        cell.formStatus.image = [UIImage imageNamed:@"iconComplete"];
    }
    
    return cell;
    
    //FormCell *cell = (FormCell *)[tableView dequeueReusableCellWithIdentifier:@"FormCell"];
    
	//Player *player = [self.players objectAtIndex:indexPath.row];
	//cell.nameLabel.text = player.name;
	//cell.gameLabel.text = player.game;
	//cell.ratingImageView.image = [self imageForRating:player.rating];
    
    //return cell;
    
    /*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
     */
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0){
        [self.delegate displayPDF:@"COA"];
    }
    
}

- (IBAction)doDone:(id)sender {
    //NSLog(@"asfasfas");
    [self.delegate updateeSignCell];
}
@end
