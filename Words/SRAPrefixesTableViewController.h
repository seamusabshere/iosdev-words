//
//  SRAPrefixesTableViewController.h
//  Words
//
//  Created by Seamus Abshere on 5/16/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Models/SRALetter.h"

@interface SRAPrefixesTableViewController : UITableViewController
- (id)initWithLetter:(SRALetter *)letter;
@property (strong,readonly,nonatomic) SRALetter* letter;
@end
