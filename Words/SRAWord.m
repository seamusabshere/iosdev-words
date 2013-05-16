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
  if (![key isEqualToString:@"content"]) {
    return;
  }
  NSString *content = self.content;
  self.letter = [SRAWordStore letter:content];
  self.prefix = [SRAWordStore prefix:content];
}

@end
