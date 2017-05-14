//
//  DRPRefreshControl.h
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

@import UIKit;

@class DRPLoadingSpinner;

@interface DRPRefreshControl : NSObject

//Indicatore principale di riferimento.
@property (readonly) DRPLoadingSpinner *loadingSpinner;

//Metodo per associazione dell'indicatore ad una tabella di riferimento.
- (void) addToTableViewController: (UITableViewController *) tableViewController refreshBlock: (void (^)(void)) refreshBlock;

//Metodo per associazione dell'indicatore ad una tabella di riferimento.
- (void) addToTableViewController: (UITableViewController *) tableViewController target: (id) target selector: (SEL) selector;

//Metodo per associazione dell'indicatore ad una ScrollView di riferimento.
- (void) addToScrollView: (UIScrollView *) scrollView refreshBlock: (void (^)(void)) refreshBlock;

//Metodo per associazione dell'indicatore ad una ScrollView di riferimento.
- (void) addToScrollView: (UIScrollView *) scrollView target: (id) target selector: (SEL) selector;

//Metodo per rimozione dell'indicatore dal layout di riferimento..
- (void) removeFromPartnerObject;

//Metodo per il lancio dell'operazione di aggiornamento.
- (void) beginRefreshing;

//Metodo per l'arresto dell'operazione di aggiornamento.
- (void) endRefreshing;

@end
