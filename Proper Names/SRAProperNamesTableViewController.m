//
//  SRAProperNamesTableViewController.m
//  Proper Names
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAProperNamesTableViewController.h"
#import "SRAStringStore.h"

@implementation SRAProperNamesTableViewController
- (id)initWithFirstLetter:(NSString *)firstLetter
{
  self = [self init];
  if (self) {
    _firstLetter = firstLetter;
  }
  return self;  
}

- (id)init
{
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    //custom
  }
  return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
  return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [[[SRAStringStore sharedStore] byFirstLetter:self.firstLetter] count];
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
  NSString *text = [[[SRAStringStore sharedStore] byFirstLetter:self.firstLetter] objectAtIndex:idx];
  cell.textLabel.text = [NSString stringWithFormat:@"%d: %@", idx, text];
  return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//  [self.tableView reloadData];
  UINavigationItem *navigationItem = self.navigationItem;
  navigationItem.title = [NSString stringWithFormat:@"Letter %@", self.firstLetter];

}


@end
