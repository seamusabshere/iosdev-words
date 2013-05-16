//
//  SRAWordStore.m
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAWordStore.h"
#import <BlocksKit/BlocksKit.h>

@interface SRAWordStore()
@property (strong,readwrite,nonatomic)NSMutableArray *mutableAllWords;
@property (strong,nonatomic)NSString *cachedLetter;
@property (strong,nonatomic)NSArray *cachedWords;
@property (strong,readwrite,nonatomic)NSArray *firstLetters;
@end

@implementation SRAWordStore

+ (SRAWordStore *)sharedStore
{
  static dispatch_once_t pred;
  static SRAWordStore *store = nil;
  dispatch_once(&pred, ^{ store = [[self alloc] init]; });
  return store;
}

- (id)init
{
  self = [super init];
  if (self) {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self wordsDocumentPath]]) {
      [self loadFromAppDirectory];
    } else {
      _mutableAllWords = (NSMutableArray*)@[];
    }
  }
  return self;
}

- (BOOL)bootstrap:(NSURL *)url
{
  if ([self.mutableAllWords count] == 0) {
    [self loadUrl:url];
    return YES;
  } else {
    return NO;
  }
}

- (void)loadFromAppDirectory
{
  NSLog(@"loading from app directory");
  NSString *path = [self wordsDocumentPath];
  self.mutableAllWords = (NSMutableArray *)[NSArray arrayWithContentsOfFile:path];
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
  self.mutableAllWords = (NSMutableArray*)[content componentsSeparatedByString:@"\n"];
  [self saveToAppDirectory];
  self.firstLetters = nil; // clear the cache
}

// inefficient? necessary?
- (NSArray *)allWords
{
  return [self.mutableAllWords copy];
}

- (NSArray *)firstLetters
{
  if (!_firstLetters) {
    NSMutableSet *memo = [NSMutableSet set];
    [self.allWords each:^(NSString *str) {
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
    NSArray *unsortedWords = [self.mutableAllWords select:^BOOL(NSString *str) {
      return ([str length] > 0 && [[str substringToIndex:1] isEqualToString:firstLetter]);
    }];
    self.cachedWords = [unsortedWords sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
  }
  return self.cachedWords;
}

// this should be implemented with NSOrderedMutableSet or smth
- (void)addString:(NSString *)str
{
  if (![self.mutableAllWords any:^BOOL(NSString *existing) { return [existing isEqualToString:str]; }]) {
    [self.mutableAllWords addObject:str];
    [self saveToAppDirectory];
    //clear the cache
    self.cachedLetter = nil;
    self.firstLetters = nil;
  }
}

- (void)saveToAppDirectory
{
  NSLog(@"saving to app directory");
  NSString *path = [self wordsDocumentPath];
  [self.mutableAllWords writeToFile:path atomically:YES];
}

- (NSString *)wordsDocumentPath
{
  NSArray *documentDirectories =
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                      NSUserDomainMask,
                                      YES);
  // Get the only document directory for iOS
  NSString *documentDirectory = documentDirectories[0];
  return [documentDirectory stringByAppendingPathComponent:@"words.plist"];
}

@end
