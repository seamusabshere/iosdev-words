//
//  SRANewWordController.m
//  Words
//
//  Created by Seamus Abshere on 4/11/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRANewWordController.h"

@interface SRANewWordController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation SRANewWordController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                   target:self
                                   action:@selector(save:)];
      self.navigationItem.rightBarButtonItem = doneItem;
      
      UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(cancel:)];
      self.navigationItem.leftBarButtonItem = cancelItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save:(id)sender
{
  [self.delegate newWordController:self didAddWord:self.textField.text];
}

- (void)cancel:(id)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [self.delegate newWordController:self didAddWord:self.textField.text];
  [textField resignFirstResponder];
  return YES;
}

@end
