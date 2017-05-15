/**
 @file Utilities.swift
 @brief Classe per la gestione di operazioni di comune utilità.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit
import Foundation
import QuartzCore
import SystemConfiguration

class Utilities: NSObject
{
    /**
     @brief Funzione statica per la gestione della rotazione dei layout.
     @param orientation Orientazione consentita.
     */
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask)
    {
        if let delegate = UIApplication.shared.delegate as? AppDelegate
        {
            delegate.orientationLock = orientation
        }
    }
    
    /**
     @brief Funzione di classe per la lettura di un'istanza del delegato dell'applicazione.
     @return Istanza del delegato dell'applicazione.
     */
    class func appDelegate() -> AppDelegate
    {
        //Ritorna un'istanza del file AppDelegate.
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /**
     @brief Funzione di classe per verifica della connessione di Rete.
     @return Esito della verifica richiesta.
     */
    class func isOnline() -> Bool
    {
        //Verifica i parametri di riferimento.
        guard let flags = reachabilityFlags() else
        {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        //Ritorna l'esito della verifica richiesta.
        return (isReachable && !needsConnection)
    }
    
    /**
     @brief Funzione di classe per la lettura dei parametri della connessione di Rete.
     @return Parametri di riferimento della connessione di Rete.
    */
    class func reachabilityFlags() -> SCNetworkReachabilityFlags?
    {
        guard let reachability = ipv4Reachability() ?? ipv6Reachability() else
        {
            return nil
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(reachability, &flags)
        {
            return nil
        }
        
        //Ritorna gli oggetti richiesti.
        return flags
    }
    
    /**
     @brief Funzione di classe per verifica di raggiungibilità IPv4.
     @return Esito della verifica richiesta.
     */
    class func ipv4Reachability() -> SCNetworkReachability?
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
    
    /**
     @brief Funzione di classe per verifica di raggiungibilità IPv6.
     @return Esito della verifica richiesta.
     */
    class func ipv6Reachability() -> SCNetworkReachability?
    {
        var zeroAddress = sockaddr_in6()
        zeroAddress.sin6_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin6_family = sa_family_t(AF_INET6)
        
        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
    
    /**
     @brief Funzione di classe per la visualizzazione di una notifica Toast con durata predefinita.
     @param message Messaggio da visualizzare.
     */
    class func showToast(message: String)
    {
        //Visualizza la notifica prevista.
        return showToast(message: message, duration: 3.0)
    }
    
    /**
     @brief Funzione di classe per la visualizzazione di una notifica Toast con durata indicata.
     @param message Messaggio da visualizzare.
     @param duration Durata prevista per la notifica.
     */
    class func showToast(message: String, duration: Float)
    {
        //Visualizza la notifica prevista.
        KSToastView.ks_showToast(NSLocalizedString(message, comment: message), duration: Double(REFRESH_DELAY) * Double(duration))
    }
    
    /**
     @brief Funzione di classe per la lettura della lingua selezionata sul dispositivo.
     @return Stringa rappresentativa della lingua del dispositivo.
     */
    class func getLanguage() -> String
    {
        //Ritorna il risultato della verifica.
        return NSLocale.preferredLanguages[0]
    }
    
    /**
     @brief Funzione di classe per l'eliminazione di caratteri vuoti all'inizio ed al termine di una stringa.
     @param string Stringa di riferimento.
     @return Stringa risultato della formattazione.
     */
    class func trimSides(string: String) -> String
    {
        //Verifica stringa vuota.
        if (string == "")
        {
            return string
        }
        
        //Ritorna il risultato della formattazione richiesta.
        return string.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    /**
     @brief Funzione di classe per l'apertura di una pagina Web.
     @param url Percorso di Rete della pagina Web.
     */
    class func openUrl(url: String)
    {
        //Verifica il corretto formato dell'URL di riferimento.
        var newUrl: String? = url
        if (!((newUrl?.hasPrefix("http://"))!) && !((newUrl?.hasPrefix("https://"))!))
        {
            newUrl = "http://" + url
        }
        
        //Lancia il servizio richiesto se disponibile.
        if (UIApplication.shared.canOpenURL(NSURL.fileURL(withPath: newUrl!)))
        {
            //Apre la pagina Web specificata.
            UIApplication.shared.openURL(NSURL(string: newUrl!) as! URL)
        }
    }
    
    /**
     @brief Funzione di classe per l'apertura di un contatto Skype.
     @param skypeName Nome Skype del contatto di riferimento.
     */
    class func openSkype(skypeName: String)
    {
        //Lancia il servizio richiesto se disponibile.
        if (UIApplication.shared.canOpenURL(NSURL.fileURL(withPath: "skype://")))
        {
            let skypeUrl: String? = String.init(format: "skype://?call=%@", skypeName)
            UIApplication.shared.openURL(NSURL(string: skypeUrl!) as! URL)
        }
        //Altrimenti visualizza una notifica di errore.
        else
        {
            showToast(message: "NoSupportAlert")
        }
    }
    
    /**
     @brief Funzione di classe per l'estrazione del codice della lingua indicata.
     @param language Stringa rappresentativa della lingua di riferimento.
     @return Identificatore della lingua di riferimento.
     */
    class func getLanguage(language: String) -> DeviceLanguage
    {
        //Verifica la stringa della lingua di riferimento.
        if (language == "it")
        {
            return DeviceLanguage.ITALIAN
        }
        else if (language == "en")
        {
            return DeviceLanguage.ENGLISH
        }
        
        //Identificatore della lingua predefinita.
        return DeviceLanguage.ENGLISH
    }
    
    /**
     @brief Funzione di classe per la regolazione dell'altezza di una ScrollView.
     @param scrollView ScrollView di riferimento.
     @param height Altezza da applicare.
     */
    class func adjustInset(scrollView: UIScrollView, height: CGFloat)
    {
        //Applica la modifica richiesta.
        let adjustInsets: UIEdgeInsets? = UIEdgeInsetsMake(0, 0, height, 0)
        scrollView.contentInset = adjustInsets!
        scrollView.scrollIndicatorInsets = adjustInsets!
    }
    
    /**
     @brief Funzione di classe per verifica di non nullità di una stringa.
     @param string Stringa di riferimento.
     @return Esito della verifica richiesta.
     */
    class func notNull(string: String) -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return !(trimSides(string: string) == "")
    }
    
    /**
     @brief Funzione di classe per la creazione di un overlay da mostrare sul layout principale.
     @param dark Flag per la gestione del livello di trasparenza.
     @return Overlay generato.
     */
    class func customOverlay(dark: Bool) -> UIView
    {
        //Crea l'effetto richiesto.
        let overlay: UIView? = UIView.init(frame: UIScreen.main.bounds)
        overlay?.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: (dark ? 0.2 : 0.1))
        
        //Ritorna l'effetto creato.
        return overlay!
    }
    
    /**
     @brief Funzione di classe per verifica orientazione Portrait.
     @return Esito della verifica richiesta.
     */
    class func isPortrait() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return !(isLandscape())
    }
    
    /**
     @brief Funzione di classe per verifica orientazione Landscape.
     @return Esito della verifica richiesta.
     */
    class func isLandscape() -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        return ((UIDevice.current.orientation == UIDeviceOrientation.landscapeRight) || (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft) || (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeRight) || (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.landscapeLeft))
    }
    
    /**
     @brief Funzione di classe per la personalizzazione di un campo di testo con placeholder mobile.
     @param field Campo di testo di riferimento.
     @param placeholderId Identificatore del testo da usare come placeholder.
     @param withLine Flag per la visualizzazione di una linea.
     */
    class func floatingField(field: ACFloatingTextField, placeholderId: String, withLine: Bool)
    {
        field.placeholder = NSLocalizedString(placeholderId, comment: placeholderId)
        field.lineColor = (withLine ? MAIN_COLOR : UIColor.clear)
        field.selectedLineColor = (withLine ? MAIN_COLOR : UIColor.clear)
        field.placeHolderColor = HINT_COLOR
        field.selectedPlaceHolderColor = MAIN_COLOR
    }
    
    /**
     @brief Funzione per verifica di appartenenza di un valore ad un intervallo.
     @param start Valore iniziale dell'intervallo.
     @param end Valore finale dell'intervallo.
     @param value Valore da verificare.
     @return Esito della verifica richiesta.
     */
    class func isBetween(start: NSInteger, end: NSInteger, value: NSInteger) -> Bool
    {
        //Ritorna l'esito della verifica richiesta.
        return (value >= start && value <= end)
    }
    
    /**
     @brief Funzione per il calcolo dei parametri per l'algoritmo di Gauss.
     @param year Anno di riferimento.
     @return Oggetto contenitore dei parametri richiesti.
     */
    class func gaussParams(year: NSInteger) -> NSMutableDictionary
    {
        //Inizializza l'oggetto da restituire.
        let gaussParams: NSMutableDictionary? = NSMutableDictionary.init()
        
        //Inizializza le variabili di riferimento.
        var startYear: NSInteger?
        var endYear: NSInteger?
        var mParam: NSInteger? = -1
        var nParam: NSInteger? = -1
        
        //Verifica l'intervallo di riferimento nella tabella di Gauss.
        for gaussRange in appDelegate().gaussTable!
        {
            //Estrae gli anni di riferimento.
            startYear = (gaussRange as! NSMutableDictionary).value(forKey: "startYear") as? NSInteger
            endYear = (gaussRange as! NSMutableDictionary).value(forKey: "endYear") as? NSInteger
            
            //Verifica l'appartenenza dell'anno indicato allo specifico intervallo.
            if (isBetween(start: startYear!, end: endYear!, value: year))
            {
                //Estrae i parametri di riferimento.
                mParam = (gaussRange as! NSMutableDictionary).value(forKey: "mParam") as? NSInteger
                nParam = (gaussRange as! NSMutableDictionary).value(forKey: "nParam") as? NSInteger
                
                //Termina l'esecuzione del ciclo.
                break;
            }
        }
        
        //Compone l'oggetto di riferimento.
        gaussParams?.setValue(NSNumber.init(value: mParam!), forKey: "mParam")
        gaussParams?.setValue(NSNumber.init(value: nParam!), forKey: "nParam")
        
        //Restituisce l'oggetto creato.
        return gaussParams!
    }
    
    /**
     @brief Funzione di classe per applicazione dell'algoritmo di Gauss al calcolo della data della Pasqua cristiana.
     @param year Anno di riferimento.
     @return Stringa rappresentativa della data calcolata.
     */
    class func gaussAlgorithm(year: NSInteger) -> String
    {
        //Inizializza la stringa finale.
        var easterDate: String? = ""
        
        //Inizializza i parametri iniziali.
        var mParam: NSInteger? = -1
        var nParam: NSInteger? = -1
        
        //Inizializza i parametri di lavoro.
        var aParam: NSInteger?
        var bParam: NSInteger?
        var cParam: NSInteger?
        var dParam: NSInteger?
        var eParam: NSInteger?
        
        //Calcola i parametri per l'algoritmo di Gauss.
        let gaussParams: NSMutableDictionary? = self.gaussParams(year: year)
        if (gaussParams?["mParam"] != nil)
        {
            mParam = gaussParams?.value(forKey: "mParam") as? NSInteger
        }
        if (gaussParams?["nParam"] != nil)
        {
            nParam = gaussParams?.value(forKey: "nParam") as? NSInteger
        }
        
        //Verifica parametri validi.
        if (mParam != -1 && nParam != -1)
        {
            //Calcola i parametri di lavoro.
            aParam = year % 4;
            bParam = year % 7;
            cParam = year % 19;
            dParam = (19 * cParam! + mParam!) % 30;
            eParam = 2 * aParam!
            eParam = eParam! + (4 * bParam!)
            eParam = eParam! + (6 * dParam!)
            eParam = eParam! + nParam!
            eParam = eParam! % 7
            
            //Calcola una prima data.
            if (dParam! + eParam! <= 9)
            {
                easterDate = String(format: NSLocalizedString("Date1", comment: "Date1"), 22 + dParam! + eParam!)
            }
            else
            {
                easterDate = String(format: NSLocalizedString("Date2", comment: "Date2"), dParam! + eParam! - 9)
            }
            
            //Verifica eventuali eccezioni.
            if (easterDate == NSLocalizedString("Exception1", comment: "Exception1") && dParam! == 29 && eParam! == 6)
            {
                easterDate = String(format: NSLocalizedString("Date2", comment: "Date2"), 19)
            }
            else if (easterDate == NSLocalizedString("Exception2", comment: "Exception2") && cParam! > 10 && dParam! == 28 && eParam! == 6)
            {
                easterDate = String(format: NSLocalizedString("Date2", comment: "Date2"), 18)
            }
        }
        
        //Ritorna la data calcolata.
        return easterDate!;
    }
}
