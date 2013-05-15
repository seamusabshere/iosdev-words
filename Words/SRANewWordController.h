//
//  SRANewWordController.h
//  Words
//
//  Created by Seamus Abshere on 4/11/13.
//  Copyright (c) 2013 Seamus Abshere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRANewWordControllerDelegate.h"

@interface SRANewWordController : UIViewController <UITextFieldDelegate>
@property(nonatomic,assign)    id <SRANewWordControllerDelegate> delegate;
@end
