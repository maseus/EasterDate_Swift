//
//  ACFloatingTextField.m
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import "ACFloatingTextField.h"
#import "EasterDate-Swift.h"

@implementation ACFloatingTextField

//Font di riferimento per il placeholder mobile.
#define PLACEHOLDER_FONT [UIFont fontWithName: @"Roboto-Regular" size: ([Macros isIPad] ? 15.0f : 12.0f)]

//Metodo di inizializzazione di sistema.
- (instancetype) init
{
    if (self)
    {
        //Invocato il metodo della superclasse.
        self = [super init];
        
        //Inizializzazione personalizzata.
        [self initialization];
    }
    
    //Ritorna l'istanza inizializzata.
    return self;
}

//Metodo per inizializzazione personalizzata.
- (instancetype) initWithFrame: (CGRect) frame
{
    if (self)
    {
        //Invocato il metodo della superclasse.
        self = [super initWithFrame: frame];
        
        //Inizializzazione personalizzata.
        [self initialization];
    }
    
    //Ritorna l'istanza inizializzata.
    return self;
}

//Metodo per inizializzazione da file XIB.
- (void) awakeFromNib
{
    //Invocato il metodo della superclasse.
    [super awakeFromNib];
    
    //Inizializzazione personalizzata.
    [self initialization];
}

//Metodo per il disegno del layout generale.
- (void) drawRect: (CGRect) rect
{
    //Aggiorna il layout principale.
    [self updateTextField: CGRectMake (CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(rect), CGRectGetHeight(rect) + ([Macros isIPad] ? 6.0f : 2.0f))];
}

//Metodo per il disegno del layout per il campo di testo.
- (CGRect) textRectForBounds: (CGRect) bounds
{
    //Restituisce il layout di riferimento.
    return CGRectMake(4.0f, 4.0f, bounds.size.width, bounds.size.height + ([Macros isIPad] ? 6.0f : 2.0f));
}

//Metodo per il disegno del layout editabile.
- (CGRect) editingRectForBounds: (CGRect) bounds
{
    //Restituisce il layout di riferimento.
    return CGRectMake(4.0f, 4.0f, bounds.size.width, bounds.size.height + ([Macros isIPad] ? 6.0f : 2.0f));
}

//Metodo setter per il testo visualizzato nel campo di riferimento.
- (void) setText: (NSString *) text
{
    //Invocato il metodo della superclasse.
    [super setText: text];
    
    //Aggiorna il relativo layout.
    if (text) [self floatTheLabel];
    [self checkForDefaultLabel];
}

//Metodo per inizializzazione del layout principale.
- (void) initialization
{
    //Nasconde il placeholder predefinito del campo di testo.
    self.clipsToBounds = true;
    [self checkForDefaultLabel];
    
    //Inizializza i parametri predefiniti per il layout da visualizzare.
    if (_placeHolderColor == nil) _placeHolderColor = [UIColor lightGrayColor];
    if (_selectedPlaceHolderColor == nil) _selectedPlaceHolderColor = [UIColor colorWithRed: 19.0f/256.0f green: 141.0f/256.0f blue: 117.0f/256.0f alpha: 1.0f];
    if (_lineColor == nil) _lineColor = [UIColor blackColor];
    if (_selectedLineColor == nil) _selectedLineColor = [UIColor colorWithRed: 19.0f/256.0f green: 141.0f/256.0f blue: 117.0f/256.0f alpha: 1.0f];
    
    //Inserisce la linea sottostante il campo di testo.
    [self addBottomLineView];
    
    //Configura ed inserisce il placeholder personalizzato.
    [self addPlaceholderLabel];
    if (![self.text isEqualToString: @""]) [self floatTheLabel];
}

//Metodo per inizializzazione della linea sottostante il campo di testo.
- (void) addBottomLineView
{
    //Rimuove un'eventuale linea precedente.
    [bottomLineView removeFromSuperview];
    
    //Inizializza e configura la nuova linea.
    bottomLineView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 2.0f)];
    bottomLineView.backgroundColor = _lineColor;
    bottomLineView.tag = 20;
    
    //Colloca la nuova linea nel layout generale.
    [self addSubview: bottomLineView];

}

