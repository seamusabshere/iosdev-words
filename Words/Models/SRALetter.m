#import "SRALetter.h"
#import "SRAPrefix.h"

@interface SRALetter ()
@end

@implementation SRALetter

+ (NSArray *)all
{
  NSManagedObjectContext *moc = AppDelegate.managedObjectContext; 
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = [self entityInManagedObjectContext:moc];
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor
                                      sortDescriptorWithKey:@"content"
                                      ascending:YES];
  request.sortDescriptors = @[sortDescriptor];
  NSError * error = nil;
  [moc executeFetchRequest:request error:&error];
  NSArray *result = [moc executeFetchRequest:request error:&error];
  if (!result) {
    [NSException raise:@"Letter fetch failed" format:@"Reason: %@", [error localizedDescription]];
  }
  return result;
}

+ (NSArray *)sorted
{
  return [self all];
}

+ (SRALetter *)create:(NSString *)content
{
  NSManagedObjectContext *moc = AppDelegate.managedObjectContext;
  NSString *letterStr = [content substringToIndex:1];
  SRALetter *letter;
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  request.entity = [self entityInManagedObjectContext:moc];
  request.predicate = [NSPredicate predicateWithFormat:@"content = %@", letterStr];
  NSError * error = nil;
  [moc executeFetchRequest:request error:&error];
  NSArray *result = [moc executeFetchRequest:request error:&error];
  if (!result) {
    [NSException raise:@"Letter fetch failed" format:@"Reason: %@", [error localizedDescription]];
  }
  if ([result count] == 0) {
    letter = [self insertInManagedObjectContext:moc];
    letter.content = letterStr;
  } else {
    letter = [result objectAtIndex:0];
  }
  return letter;
}

+ (NSUInteger)count
{
  return [self countWithPredicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
}

// http://stackoverflow.com/questions/1134289/cocoa-core-data-efficient-way-to-count-entities
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

// one way of looking up a to-many through
- (NSArray *)sortedPrefixes
{
  NSArray *descriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"content" ascending:YES]];
  return [[self.words valueForKeyPath:@"@distinctUnionOfObjects.prefix"] sortedArrayUsingDescriptors:descriptors];
}

// i guess the way i should have done it - don't need to go through words
- (NSUInteger)prefixCount
{
  return [SRAPrefix countWithPredicate:[NSPredicate predicateWithFormat:@"content BEGINSWITH %@", self.content]];
}

@end
