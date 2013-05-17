#import "_SRAPrefix.h"

@interface SRAPrefix : _SRAPrefix {}
+ (SRAPrefix *)create:(NSString *)content;
- (NSArray *)sortedWords;
@end
