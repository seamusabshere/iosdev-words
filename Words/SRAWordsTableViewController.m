//
//  SRAWordsTableViewController.m
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAWordsTableViewController.h"
#import "SRAWordStore.h"

@implementation SRAWordsTableViewController
- (id)initWithPrefix:(NSManagedObject *)prefix
{
  self = [self init];
  if (self) {
    _prefix = prefix;
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = [NSString stringWithFormat:@"%@ words", [_prefix valueForKey:@"content"]];
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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [[self.prefix valueForKey:@"words"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
  if (!cell) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:@"UITableViewCell"];
  }
  int idx = [indexPath row];
  NSArray *words = [[self.prefix valueForKey:@"words"] allObjects];
  NSString *text = [[words objectAtIndex:idx] valueForKey:@"content"];
  cell.textLabel.text = [NSString stringWithFormat:@"%d: %@", idx, text];
  return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//  [self.tableView reloadData];
}


@end
