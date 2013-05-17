#import "SRAWord.h"
#import "SRALetter.h"
#import "SRAPrefix.h"
#import <BlocksKit/BlocksKit.h>

@interface SRAWord ()

// Private interface goes here.

@end

@implementation SRAWord

+ (SRAWord *)create:(NSString *)content
{
  SRAWord *word = [self insertInManagedObjectContext:AppDelegate.managedObjectContext];
  SRALetter *letter = [SRALetter create:content];
  SRAPrefix *prefix = [SRAPrefix create:content];
  word.content = content;
  word.letter = letter;
  word.prefix = prefix;
  return word;
}

+ (BOOL)bootstrap:(NSURL *)url
{
  if ([self count] == 0) {
    [self load:url];
    return YES;
  } else {
    return NO;
  }
}

// expects one string per line
+ (void)load:(NSURL *) url
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
      [self create:str];      
    }
  }];
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


@end
