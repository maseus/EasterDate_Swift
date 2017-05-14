//
//  ACFloatingTextField.h
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import <UIKit/UIKit.h>

@class Utilities;
@class Macros;
@class Fonts;

@interface ACFloatingTextField : UITextField
{
    //Linea sottostante il campo di testo.
    UIView *bottomLineView;
}

//Colore predefinito per la linea sottostante il campo di testo.
@property (nonatomic, strong) UIColor *lineColor;

//Colore per la linea sottostante il campo di testo in stato di selezione.
@property (nonatomic, strong) UIColor *selectedLineColor;

//Colore predefinito per il placeholder visualizzato.
@property (nonatomic, strong) UIColor *placeHolderColor;

//Colore per il placeholder visualizzato in stato di selezione.
@property (nonatomic, strong) UIColor *selectedPlaceHolderColor;

//Etichetta per la visualizzazione del placeholder.
@property (nonatomic, strong) UILabel *labelPlaceholder;

//Flag per la disattivazione del placeholder mobile.
@property (assign) BOOL disableFloatingLabel;

//Metodo di inizializzazione di sistema.
- (instancetype) init;

//Metodo per inizializzazione personalizzata.
- (instancetype) initWithFrame: (CGRect) frame;

//Metodo setter per il placeholder da visualizzare.
- (void) setTextFieldPlaceholderText: (NSString *) placeholderText;

//Metodo per l'aggiornamento del layout del campo di testo.
- (void) updateTextField: (CGRect) frame;

@end
