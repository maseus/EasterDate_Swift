//
//  KSToastView.h
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import <UIKit/UIKit.h>

@class Macros;
@class Fonts;

typedef void (^KSToastBlock) (void);

@interface KSToastView : UIView

//Metodi per la configurazione della notifica.
+ (void) ks_setAppearanceBackgroundColor: (UIColor *) backgroundColor;
+ (void) ks_setAppearanceCornerRadius: (CGFloat) cornerRadius;
+ (void) ks_setAppearanceMaxWidth: (CGFloat) maxWidth;
+ (void) ks_setAppearanceMaxLines: (NSInteger) maxLines;
+ (void) ks_setAppearanceOffsetBottom: (CGFloat) offsetBottom;
+ (void) ks_setAppearanceTextAligment:(NSTextAlignment) textAlignment;
+ (void) ks_setAppearanceTextColor: (UIColor *) textColor;
+ (void) ks_setAppearanceTextFont: (UIFont *) textFont;
+ (void) ks_setAppearanceTextInsets: (UIEdgeInsets) textInsets;
+ (void) ks_setToastViewShowDuration: (NSTimeInterval) duration;

//Metodi per la visualizzazione della notifica.
+ (void) ks_showToast: (id) toast;
+ (void) ks_showToast: (id) toast duration: (NSTimeInterval) duration;
+ (void) ks_showToast: (id) toast delay: (NSTimeInterval) delay;
+ (void) ks_showToast: (id) toast completion: (KSToastBlock) completion;
+ (void) ks_showToast: (id) toast duration: (NSTimeInterval) duration delay: (NSTimeInterval) delay;
+ (void) ks_showToast: (id) toast duration: (NSTimeInterval) duration completion: (KSToastBlock) completion;
+ (void) ks_showToast: (id) toast delay: (NSTimeInterval) delay completion: (KSToastBlock) completion;
+ (void) ks_showToast: (id) toast duration: (NSTimeInterval) duration delay: (NSTimeInterval) delay completion: (KSToastBlock) completion;

//Metodo gestore del padding del testo visualizzato nella notifica.
+ (void) ks_setAppearanceTextPadding: (CGFloat) textPadding __attribute__((deprecated));

//Metodo gestore dell'altezza massima della notifica.
+ (void) ks_setAppearanceMaxHeight: (CGFloat) maxHeight __attribute__((deprecated));

@end
