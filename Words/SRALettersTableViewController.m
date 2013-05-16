//
//  SRALettersTableViewController.m
//  Words
//
//  Created by Seamus Abshere on 4/10/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRALettersTableViewController.h"
#import "SRAPrefixesTableViewController.h"
#import "SRANewWordController.h"
#import "SRAWordsTableViewController.h"
#import "SRAWord.h"
#import "SRAWordStore.h"

@implementation SRALettersTableViewController

- (id)init
{
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Letters";
    UIBarButtonItem *addWordBarButton = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                            target:self
                                            action:@selector(addWord:)];
    self.navigationItem.rightBarButtonItem = addWordBarButton;
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
  return [[[SRAWordStore sharedStore] firstLetters] count];
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
  cell.textLabel.text = [[[SRAWordStore sharedStore] firstLetters] objectAtIndex:idx];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *selectedLetter = [[[SRAWordStore sharedStore] firstLetters] objectAtIndex:[indexPath row]];
  SRAPrefixesTableViewController *prefixesTableViewController = [[SRAPrefixesTableViewController alloc] initWithLetter:[SRAWordStore letter:selectedLetter]];
  [self.navigationController pushViewController:prefixesTableViewController animated:YES];
}

- (IBAction)addWord:(id)sender {
  SRANewWordController *newWordController = [[SRANewWordController alloc] init];
  newWordController.delegate = self;
  UINavigationController *navigationController =
  [[UINavigationController alloc] initWithRootViewController:newWordController];
  navigationController.modalPresentationStyle = UIModalPresentationFormSheet;

  [self presentViewController:navigationController
                     animated:YES
                   completion:nil];
}

- (void)newWordController:(SRANewWordController *)controller
                didAddWord:(NSString *)word {
  if ([word length] > 0) {
    [[SRAWordStore sharedStore] add:word];
  }
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
