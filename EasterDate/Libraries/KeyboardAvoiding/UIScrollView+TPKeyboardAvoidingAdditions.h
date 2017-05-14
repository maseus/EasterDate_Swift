//
//  UIScrollView+TPKeyboardAvoidingAdditions.h
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (TPKeyboardAvoidingAdditions)

- (BOOL) TPKeyboardAvoiding_focusNextTextField;
- (void) TPKeyboardAvoiding_scrollToActiveTextField;
- (void) TPKeyboardAvoiding_keyboardWillShow: (NSNotification *) notification;
- (void) TPKeyboardAvoiding_keyboardWillHide: (NSNotification *) notification;
- (void) TPKeyboardAvoiding_updateContentInset;
- (void) TPKeyboardAvoiding_updateFromContentSizeChange;
- (void) TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView: (UIView *) view;
- (UIView *) TPKeyboardAvoiding_findFirstResponderBeneathView: (UIView *) view;
- (CGSize) TPKeyboardAvoiding_calculatedContentSizeFromSubviewFrames;

@end
