//
//  SRALettersTableViewController.m
//  Proper Names
//
//  Created by Seamus Abshere on 4/10/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRALettersTableViewController.h"
#import "SRANewProperNameController.h"
#import "SRAProperNamesTableViewController.h"
#import "SRAStringStore.h"

@implementation SRALettersTableViewController

- (id)init
{
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Letters";
    UIBarButtonItem *addNewItemBarButton = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                            target:self
                                            action:@selector(addNewProperName:)];
    self.navigationItem.rightBarButtonItem = addNewItemBarButton;
  }
  return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[[SRAStringStore sharedStore] firstLetters] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  if (!cell) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:@"UITableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  int idx = [indexPath row];
  cell.textLabel.text = [[[SRAStringStore sharedStore] firstLetters] objectAtIndex:idx];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *selectedLetter = [[[SRAStringStore sharedStore] firstLetters] objectAtIndex:[indexPath row]];
  SRAProperNamesTableViewController *properNamesTableViewController = [[SRAProperNamesTableViewController alloc] initWithFirstLetter:selectedLetter];
  [self.navigationController pushViewController:properNamesTableViewController animated:YES];
}

- (IBAction)addNewProperName:(id)sender {
  SRANewProperNameController *newProperNameController = [[SRANewProperNameController alloc] init];
  newProperNameController.delegate = self;
  
  [self presentViewController:newProperNameController
                     animated:YES
                   completion:nil];
}

- (void)newProperNameController:(SRANewProperNameController *)controller
                didAddProperName:(NSString *)properName {
  if ([properName length] > 0) {
    [[SRAStringStore sharedStore] addString:properName];
  }
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
