#import "SRAPrefix.h"
#import "SRAWord.h"


@interface SRAPrefix ()

// Private interface goes here.

@end


@implementation SRAPrefix

+ (SRAPrefix *)create:(NSString *)content
{
  NSManagedObjectContext *moc = AppDelegate.managedObjectContext;
  int prefixLength;
  int maxPrefixLength = [content length];
  prefixLength = (maxPrefixLength >= 3) ? 3 : maxPrefixLength;
  NSString *prefixStr = [content substringToIndex:prefixLength];
  SRAPrefix *prefix;
  //    NSLog(@"missL - %@", prefixStr);
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = [self entityInManagedObjectContext:moc];
  request.predicate = [NSPredicate predicateWithFormat:@"content = %@", prefixStr];
  NSError * error = nil;
  [moc executeFetchRequest:request error:&error];
  NSArray *result = [moc executeFetchRequest:request error:&error];
  if (!result) {
    [NSException raise:@"Prefix fetch failed" format:@"Reason: %@", [error localizedDescription]];
  }
  if ([result count] == 0) {
    prefix = [self insertInManagedObjectContext:moc];
    prefix.content = prefixStr;
  } else {
    prefix = [result objectAtIndex:0];
  }
  return prefix;
}

+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate
{
  NSManagedObjectContext *moc = AppDelegate.managedObjectContext;
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [self entityInManagedObjectContext:moc];
  request.entity = entity;
  request.includesSubentities = NO;
  request.predicate = predicate;
  NSError *error = nil;
  NSUInteger count = [moc countForFetchRequest:request
                                         error:&error];
  if (count == NSNotFound) {
    [NSException raise:@"Count failed"
                format:@"Reason: %@", [error localizedDescription]];
  }
  return count;
}

- (NSArray *)sortedWords
{
  NSArray *descriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"content" ascending:YES]];
  return [self.words sortedArrayUsingDescriptors:descriptors];
}

- (NSUInteger)wordCount
{
  return [SRAWord countWithPredicate:[NSPredicate predicateWithFormat:@"content BEGINSWITH %@", self.content]];
}

@end
