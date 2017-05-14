//
//  TPKeyboardAvoidingScrollView.h
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"

@interface TPKeyboardAvoidingScrollView : UIScrollView <UITextFieldDelegate, UITextViewDelegate>

//Metodo per adattamento del layout al suo contenuto.
- (void) contentSizeToFit;

//Metodo gestore del focus sul successivo campo di testo.
- (BOOL) focusNextTextField;

//Metodo per scrolling verso il successivo campo di testo.
- (void) scrollToActiveTextField;

@end
