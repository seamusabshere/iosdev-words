//
//  SRAWordStore.h
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SRAWordStore : NSObject

+ (SRAWordStore *)sharedStore;

- (BOOL)save;
- (BOOL)bootstrap:(NSURL *)url;
- (void)load:(NSURL *)url;
- (void)add:(NSString *)word;
- (NSUInteger)count;

- (void)clearCache;
- (NSManagedObject *)findPrefix:(NSString *)str;
- (NSManagedObject *)findLetter:(NSString *)str;
- (NSArray *)letters;
- (NSArray *)prefixes;
@end
