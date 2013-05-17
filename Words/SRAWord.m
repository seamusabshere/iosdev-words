//
//  SRAWord.m
//  Words
//
//  Created by Seamus Abshere on 5/16/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAWord.h"
#import "SRAWordStore.h"

@implementation SRAWord

@dynamic content;
@dynamic letter;
@dynamic prefix;

+ (SRAWord *)safeInsert:(NSString *)content inManagedObjectContext:context
{
  SRAWord *word = [NSEntityDescription insertNewObjectForEntityForName:@"SRAWord"
                                                inManagedObjectContext:context];
  NSManagedObject *letter = [[SRAWordStore sharedStore] findLetter:content];
  NSManagedObject *prefix = [[SRAWordStore sharedStore] findPrefix:content];
  word.content = content;
  word.letter = letter;
  word.prefix = prefix;
  return word;
}

@end
