/**
 @file Macros.swift
 @brief Definizione di macro in uso nell'applicazione.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit

class Macros: NSObject
{
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPad.
     @return Esito della verifica richiesta.
    */
    class func isIPad() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPhone.
     @return Esito della verifica richiesta.
     */
    class func isIPhone() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo con display Retina.
     @return Esito della verifica richiesta.
     */
    class func isRetina() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale)) && UIScreen.main.scale == 2.0)
    }
    
    /**
     @brief Funzione di classe per il calcolo della larghezza del display del dispositivo.
     @return Valore di larghezza del display del dispositivo.
     */
    class func screenWidth() -> CGFloat
    {
        //Ritorna il valore richiesto.
        return UIScreen.main.bounds.size.height
    }
    
    /**
     @brief Funzione di classe per il calcolo dell'altezza del display del dispositivo.
     @return Valore di altezza del display del dispositivo.
     */
    class func screenHeight() -> CGFloat
    {
        //Ritorna il valore richiesto.
        return UIScreen.main.bounds.size.width
    }
    
    /**
     @brief Funzione di classe per il calcolo della dimensione massima del display del dispositivo.
     @return Dimensione massima del display del dispositivo.
     */
    class func screenMaxDim() -> CGFloat
    {
        //Ritorna il valore richiesto.
        return max(screenWidth(), screenHeight())
    }
    
    /**
     @brief Funzione di classe per il calcolo della dimensione minima del display del dispositivo.
     @return Dimensione minima del display del dispositivo.
     */
    class func screenMinDim() -> CGFloat
    {
        //Ritorna il valore richiesto.
        return min(screenWidth(), screenHeight())
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPhone 4 o minore.
     @return Esito della verifica richiesta.
     */
    class func isIPhone4OrLess() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (isIPhone() && screenMaxDim() <= 480.0)
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPhone 5, 5s.
     @return Esito della verifica richiesta.
     */
    class func isIPhone5() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (isIPhone() && screenMaxDim() == 568.0)
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPhone 6, 6s, 7.
     @return Esito della verifica richiesta.
     */
    class func isIPhone6() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (isIPhone() && screenMaxDim() == 667.0)
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPhone 6 Plus, 6s Plus, 7 Plus.
     @return Esito della verifica richiesta.
     */
    class func isIPhone6P() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (isIPhone() && screenMaxDim() == 736.0)
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPad Air, Air 2, Pro 9,7 pollici.
     @return Esito della verifica richiesta.
     */
    class func isIPad9_7() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (isIPhone() && screenMaxDim() == 1024.0)
    }
    
    /**
     @brief Funzione di classe per verifica di utilizzo di dispositivo iPad Pro 12,9 pollici.
     @return Esito della verifica richiesta.
     */
    class func isIPad12_9() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (isIPhone() && screenMaxDim() == 1366.0)
    }
    
    /**
     @brief Funzione di classe per verifica versione di iOS minima 7.0.
     @return Esito della verifica richiesta.
    */
    class func isIOS7OrLater() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return Float(UIDevice.current.systemVersion)! >= Float(7.0)
    }
    
    /**
     @brief Funzione di classe per verifica versione di iOS minima 8.0.
     @return Esito della verifica richiesta.
     */
    class func isIOS8OrLater() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return Float(UIDevice.current.systemVersion)! >= Float(8.0)
    }
    
    /**
     @brief Funzione di classe per verifica versione di iOS minima 9.0.
     @return Esito della verifica richiesta.
     */
    class func isIOS9OrLater() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return Float(UIDevice.current.systemVersion)! >= Float(9.0)
    }
    
    /**
     @brief Funzione di classe per verifica versione di iOS minima 10.0.
     @return Esito della verifica richiesta.
     */
    class func isIOS10OrLater() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return Float(UIDevice.current.systemVersion)! >= Float(10.0)
    }
    
    /**
     @brief Funzione di classe per il calcolo della dimensione degli indicatori di aggiornamento.
     @return Dimensione richiesta.
    */
    class func spinnerSize() -> CGFloat
    {
        //Ritorna la dimensione richiesta.
        return (isIPad() ? 60.0 : 40.0)
    }
    
    /**
     @brief Funzione di classe per la conversione da gradi a radianti.
     @return Valore risultato della conversione.
    */
    class func toRadians(degrees: Double) -> Double
    {
        //Ritorna il valore della conversione.
        return (M_PI * degrees / 180.0)
    }
    
    /**
     @brief Funzione di classe per la creazione di un testo parametrico.
     @param format Stringa parametrica di riferimento.
     @param args Valori di riferimento per i parametri della stringa.
     @return Testo risultato della formattazione richiesta.
     */
    class func localizedFormatString(_ format: String, _ args: CVarArg...) -> String
    {
        //Ritorna il risultato della formattazione richiesta.
        return String.init(format: NSLocalizedString(format, comment: ""), args)
    }
}
