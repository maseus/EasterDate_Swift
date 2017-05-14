/**
 @file Xib.swift
 @brief Definizione di funzioni per la lettura dei file di interfaccia in uso nell'applicazione.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit

class Xib: NSObject
{
    /**
     @brief Funzione di classe per la lettura del file di interfaccia della classe SplashController.
     @return Nome del file di interfaccia di riferimento.
     */
    class func splashXib() -> String
    {
        //Ritorna il nome del file richiesto.
        return (Macros.isIPad() ? "SplashController_iPad" : "SplashController")
    }
    
    /**
     @brief Funzione di classe per la lettura del file di interfaccia della classe MainController.
     @return Nome del file di interfaccia di riferimento.
     */
    class func mainXib() -> String
    {
        //Ritorna il nome del file richiesto.
        return (Macros.isIPad() ? "MainController_iPad" : "MainController")
    }
    
    /**
     @brief Funzione di classe per la lettura del file di interfaccia della classe InfoController.
     @return Nome del file di interfaccia di riferimento.
     */
    class func infoXib() -> String
    {
        //Ritorna il nome del file richiesto.
        return (Macros.isIPad() ? "InfoController_iPad" : "InfoController")
    }
    
    /**
     @brief Funzione di classe per la lettura del file di interfaccia della classe AlgorithmController.
     @return Nome del file di interfaccia di riferimento.
     */
    class func algorithmXib() -> String
    {
        //Ritorna il nome del file richiesto.
        return (Macros.isIPad() ? "AlgorithmController_iPad" : "AlgorithmController")
    }
}
