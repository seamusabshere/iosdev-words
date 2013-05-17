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
#import "Models/SRALetter.h"
#import "Models/SRAWord.h"

@interface SRALettersTableViewController ()
@property (strong,nonatomic)NSArray* cachedLetters;
@end

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
  return [SRALetter count];
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
  SRALetter *letter = [self.letters objectAtIndex:idx];
  cell.textLabel.text = [letter valueForKey:@"content"];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%d prefixes", [letter prefixCount]];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  SRAPrefixesTableViewController *prefixesTableViewController = [[SRAPrefixesTableViewController alloc] initWithLetter:[self.letters objectAtIndex:[indexPath row]]];
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
                didAddWord:(NSString *)content {
  if ([content length] > 0) {
    [SRAWord create:content];
  }
  [self.tableView reloadData];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)letters;
{
  if (!self.cachedLetters) {
    self.cachedLetters = [SRALetter sorted];
  }
  return self.cachedLetters;
}

@end
