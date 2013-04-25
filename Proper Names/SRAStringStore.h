//
//  SRAStringStore.h
//  Proper Names
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRAStringStore : NSObject
@property (strong,readonly,nonatomic)NSArray *allStrings;
@property (strong,readonly,nonatomic)NSArray *firstLetters;
+ (SRAStringStore *)sharedStore;
- (BOOL)bootstrap:(NSURL *)url; // load URL if store is empty
- (void)loadUrl:(NSURL *)url;
- (NSArray *)byFirstLetter:(NSString *)firstLetter;
- (void)addString:(NSString *)str;
@end
