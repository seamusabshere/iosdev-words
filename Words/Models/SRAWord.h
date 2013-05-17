#import "_SRAWord.h"

@interface SRAWord : _SRAWord {}
+ (BOOL)bootstrap:(NSURL *)url;
+ (SRAWord *)create:(NSString *)content;
+ (NSUInteger)count;
+ (NSUInteger)countWithPredicate:(NSPredicate *)predicate;
@end
