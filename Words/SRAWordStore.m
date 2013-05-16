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
@property (strong,readwrite,nonatomic)NSMutableArray *allWords;
@property (strong,nonatomic)NSArray *cachedFirstLetters;
@property (strong,nonatomic)NSString *cachedLetter;
@property (strong,nonatomic)NSArray *cachedWords;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObjectModel *model;
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
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[self wordsArchivePath]]) {
//      [self loadFromAppDirectory];
//    } else {
//      _allWords = (NSMutableArray*)@[];
//    }
    // Read in Homepwner.xcdatamodeld
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Create the store coordinator
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    
    NSString *path = [self wordsArchivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    
    NSError *error = nil;
    
    // Configure the store coordinator
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:nil
                                                          error:&error]) {
      [NSException raise:@"Open Failed"
                  format:@"Reason: %@", [error localizedDescription]];
    }
    
    // Create the managed object context
    _context = [[NSManagedObjectContext alloc] init];
    _context.persistentStoreCoordinator = persistentStoreCoordinator;
    
    // The managed object context can manage undo, but we don't need it
    _context.undoManager = nil;
  }
  return self;
}

- (NSArray *)findWithPredicate:(NSPredicate *)predicate
{
  // This is like a SQL select statement
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  
  // This is like the 'from' part of the SQL select statement
  NSEntityDescription *entity = [self.model entitiesByName][@"SRAWord"];
  request.entity = entity;
  
  // This is like the 'order by' clause of the SQL select statement
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor
                                      sortDescriptorWithKey:@"value"
                                      ascending:YES];
  request.sortDescriptors = @[sortDescriptor];
  
  request.predicate = predicate;
  
  // Execute the request
  NSError *error = nil;
  NSArray *result = [self.context executeFetchRequest:request
                                                error:&error];
  // If the fetch fails
  if (!result) {
    [NSException raise:@"Fetch failed"
                format:@"Reason: %@", [error localizedDescription]];
  }
  
  return [[NSMutableArray alloc] initWithArray:result];
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

- (BOOL)bootstrap:(NSURL *)url
{
  if ([self countWithPredicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]] == 0) {
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
      [self add:str autoSave:NO];
    }
  }];
  [self save];
}

- (NSArray *)firstLetters
{
  if (!self.cachedFirstLetters) {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"SRALetter" inManagedObjectContext:self.context];;
    request.resultType = NSDictionaryResultType;
    request.propertiesToFetch = @[@"content"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"content"
                                        ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    NSError *error = nil;
    NSArray *result = [self.context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Letter fetch failed" format:@"Reason: %@", [error localizedDescription]];
    }
    self.cachedFirstLetters = result;
  }
  return self.cachedFirstLetters;
}

//ahem not thread-safe...
- (NSArray *)byFirstLetter:(NSString *)firstLetter
{
  if (!self.cachedLetter || ![self.cachedLetter isEqualToString:firstLetter]) {
    self.cachedLetter = firstLetter;
    NSArray *unsortedWords = [self.allWords select:^BOOL(NSString *str) {
      return ([str length] > 0 && [[str substringToIndex:1] isEqualToString:firstLetter]);
    }];
    self.cachedWords = [unsortedWords sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
  }
  return self.cachedWords;
}

- (void)add:(NSString *)str autoSave:(BOOL)autoSave
{
  SRAWord *word = [NSEntityDescription insertNewObjectForEntityForName:@"SRAWord"
                                                inManagedObjectContext:self.context];
  word.content = str;
  if (autoSave) {
    [self save];
    //clear the cache
    self.cachedLetter = nil;
  }
}

- (void)add:(NSString *)str
{
  [self add:str autoSave:YES];
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
  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                      NSUserDomainMask,
                                      YES);
  // Get the only document directory for iOS
  NSString *documentDirectory = documentDirectories[0];
  return [documentDirectory stringByAppendingPathComponent:@"words.sqlite"];
}

@end
