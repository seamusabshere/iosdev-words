//
//  SRAWordStore.m
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAWordStore.h"
#import "SRAWord.h"
#import <BlocksKit/BlocksKit.h>

@interface SRAWordStore()
@property (strong,nonatomic)NSArray *cachedLetters;
@property (strong,nonatomic)NSArray *cachedPrefixes;
@property (strong,nonatomic)NSMutableDictionary *cachedFindLetter;
@property (strong,nonatomic)NSMutableDictionary *cachedFindPrefix;
@property (strong,nonatomic)NSManagedObjectContext *context;
@property (strong,nonatomic)NSManagedObjectModel *model;
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
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    NSString *path = [self wordsArchivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:nil
                                                          error:&error]) {
      [NSException raise:@"Open Failed"
                  format:@"Reason: %@", [error localizedDescription]];
    }
    _context = [[NSManagedObjectContext alloc] init];
    _context.persistentStoreCoordinator = persistentStoreCoordinator;
    _context.undoManager = nil;
  }
  return self;
}

- (NSArray *)letters
{
  if (!self.cachedLetters) {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"SRALetter" inManagedObjectContext:self.context];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"content"
                                        ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    NSError * error = nil;
    [self.context executeFetchRequest:request error:&error];
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Letter fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    self.cachedLetters = result;
  }
  return self.cachedLetters;
}

- (NSManagedObject *)findLetter:(NSString *)str
{
  if (!self.cachedFindLetter) {
    self.cachedFindLetter = [[NSMutableDictionary alloc] init];
  }
  NSString *letterStr = [str substringToIndex:1];
  NSManagedObject *letter = [self.cachedFindLetter objectForKey:letterStr];
  if (!letter) {
    //    NSLog(@"missL - %@", letterStr);
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"SRALetter" inManagedObjectContext:self.context];
    request.predicate = [NSPredicate predicateWithFormat:@"content = %@", letterStr];
    NSError * error = nil;
    [self.context executeFetchRequest:request error:&error];
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Letter fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    if ([result count] == 0) {
      letter = [NSEntityDescription insertNewObjectForEntityForName:@"SRALetter" inManagedObjectContext:self.context];
      // can't i use a setter?
      [letter setValue:letterStr forKey:@"content"];
    } else {
      letter = [result objectAtIndex:0];
    }
    [self.cachedFindLetter setObject:letter forKey:letterStr];
    //  } else {
    //    NSLog(@"hitL - %@", letterStr);
  }
  return letter;
}

- (NSArray *)prefixes
{
  if (!self.cachedPrefixes) {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"SRAPrefix" inManagedObjectContext:self.context];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"content"
                                        ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    NSError * error = nil;
    [self.context executeFetchRequest:request error:&error];
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Prefix fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    self.cachedPrefixes = result;
  }
  return self.cachedPrefixes;
}

- (NSManagedObject *)findPrefix:(NSString *)str
{
  if (!self.cachedFindPrefix) {
    self.cachedFindPrefix = [[NSMutableDictionary alloc] init];
  }
  int prefixLength;
  int maxPrefixLength = [str length];
  prefixLength = (maxPrefixLength >= 3) ? 3 : maxPrefixLength;
  NSString *prefixStr = [str substringToIndex:prefixLength];
  NSManagedObject *prefix = [self.cachedFindPrefix objectForKey:prefixStr];
  if (!prefix) {
    //    NSLog(@"missP - %@", prefixStr);
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"SRAPrefix" inManagedObjectContext:self.context];
    request.predicate = [NSPredicate predicateWithFormat:@"content = %@", prefixStr];
    NSError * error = nil;
    [self.context executeFetchRequest:request error:&error];
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Prefix fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    if ([result count] == 0) {
      prefix = [NSEntityDescription insertNewObjectForEntityForName:@"SRAPrefix" inManagedObjectContext:self.context];
      // can't i use a setter?
      [prefix setValue:prefixStr forKey:@"content"];
    } else {
      prefix = [result objectAtIndex:0];
    }
    [self.cachedFindPrefix setObject:prefix forKey:prefixStr];
    //  } else {
    //    NSLog(@"hitP - %@", prefixStr);
  }
  return prefix;
}

- (void)clearCache
{
  self.cachedLetters = nil;
  self.cachedPrefixes = nil;
  [self.cachedFindLetter removeAllObjects];
  [self.cachedFindPrefix removeAllObjects];
}

- (BOOL)bootstrap:(NSURL *)url
{
  if ([self count] == 0) {
    [self load:url];
    return YES;
  } else {
    return NO;
  }
}

// expects one string per line
- (void)load:(NSURL *) url
{
  NSError *error;
  NSString *content = [NSString stringWithContentsOfURL:url
                                encoding:NSUTF8StringEncoding
                                error:&error];
  if (error) {
    NSLog(@"error %@", [error localizedDescription]);
  }
  [[content componentsSeparatedByString:@"\n"] each:^(NSString *str) {
    if ([str length] > 0) {
      [self add:str immediate:NO];
    }
  }];
  [self save];
}

- (void)add:(NSString *)str immediate:(BOOL)immediate
{
  SRAWord *word = [NSEntityDescription insertNewObjectForEntityForName:@"SRAWord"
                                                inManagedObjectContext:self.context];
  word.content = str;
  if (immediate) {
    [self save];
    [self clearCache];
  }
}

- (void)add:(NSString *)str
{
  [self add:str immediate:YES];
}

- (BOOL)save
{
  NSError *error = nil;
  BOOL successful = [self.context save:&error];
  if (!successful) {
    NSLog(@"Error saving: %@", [error localizedDescription]);
  }
  return successful;
}

- (NSString *)wordsArchivePath
{
  NSArray *documentDirectories =
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
  NSString *documentDirectory = documentDirectories[0];
  return [documentDirectory stringByAppendingPathComponent:@"words.sqlite"];
}

- (NSUInteger)count
{
  return [self countWithPredicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
}

// http://stackoverflow.com/questions/1134289/cocoa-core-data-efficient-way-to-count-entities
- (NSUInteger)countWithPredicate:(NSPredicate *)predicate
{
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [self.model entitiesByName][@"SRAWord"];
  request.entity = entity;
  request.includesSubentities = NO;
  request.predicate = predicate;
  NSError *error = nil;
  NSUInteger count = [self.context countForFetchRequest:request
                                                  error:&error];
  if (count == NSNotFound) {
    [NSException raise:@"Count failed"
                format:@"Reason: %@", [error localizedDescription]];
  }
  return count;
}

@end
