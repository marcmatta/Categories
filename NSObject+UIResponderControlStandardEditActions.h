//
//  NSObject+UIResponderAllowStandardEditActions.h
//  test
//
//  Created by Marc on 2/13/14.
//  Copyright (c) 2014 Marc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, UIResponderControlStandardEditActions) {
    UIResponderControlAllowDefaultActions NS_ENUM_AVAILABLE_IOS(3_0)= 0 ,
    UIResponderControlAllowCutAction NS_ENUM_AVAILABLE_IOS(3_0)= (1 << 0) ,
    UIResponderControlAllowCopyAction NS_ENUM_AVAILABLE_IOS(3_0)= (1 << 1) ,
    UIResponderControlAllowPasteAction NS_ENUM_AVAILABLE_IOS(3_0)= (1 << 2) ,
    UIResponderControlAllowSelectAction NS_ENUM_AVAILABLE_IOS(3_0)= (1 << 3) ,
    UIResponderControlAllowSelectAllAction NS_ENUM_AVAILABLE_IOS(3_0)= (1 << 4) ,
    UIResponderControlAllowDeleteAction NS_ENUM_AVAILABLE_IOS(3_2)= (1 << 5) ,
    UIResponderControlAllowMakeTextWritingDirectionLeftToRightAction NS_ENUM_AVAILABLE_IOS(5_0)= (1 << 6) ,
    UIResponderControlAllowMakeTextWritingDirectionRightToLeftAction NS_ENUM_AVAILABLE_IOS(5_0)= (1 << 7) ,
    UIResponderControlAllowToggleBoldfaceAction NS_ENUM_AVAILABLE_IOS(6_0)= (1 << 8) ,
    UIResponderControlAllowToggleItalicsAction NS_ENUM_AVAILABLE_IOS(6_0)= (1 << 9) ,
    UIResponderControlAllowToggleUnderlineAction NS_ENUM_AVAILABLE_IOS(6_0)= (1 << 10) ,
    UIResponderControlAllowIncreaseSizeAction NS_ENUM_AVAILABLE_IOS(7_0)= (1 << 11) ,
    UIResponderControlAllowDecreaseSizeAction NS_ENUM_AVAILABLE_IOS(7_0)= (1 << 12)
};

@interface NSObject (UIResponderControlAllowedEditActions)
- (void)setAllowedActions:(UIResponderControlStandardEditActions)actions;
- (UIResponderControlStandardEditActions)allowedActions;
@end
