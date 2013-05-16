//
//  SRAPrefixesTableViewController.m
//  Words
//
//  Created by Seamus Abshere on 5/16/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAPrefixesTableViewController.h"
#import "SRAWordsTableViewController.h"

@interface SRAPrefixesTableViewController ()
@property (strong, nonatomic)NSArray *cachedPrefixes;
@end

@implementation SRAPrefixesTableViewController
- (id)initWithLetter:(NSManagedObject *)letter
{
  self = [self init];
  if (self) {
    _letter = letter;
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = [NSString stringWithFormat:@"%@ prefixes", [_letter valueForKey:@"content"]];
  }
  return self;
}

- (id)init
{
  return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
  return [self init];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.prefixes count];
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
  NSManagedObject *prefix = [self.prefixes objectAtIndex:idx];
  cell.textLabel.text = [prefix valueForKey:@"content"];
  return cell;
}

- (NSArray *)prefixes
{
  if (!self.cachedPrefixes) {
    NSArray *descriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES]];
    self.cachedPrefixes = [[[self.letter valueForKey:@"words"] valueForKeyPath:@"@distinctUnionOfObjects.prefix"] sortedArrayUsingDescriptors:descriptors];
  }
  return self.cachedPrefixes;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSManagedObject *prefix = [self.prefixes objectAtIndex:[indexPath row]];
  SRAWordsTableViewController *wordsTableViewController = [[SRAWordsTableViewController alloc] initWithPrefix:prefix];
  [self.navigationController pushViewController:wordsTableViewController animated:YES];
  
}

@end
