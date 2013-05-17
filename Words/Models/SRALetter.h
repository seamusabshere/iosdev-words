#import "_SRALetter.h"

@interface SRALetter : _SRALetter {}
+ (NSArray *)all;
+ (NSArray *)sorted;
+ (SRALetter *)create:(NSString *)content;
+ (NSUInteger)count;
+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)prefixCount;
- (NSArray *)sortedPrefixes;
@end
