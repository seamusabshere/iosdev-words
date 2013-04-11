//
//  SRANewProperNameControllerDelegate.h
//  Proper Names
//
//  Created by Seamus Abshere on 4/11/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SRANewProperNameController;

@protocol SRANewProperNameControllerDelegate <NSObject>
- (void)newProperNameController:(SRANewProperNameController *)controller didAddProperName:(NSString *)properName;
@end
