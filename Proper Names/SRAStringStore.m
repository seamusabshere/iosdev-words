//
//  SRAStringStore.m
//  Proper Names
//
//  Created by Seamus Abshere on 3/21/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import "SRAStringStore.h"

@implementation SRAStringStore
+ (SRAStringStore *)sharedStore
{
  static dispatch_once_t pred;
  static SRAStringStore *store = nil;
  dispatch_once(&pred, ^{ store = [[self alloc] init]; });
  return store;
}

- (id)init
{
  self = [super init];
  if (self) {
    // a placeholder until you load something
    _allStrings = @[];
  }
  return self;
}

// expects one string per line
- (void)loadUrl:(NSURL *) url
{
  NSError *error;
  NSString *content = [NSString stringWithContentsOfURL:url
                                encoding:NSUTF8StringEncoding
                                error:&error];
  if (error) {
    NSLog(@"error %@", [error localizedDescription]);
  }
  _allStrings = [content componentsSeparatedByString:@"\n"];
}

@end
