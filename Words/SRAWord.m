//
//  SRAWord.m
//  Words
//
//  Created by Seamus Abshere on 5/16/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAWord.h"

static NSMutableDictionary *letters;
static NSMutableDictionary *prefixes;

@implementation SRAWord

@dynamic content;
@dynamic letter;
@dynamic prefix;

+ (NSManagedObject *)letter:(NSString *)str inManagedObjectContext:(NSManagedObjectContext *)context
{
  if (!letters) {
    letters = [[NSMutableDictionary alloc] init];
  }
  NSString *letterStr = [str substringToIndex:1];
  NSManagedObject *letter = [letters objectForKey:letterStr];
  if (!letter) {
//    NSLog(@"missL - %@", letterStr);
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"SRALetter" inManagedObjectContext:context];;
    request.predicate = [NSPredicate predicateWithFormat:@"content = %@", letterStr];
    NSError * error = nil;
    [context executeFetchRequest:request error:&error];
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Letter fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    if ([result count] == 0) {
      letter = [NSEntityDescription insertNewObjectForEntityForName:@"SRALetter" inManagedObjectContext:context];
      // can't i use a setter?
      [letter setValue:letterStr forKey:@"content"];
    } else {
      letter = [result objectAtIndex:0];
    }
    [letters setObject:letter forKey:letterStr];
//  } else {
//    NSLog(@"hitL - %@", letterStr);
  }
  return letter;
}

+ (NSManagedObject *)prefix:(NSString *)str inManagedObjectContext:(NSManagedObjectContext *)context
{
  if (!prefixes) {
    prefixes = [[NSMutableDictionary alloc] init];
  }
  int prefixLength;
  int maxPrefixLength = [str length];
  prefixLength = (maxPrefixLength >= 3) ? 3 : maxPrefixLength;
  NSString *prefixStr = [str substringToIndex:prefixLength];
  NSManagedObject *prefix = [prefixes objectForKey:prefixStr];
  if (!prefix) {
//    NSLog(@"missP - %@", prefixStr);
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"SRAPrefix" inManagedObjectContext:context];;
    request.predicate = [NSPredicate predicateWithFormat:@"content = %@", prefixStr];
    NSError * error = nil;
    [context executeFetchRequest:request error:&error];
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Prefix fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    if ([result count] == 0) {
      prefix = [NSEntityDescription insertNewObjectForEntityForName:@"SRAPrefix" inManagedObjectContext:context];
      // can't i use a setter?
      [prefix setValue:prefixStr forKey:@"content"];
    } else {
      prefix = [result objectAtIndex:0];
    }
    [prefixes setObject:prefix forKey:prefixStr];
//  } else {
//    NSLog(@"hitP - %@", prefixStr);
  }
  return prefix;
}

+ (void)cleanup
{
  [letters removeAllObjects];
  [prefixes removeAllObjects];
}

- (void)didChangeValueForKey:(NSString *)key
{
  if (![key isEqualToString:@"content"]) {
    return;
  }
  NSString *content = self.content;
  self.letter = [SRAWord letter:content inManagedObjectContext:self.managedObjectContext];
  self.prefix = [SRAWord prefix:content inManagedObjectContext:self.managedObjectContext];
}

@end
