//
//  SRAStringStore.m
//  Proper Names
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAStringStore.h"
#import <BlocksKit/BlocksKit.h>

@interface SRAStringStore()
@property (strong,readwrite,nonatomic)NSMutableArray *mutableAllStrings;
@property (strong,nonatomic)NSString *cachedLetter;
@property (strong,nonatomic)NSArray *cachedStrings;
@end

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
    _mutableAllStrings = (NSMutableArray*)@[];
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
  _mutableAllStrings = (NSMutableArray*)[content componentsSeparatedByString:@"\n"];
  _firstLetters = nil; // clear the cache
}

// inefficient? necessary?
- (NSArray *)allStrings
{
  return [self.mutableAllStrings copy];
}

- (NSArray *)firstLetters
{
  if (!_firstLetters) {
    NSMutableSet *memo = [NSMutableSet set];
    [self.allStrings each:^(NSString *str) {
      if ([str length] > 0) {
        [memo addObject:[str substringToIndex:1]];
      }
    }];
    _firstLetters = [[memo allObjects] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  }
  return _firstLetters;
}

//ahem not thread-safe...
- (NSArray *)byFirstLetter:(NSString *)firstLetter
{
  if (!self.cachedLetter || ![self.cachedLetter isEqualToString:firstLetter]) {
    NSLog(@"regen %@", firstLetter);
    self.cachedLetter = firstLetter;
    NSArray *unsortedStrings = [self.mutableAllStrings select:^BOOL(NSString *str) {
      return ([str length] > 0 && [[str substringToIndex:1] isEqualToString:firstLetter]);
    }];
    self.cachedStrings = [unsortedStrings sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
  }
  NSLog(@"list %@", firstLetter);
  return self.cachedStrings;
}

// this should be implemented with NSOrderedMutableSet or smth
- (void)addString:(NSString *)str
{
  if (![self.mutableAllStrings any:^BOOL(NSString *existing) { return [existing isEqualToString:str]; }]) {
    [self.mutableAllStrings addObject:str];
    //clear the cache
    _cachedLetter = nil;
    _firstLetters = nil;
  }
}

@end
