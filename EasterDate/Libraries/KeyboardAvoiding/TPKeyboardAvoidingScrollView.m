//
//  TPKeyboardAvoidingScrollView.m
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import "TPKeyboardAvoidingScrollView.h"

@interface TPKeyboardAvoidingScrollView () <UITextFieldDelegate, UITextViewDelegate>
@end

@implementation TPKeyboardAvoidingScrollView

//Metodo per inizializzazione personalizzat.
- (void) setup
{
    //Registra listener su specifici tipi di eventi.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(TPKeyboardAvoiding_keyboardWillShow:) name: UIKeyboardWillChangeFrameNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(TPKeyboardAvoiding_keyboardWillHide:) name: UIKeyboardWillHideNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(scrollToActiveTextField) name: UITextViewTextDidBeginEditingNotification object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(scrollToActiveTextField) name: UITextFieldTextDidBeginEditingNotification object: nil];
}

//Metodo di inizializzazione di sistema.
- (id) initWithFrame: (CGRect) frame
{
    //Invocato il metodo della superclasse.
    self = [super initWithFrame: frame];
    
    //Inizializzazione personalizzata.
    if (self) [self setup];
    
    //Ritorna l'istanza inizializzata.
    return self;
}

- (void) awakeFromNib
{
    //Inizializzazione personalizzata.
    [self setup];
    
    //Invocato il metodo della superclasse.
    [super awakeFromNib];
}

//Metodo di sistema per il rilascio delle risorse inutilizzate.
- (void) dealloc
{
    //Rilascia i listener sugli eventi gestiti.
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void) setFrame: (CGRect) frame
{

    //Invocato il metodo della superclasse.
    [super setFrame:frame];
    [self TPKeyboardAvoiding_updateContentInset];
}

- (void) setContentSize: (CGSize) contentSize
{
    //Invocato il metodo della superclasse.
    [super setContentSize:contentSize];
    [self TPKeyboardAvoiding_updateFromContentSizeChange];
}

//Metodo per adattamento del layout al suo contenuto.
- (void) contentSizeToFit
{
    self.contentSize = [self TPKeyboardAvoiding_calculatedContentSizeFromSubviewFrames];
}

//Metodo gestore del focus sul successivo campo di testo.
- (BOOL) focusNextTextField
{
    return [self TPKeyboardAvoiding_focusNextTextField];
}

//Metodo per scrolling verso il successivo campo di testo.
- (void) scrollToActiveTextField
{
    [self TPKeyboardAvoiding_scrollToActiveTextField];
}

- (void) willMoveToSuperview: (UIView *) newSuperview
{
    //Invocato il metodo della superclasse.
    [super willMoveToSuperview: newSuperview];
    
    if (!newSuperview) [NSObject cancelPreviousPerformRequestsWithTarget: self selector: @selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView:) object: self];
}

//Metodo di sistema gestore della fine dell'interazione con il layout.
- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    //Chiude la tastiera eventualmente aperta.
    [[self TPKeyboardAvoiding_findFirstResponderBeneathView: self] resignFirstResponder];
    
    //Invocato il metodo della superclasse.
    [super touchesEnded: touches withEvent: event];
}

//Metodo di sistema per la gestione della transizione della tastiera tra i campi di testo.
- (BOOL) textFieldShouldReturn: (UITextField *) textField
{
    //Chiude la tastiera se non vi sono altri campi di testo.
    if (![self focusNextTextField] ) [textField resignFirstResponder];
    return YES;
}

//Metodo di sistema per la gestione del layout.
- (void) layoutSubviews
{
    //Invocato il metodo della superclasse.
    [super layoutSubviews];
    
    [NSObject cancelPreviousPerformRequestsWithTarget: self selector: @selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView:) object: self];
    [self performSelector: @selector(TPKeyboardAvoiding_assignTextDelegateForViewsBeneathView:) withObject: self afterDelay: 0.1f];
}

@end
