//
//  SRANewProperNameController.h
//  Proper Names
//
//  Created by Seamus Abshere on 4/11/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRANewProperNameControllerDelegate.h"

@interface SRANewProperNameController : UIViewController <UITextFieldDelegate>
@property(nonatomic,assign)    id <SRANewProperNameControllerDelegate> delegate;
@end
