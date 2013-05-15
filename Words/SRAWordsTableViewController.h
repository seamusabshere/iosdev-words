//
//  SRAWordsTableViewController.h
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRAWordsTableViewController : UITableViewController
- (id)initWithFirstLetter:(NSString *)firstLetter;
@property (strong,readonly,nonatomic) NSString* firstLetter;
@end