//Metodo per inizializzazione del placeholder personalizzato.
- (void) addPlaceholderLabel
{
    //Rimuove un eventuale placeholder precedente.
    [_labelPlaceholder removeFromSuperview];

    //Inizializza e configura il nuovo placeholder.
    if ([Utilities notNullWithString: self.placeholder]) _labelPlaceholder.text = self.placeholder;
    NSString *placeHolderText = _labelPlaceholder.text;
    
    _labelPlaceholder = [[UILabel alloc]initWithFrame: CGRectMake(5.0f, 0.0f, self.frame.size.width - 5.0f, CGRectGetHeight(self.frame) + ([Macros isIPad] ? 6.0f : 2.0f))];
    _labelPlaceholder.text = placeHolderText;
    _labelPlaceholder.textAlignment = self.textAlignment;
    _labelPlaceholder.textColor = _placeHolderColor;
    _labelPlaceholder.font = self.font;
    _labelPlaceholder.tag = 21;
    
    //Colloca il nuovo placeholder nel layout generale.
    [self addSubview: _labelPlaceholder];

}

//Metodo per l'eliminazione del placeholder predefinito.
- (void) checkForDefaultLabel
{
    if ([self.text isEqualToString: @""])
    {
        //Scansiona il campo di testo alla ricerca di placeholder predefiniti.
        for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass: [UILabel class]])
            {
                UILabel *newLabel = (UILabel *) view;
                if (newLabel.tag != 21) newLabel.hidden = YES;
            }
        }
    }
    else
    {
        //Scansiona il campo di testo alla ricerca di placeholder predefiniti.
        for (UIView *view in self.subviews)
        {
            if ([view isKindOfClass: [UILabel class]])
            {
                UILabel *newLabel = (UILabel *) view;
                if (newLabel.tag != 21) newLabel.hidden = NO;
            }
        }
    }
}

//Metodo per l'aggiornamento del layout del campo di testo.
- (void) updateTextField: (CGRect) frame
{
    self.frame = frame;
    
    //Inizializzazione personalizzata.
    [self initialization];
}

//Metodo per attivazione animata del placeholder mobile.
- (void) floatPlaceHolder: (BOOL) selected
{
    if (selected)
    {
        bottomLineView.backgroundColor = _selectedLineColor;
        
        if (self.disableFloatingLabel)
        {
            _labelPlaceholder.hidden = YES;
            CGRect bottomLineFrame = bottomLineView.frame;
            bottomLineFrame.origin.y = CGRectGetHeight(self.frame) - 2;
            
            [UIView animateWithDuration: 0.2f animations:
            ^{
                bottomLineView.frame  =  bottomLineFrame;
            }];
            
            return;
        }
        
        CGRect frame = _labelPlaceholder.frame;
        frame.size.height = ([Macros isIPad] ? 18.0f : 14.0f);
        CGRect bottomLineFrame = bottomLineView.frame;
        bottomLineFrame.origin.y = CGRectGetHeight(self.frame) - 2;
        
        [UIView animateWithDuration: 0.2f animations:
        ^{
            _labelPlaceholder.frame = frame;
            _labelPlaceholder.font = PLACEHOLDER_FONT;
            _labelPlaceholder.textColor = _selectedPlaceHolderColor;
            bottomLineView.frame  =  bottomLineFrame;
        }];
    }
    else
    {
        bottomLineView.backgroundColor = _lineColor;
        
        if (self.disableFloatingLabel)
        {
            _labelPlaceholder.hidden = YES;
            CGRect bottomLineFrame = bottomLineView.frame;
            bottomLineFrame.origin.y = CGRectGetHeight (self.frame) - 2;
            
            [UIView animateWithDuration: 0.2f animations:
            ^{
                bottomLineView.frame  =  bottomLineFrame;
            }];
            
            return;
        }
        
        CGRect frame = _labelPlaceholder.frame;
        frame.size.height = ([Macros isIPad] ? 16.0f : 12.0f);
        CGRect bottomLineFrame = bottomLineView.frame;
        bottomLineFrame.origin.y = CGRectGetHeight(self.frame) - 1;
        
        [UIView animateWithDuration: 0.2f animations:
        ^{
            _labelPlaceholder.frame = frame;
            _labelPlaceholder.font = PLACEHOLDER_FONT;
            _labelPlaceholder.textColor = _placeHolderColor;
            bottomLineView.frame  =  bottomLineFrame;
        }];
    }
}

