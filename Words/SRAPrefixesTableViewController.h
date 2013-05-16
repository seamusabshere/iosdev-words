//
//  SRAPrefixesTableViewController.h
//  Words
//
//  Created by Seamus Abshere on 5/16/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SRAPrefixesTableViewController : UITableViewController
- (id)initWithLetter:(NSManagedObject *)letter;
@property (strong,readonly,nonatomic) NSManagedObject* letter;
@end
