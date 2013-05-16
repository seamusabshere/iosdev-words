//
//  SRAWordStore.h
//  Words
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRAWordStore : NSObject

+ (SRAWordStore *)sharedStore;
- (BOOL)save;
- (BOOL)bootstrap:(NSURL *)url;
- (void)load:(NSURL *)url;
- (NSArray *)firstLetters;
- (NSArray *)byFirstLetter:(NSString *)firstLetter;
- (void)add:(NSString *)word;

//- (NSArray *)prefixesForLetter:(NSString *)letter;
//- (NSArray *)wordsForPrefix:(NSString *)prefix;

- (NSUInteger)countWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)prefixCount;
@end
