#import "_SRAWord.h"

@interface SRAWord : _SRAWord {}
+ (BOOL)bootstrap:(NSURL *)url;
+ (SRAWord *)create:(NSString *)content;
+ (NSUInteger)count;
@end
