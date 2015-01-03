//
//  ListViewController.m
//  DreamCatcher
//
//  Created by Don Wettasinghe on 12/29/14.
//  Copyright (c) 2014 Don Wettasinghe. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *titleArray;
@property NSMutableArray *descriptionArray;

@end


@implementation ListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray=[NSMutableArray new];
    self.descriptionArray=[NSMutableArray new];
    self.editing=false;
}

-(void)presentDreamEntry{
    
    UIAlertController *alertMessage=[UIAlertController alertControllerWithTitle:@"Enter New Dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
   
    [alertMessage addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder=@"Dream Title";
    }];
    
    [alertMessage addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder=@"Dream Description";
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *saveAction=[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *textFieldOne=alertMessage.textFields[0];
        UITextField *textFieldTwo=alertMessage.textFields[1];
        
        [self.titleArray addObject:textFieldOne.text];
        [self.descriptionArray addObject:textFieldTwo.text];
        
        [self.tableView reloadData];
    }];
    
    [alertMessage addAction:cancelAction];
    [alertMessage addAction:saveAction];
    
    [self presentViewController:alertMessage animated:true completion:nil];
    
}


- (IBAction)onAddButtonClick:(UIBarButtonItem *)sender
{
    [self presentDreamEntry];
}


- (IBAction)onEditButtonClick:(UIBarButtonItem *)sender
{
    
    if (self.editing) {
        self.editing=false;
        [self.tableView setEditing:false animated:true];
        sender.title=@"Edit";
        sender.style=UIBarButtonItemStyleDone;
    } else {
        self.editing=true;
        [self.tableView setEditing:true animated:true];
        sender.title=@"Done";
        sender.style=UIBarButtonItemStyleDone;
    }
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
     NSString *titleItem=[self.titleArray objectAtIndex:sourceIndexPath.row];
    [self.titleArray removeObject:titleItem];
    [self.titleArray insertObject:titleItem atIndex:destinationIndexPath.row];
    
    NSString *descriptionItem=[self.descriptionArray objectAtIndex:sourceIndexPath.row];
    [self.descriptionArray removeObject:descriptionItem];
    [self.descriptionArray insertObject:descriptionItem atIndex:destinationIndexPath.row];
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.titleArray removeObjectAtIndex:indexPath.row];
    [self.descriptionArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text=[self.titleArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DetailViewController *detailVC=segue.destinationViewController;
    detailVC.titleString=[self.titleArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailVC.descriptionString=[self.descriptionArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    
}


@end
