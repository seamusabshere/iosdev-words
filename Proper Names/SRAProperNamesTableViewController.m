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
- (id)init
{
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    SRAStringStore *sharedStore = [SRAStringStore sharedStore];
    NSURL *properNamesURL = [[NSBundle mainBundle] URLForResource:@"propernames" withExtension:@"txt"];
    [sharedStore loadUrl:properNamesURL];
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
  return [[[SRAStringStore sharedStore] allStrings] count];
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
  NSString *text = [[[SRAStringStore sharedStore] allStrings] objectAtIndex:idx];
  cell.textLabel.text = [NSString stringWithFormat:@"%d: %@", idx, text];
  return cell;
}

@end
