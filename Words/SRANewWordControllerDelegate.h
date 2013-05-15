//
//  SRANewWordControllerDelegate.h
//  Words
//
//  Created by Seamus Abshere on 4/11/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRANewWordController;

@protocol SRANewWordControllerDelegate <NSObject>
- (void)newWordController:(SRANewWordController *)controller didAddWord:(NSString *)properName;
@end
