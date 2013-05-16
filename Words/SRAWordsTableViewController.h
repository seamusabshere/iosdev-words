//
//  SRAWordsTableViewController.h
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SRAWordsTableViewController : UITableViewController
@property (strong,readonly,nonatomic) NSManagedObject* prefix;
- (id)initWithPrefix:(NSManagedObject *)prefix;
@end
