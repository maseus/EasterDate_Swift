//
//  DRPLoadingSpinner.h
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRPLoadingSpinner : UIView

//Lunghezza dell'arco dell'indicatore in stato di arresto.
@property (nonatomic, assign) CGFloat staticArcLength;

//Lunghezza minima dell'arco dell'indicatore.
@property (assign) CGFloat minimumArcLength;

//Lunghezza massima dell'arco dell'indicatore.
@property (assign) CGFloat maximumArcLength;

//Larghezza della linea dell'arco dell'indicatore.
@property (nonatomic) CGFloat lineWidth;

//Durata di rotazione completa dell'indicatore.
@property (assign) CFTimeInterval rotationCycleDuration;

//Durata di rappresentazione completa dell'indicatore.
@property (assign) CFTimeInterval drawCycleDuration;

//Sequenza di colori utilizzati nella rappresentazione.
@property (strong) NSArray<UIColor *> *colorSequence;

//Flag sullo stato di animazione dell'indicatore.
@property (readonly) BOOL isAnimating;

//Metodo per il lancio dell'animazione.
- (void) startAnimating;

//Metodo per l'arresto dell'animazione.
- (void) stopAnimating;

@end
