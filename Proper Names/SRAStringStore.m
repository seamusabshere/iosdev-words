//
//  SRAStringStore.m
//  Proper Names
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAStringStore.h"
#import <BlocksKit/BlocksKit.h>

@implementation SRAStringStore

@synthesize firstLetters=_firstLetters;

+ (SRAStringStore *)sharedStore
{
  static dispatch_once_t pred;
  static SRAStringStore *store = nil;
  dispatch_once(&pred, ^{ store = [[self alloc] init]; });
  return store;
}

- (id)init
{
  self = [super init];
  if (self) {
    // a placeholder until you load something
    _allStrings = @[];
  }
  return self;
}

// expects one string per line
- (void)loadUrl:(NSURL *) url
{
  NSError *error;
  NSString *content = [NSString stringWithContentsOfURL:url
                                encoding:NSUTF8StringEncoding
                                error:&error];
  if (error) {
    NSLog(@"error %@", [error localizedDescription]);
  }
  _allStrings = [content componentsSeparatedByString:@"\n"];
  // clear the cache
  _firstLetters = nil;
}

- (NSArray *)firstLetters
{
  if (!_firstLetters) {
    NSLog(@"recalc firstLetters");
    NSMutableSet *memo = [NSMutableSet set];
    [self.allStrings each:^(NSString *str) {
      if ([str length] > 0) {
        [memo addObject:[str substringToIndex:1]];
      }
    }];
    NSLog(@"firstLetters");
    _firstLetters = [[memo allObjects] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  }
  return _firstLetters;
}

- (NSArray *)byFirstLetter:(NSString *)firstLetter
{
  return [self.allStrings select:^BOOL(NSString *str) {
    return ([str length] > 0 && [[str substringToIndex:1] isEqualToString:firstLetter]);
  }];
}

@end
