#import "_SRAPrefix.h"

@interface SRAPrefix : _SRAPrefix {}
+ (SRAPrefix *)create:(NSString *)content;
+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate;
- (NSArray *)sortedWords;
- (NSUInteger)wordCount;
@end
