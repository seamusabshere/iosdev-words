//
//  SRAPrefixesTableViewController.m
//  Words
//
//  Created by Seamus Abshere on 5/16/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAPrefixesTableViewController.h"
#import "SRAWordsTableViewController.h"
#import "Models/SRALetter.h"
#import "Models/SRAPrefix.h"

@interface SRAPrefixesTableViewController ()
@property (strong, nonatomic)NSArray *cachedPrefixes;
@end

@implementation SRAPrefixesTableViewController
- (id)initWithLetter:(SRALetter *)letter
{
  self = [self init];
  if (self) {
    _letter = letter;
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = [NSString stringWithFormat:@"%@ prefixes", _letter.content];
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
            initWithStyle:UITableViewCellStyleSubtitle
            reuseIdentifier:@"UITableViewCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  int idx = [indexPath row];
  SRAPrefix *prefix = [self.prefixes objectAtIndex:idx];
  cell.textLabel.text = prefix.content;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d words", [prefix wordCount]];
  return cell;
}

- (NSArray *)prefixes
{
  if (!self.cachedPrefixes) {
    self.cachedPrefixes = [self.letter sortedPrefixes];
  }
  return self.cachedPrefixes;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  SRAPrefix *prefix = [self.prefixes objectAtIndex:[indexPath row]];
  SRAWordsTableViewController *wordsTableViewController = [[SRAWordsTableViewController alloc] initWithPrefix:prefix];
  [self.navigationController pushViewController:wordsTableViewController animated:YES];
  
}

@end
