//
//  SRAStringStore.m
//  Words
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
@property (strong,readwrite,nonatomic)NSArray *firstLetters;
@end

@implementation SRAStringStore

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
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self stringsDocumentPath]]) {
      [self loadFromAppDirectory];
    } else {
      _mutableAllStrings = (NSMutableArray*)@[];
    }
  }
  return self;
}

- (BOOL)bootstrap:(NSURL *)url
{
  if ([self.mutableAllStrings count] == 0) {
    [self loadUrl:url];
    return YES;
  } else {
    return NO;
  }
}

- (void)loadFromAppDirectory
{
  NSLog(@"loading from app directory");
  NSString *path = [self stringsDocumentPath];
  self.mutableAllStrings = (NSMutableArray *)[NSArray arrayWithContentsOfFile:path];
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
  self.mutableAllStrings = (NSMutableArray*)[content componentsSeparatedByString:@"\n"];
  [self saveToAppDirectory];
  self.firstLetters = nil; // clear the cache
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
    self.firstLetters = [[memo allObjects] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  }
  return _firstLetters;
}

//ahem not thread-safe...
- (NSArray *)byFirstLetter:(NSString *)firstLetter
{
  if (!self.cachedLetter || ![self.cachedLetter isEqualToString:firstLetter]) {
    self.cachedLetter = firstLetter;
    NSArray *unsortedStrings = [self.mutableAllStrings select:^BOOL(NSString *str) {
      return ([str length] > 0 && [[str substringToIndex:1] isEqualToString:firstLetter]);
    }];
    self.cachedStrings = [unsortedStrings sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
  }
  return self.cachedStrings;
}

// this should be implemented with NSOrderedMutableSet or smth
- (void)addString:(NSString *)str
{
  if (![self.mutableAllStrings any:^BOOL(NSString *existing) { return [existing isEqualToString:str]; }]) {
    [self.mutableAllStrings addObject:str];
    [self saveToAppDirectory];
    //clear the cache
    self.cachedLetter = nil;
    self.firstLetters = nil;
  }
}

- (void)saveToAppDirectory
{
  NSLog(@"saving to app directory");
  NSString *path = [self stringsDocumentPath];
  [self.mutableAllStrings writeToFile:path atomically:YES];
}

- (NSString *)stringsDocumentPath
{
  NSArray *documentDirectories =
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                      NSUserDomainMask,
                                      YES);
  // Get the only document directory for iOS
  NSString *documentDirectory = documentDirectories[0];
  return [documentDirectory stringByAppendingPathComponent:@"strings.plist"];
}

@end
