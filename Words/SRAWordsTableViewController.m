//
//  SRAWordsTableViewController.m
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAWordsTableViewController.h"
#import "SRAWordStore.h"

@interface SRAWordsTableViewController ()
@property (strong, nonatomic)NSArray *cachedWords;
@end

@implementation SRAWordsTableViewController

- (id)initWithPrefix:(NSManagedObject *)prefix
{
  self = [self init];
  if (self) {
    _prefix = prefix;
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = [NSString stringWithFormat:@"'%@' words", [_prefix valueForKey:@"content"]];
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
  return [self.words count];
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
  cell.textLabel.text = [[self.words objectAtIndex:[indexPath row]] valueForKey:@"content"];
  return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//  [self.tableView reloadData];
}

- (NSArray *)words
{
  if (!self.cachedWords) {
    NSArray *descriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES]];
    self.cachedWords = [[self.prefix valueForKey:@"words"] sortedArrayUsingDescriptors:descriptors];
  }
  return self.cachedWords;
}


@end
