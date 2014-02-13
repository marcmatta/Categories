//
//  NSObject+UIResponderAllowStandardEditActions.m
//  test
//
//  Created by Marc on 2/13/14.
//  Copyright (c) 2014 Marc. All rights reserved.
//

#import "NSObject+UIResponderControlStandardEditActions.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Swizzle)
static void Swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}
@end

@implementation NSObject (UIResponderControlAllowedEditActions)
static char actionsKey;
static bool switchedActions = NO;
- (void)setAllowedActions:(UIResponderControlStandardEditActions)actions
{
    if (actions == UIResponderControlAllowDefaultActions)
    {
        if (objc_getAssociatedObject(self, &actionsKey) != nil){
            objc_removeAssociatedObjects(self);
        }
    }else
        objc_setAssociatedObject (self, &actionsKey, @(actions), OBJC_ASSOCIATION_RETAIN);
 
    if (!switchedActions)
    {
        switchedActions = YES;
        Swizzle([self class], @selector(canPerformAction:withSender:), @selector(canPerformAction:));
    }
}

- (UIResponderControlStandardEditActions)allowedActions
{
    return [objc_getAssociatedObject(self, &actionsKey) unsignedIntegerValue];
}

- (BOOL)canPerformAction:(SEL)action
{
    UIResponderControlStandardEditActions allowedActions = [self allowedActions];
    
    if (allowedActions == UIResponderControlAllowDefaultActions) return [self respondsToSelector:action];
    
    BOOL canPerformAction = NO;
    
    canPerformAction |= (action == @selector(cut:) && (allowedActions & UIResponderControlAllowCutAction)) && [self respondsToSelector:@selector(cut:)];
    canPerformAction |= (action == @selector(copy:) && (allowedActions & UIResponderControlAllowCopyAction)) && [self respondsToSelector:@selector(copy:)];
    canPerformAction |= (action == @selector(paste:) && (allowedActions & UIResponderControlAllowPasteAction)) && [self respondsToSelector:@selector(paste:)];
    canPerformAction |= (action == @selector(select:) && (allowedActions & UIResponderControlAllowSelectAction)) && [self respondsToSelector:@selector(select:)];
    canPerformAction |= (action == @selector(selectAll:) && (allowedActions & UIResponderControlAllowSelectAllAction)) && [self respondsToSelector:@selector(selectAll:)];
    canPerformAction |= (action == @selector(delete:) && (allowedActions & UIResponderControlAllowDeleteAction)) && [self respondsToSelector:@selector(delete:)];
    canPerformAction |= (action == @selector(makeTextWritingDirectionLeftToRight:) && (allowedActions & UIResponderControlAllowMakeTextWritingDirectionLeftToRightAction)) && [self respondsToSelector:@selector(makeTextWritingDirectionLeftToRight:)];
    canPerformAction |= (action == @selector(makeTextWritingDirectionRightToLeft:) && (allowedActions & UIResponderControlAllowMakeTextWritingDirectionRightToLeftAction)) && [self respondsToSelector:@selector(makeTextWritingDirectionRightToLeft:)];
    canPerformAction |= (action == @selector(toggleBoldface:) && (allowedActions & UIResponderControlAllowToggleBoldfaceAction)) && [self respondsToSelector:@selector(toggleBoldface:)];
    canPerformAction |= (action == @selector(toggleItalics:) && (allowedActions & UIResponderControlAllowToggleItalicsAction)) && [self respondsToSelector:@selector(toggleItalics:)];
    canPerformAction |= (action == @selector(toggleUnderline:) && (allowedActions & UIResponderControlAllowToggleUnderlineAction)) && [self respondsToSelector:@selector(toggleUnderline:)];
    canPerformAction |= (action == @selector(increaseSize:) && (allowedActions & UIResponderControlAllowIncreaseSizeAction)) && [self respondsToSelector:@selector(increaseSize:)];
    canPerformAction |= (action == @selector(decreaseSize:) && (allowedActions & UIResponderControlAllowDecreaseSizeAction)) && [self respondsToSelector:@selector(decreaseSize:)];
    
    return canPerformAction;
}
@end