//Metodo per disattivazione animata del placeholder mobile.
- (void) resignPlaceholder
{
    bottomLineView.backgroundColor = _lineColor;
    
    if (self.disableFloatingLabel)
    {
        _labelPlaceholder.hidden = NO;
        _labelPlaceholder.textColor = _placeHolderColor;
        CGRect bottomLineFrame = bottomLineView.frame;
        bottomLineFrame.origin.y = CGRectGetHeight(self.frame) - 1;
        
        [UIView animateWithDuration: 0.2f animations:
        ^{
            bottomLineView.frame  =  bottomLineFrame;
        }];
        
        return;
    }
    
    CGRect frame = CGRectMake(4.0f, 0.0f, self.frame.size.width - 5.0f, self.frame.size.height + ([Macros isIPad] ? 6.0f : 2.0f));
    CGRect bottomLineFrame = bottomLineView.frame;
    bottomLineFrame.origin.y = CGRectGetHeight(self.frame) - 1;
    
    [UIView animateWithDuration: 0.2f animations:
    ^{
        _labelPlaceholder.frame = frame;
        _labelPlaceholder.font = self.font;
        _labelPlaceholder.textColor = _placeHolderColor;
        bottomLineView.frame  =  bottomLineFrame;
    }];
}

//Metodo di sistema per gestione inizio variazione campo di testo.
- (void) textFieldDidBeginEditing
{
    //Aggiorna il layout principale.
    [self floatTheLabel];
    [self layoutSubviews];
}

//Metodo di sistema per gestione fine variazione campo di testo.
- (void) textFieldDidEndEditing
{
    //Aggiorna il layout principale.
    [self floatTheLabel];
}

//Metodo setter per il placeholder da visualizzare.
- (void) setTextFieldPlaceholderText: (NSString *) placeholderText
{
    self.labelPlaceholder.text = placeholderText;
    [self textFieldDidEndEditing];
}

//Metodo setter per il placeholder da visualizzare.
- (void) setPlaceholder: (NSString *) placeholder
{
    self.labelPlaceholder.text = placeholder;
    [self textFieldDidEndEditing];
}

//Metodo di sistema gestore della ricezione del focus da tastiera.
- (BOOL) becomeFirstResponder
{
    //Invocato il metodo della superclasse.
    BOOL result = [super becomeFirstResponder];
    
    //Inizia l'interazione con il campo di testo.
    [self textFieldDidBeginEditing];
    return result;
}

//Metodo di sistema gestore del rilascio del focus da tastiera.
- (BOOL) resignFirstResponder
{
    //Invocato il metodo della superclasse.
    BOOL result = [super resignFirstResponder];
    
    //Termina l'interazione con il campo di testo.
    [self textFieldDidEndEditing];
    return result;
}

- (void) floatTheLabel
{
    if ([self.text isEqualToString: @""] && self.isFirstResponder) [self floatPlaceHolder: YES];
    else if ([self.text isEqualToString: @""] && !self.isFirstResponder) [self resignPlaceholder];
    else if (![self.text isEqualToString: @""] && !self.isFirstResponder) [self floatPlaceHolder: NO];
    else if (![self.text isEqualToString: @""] && self.isFirstResponder) [self floatPlaceHolder: YES];
    
    [self checkForDefaultLabel];
}

@end
