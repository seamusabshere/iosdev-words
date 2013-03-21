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
+ (SRAStringStore *)sharedStore;
- (void)loadUrl:(NSURL *)url;
@end
