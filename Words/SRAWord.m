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

- (void)didChangeValueForKey:(NSString *)key
{
  if ([key isEqualToString:@"content"]) {
    NSString *content = self.content;
    self.letter = [[SRAWordStore sharedStore] findLetter:content];
    self.prefix = [[SRAWordStore sharedStore] findPrefix:content];
  }
}

@end
