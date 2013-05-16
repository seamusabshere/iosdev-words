//
//  SRAWord.h
//  Words
//
//  Created by Seamus Abshere on 5/16/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SRAWord : NSManagedObject

@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSManagedObject *letter;
@property (nonatomic, strong) NSManagedObject *prefix;

@end
