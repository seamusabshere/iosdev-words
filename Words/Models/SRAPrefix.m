#import "SRAPrefix.h"


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

- (NSArray *)sortedWords
{
  NSArray *descriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"content" ascending:YES]];
  return [self.words sortedArrayUsingDescriptors:descriptors];
}

@end
