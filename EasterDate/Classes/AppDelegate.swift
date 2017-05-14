/**
 @file AppDelegate.swift
 @brief Classe per la gestione dell'applicazione principale.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    /** @brief Tab Bar di riferimento. */
    var tabBarController : UITabBarController?
    
    /** @brief Finestra principale dell'applicazione. */
    var window: UIWindow?

    /** @brief Punto di accesso alle informazioni condivise. */
    var defaults : UserDefaults?
    
    /** @brief Riferimento all'applicazione principale. */
    var mainApp : UIApplication?
    
    /** @brief Tabella dell'algoritmo di Gauss. */
    var gaussTable : NSMutableArray?
    
    /** @brief Lingua selezionata sul dispositivo. */
    var language : NSString?
    
    /** @brief Variabile per la gestione della rotazione dei layout. */
    var orientationLock = UIInterfaceOrientationMask.all

    /**
     @brief Metodo di sistema invocato al lancio dell'applicazione.
     @param application Istanza dell'applicazione principale.
     @param launchOptions Opzione specifiche per il lancio.
     @return Esito della gestione dell'operazione.
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        //Inizializza il listener di variazioni nell'orientazione del dispositivo.
        UIDevice.current.beginGeneratingDeviceOrientationNotifications();
        
        //Registra il riferimento all'applicazione principale.
        self.mainApp = application
        
        //Inizializza il punto di accesso alle informazioni condivise.
        defaults = UserDefaults.standard
        
        //Determina e traccia la lingua selezionata sul dispositivo.
        let languages: NSArray = defaults?.object(forKey: "AppleLanguages") as! NSArray
        language = languages.object(at: 0) as? NSString
        
        //Inizializza la tabella dell'algoritmo di Gauss.
        self.initGaussTable()
        
        //Lancia l'applicazione principale.
        self.startApp()
        
        //Operazione correttamente gestita.
        return true
    }
    
    /**
     @brief Funzione di sistema gestore della rotazione dei layout dell'applicazione.
     @param application Istanza dell'applicazione principale.
     @param window Finestra dell'applicazione principale.
     @return Oggetto rappresentativa dell'orientazione prevista.
     */
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        //Riferimento alla variabile per la gestione della rotazione dei layout.
        return self.orientationLock
    }
    
    /**
     @brief Metodo di sistema invocato all'attivazione dell'applicazione.
     @param application Istanza dell'applicazione principale.
     */
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        //TODO
    }

    /**
     @brief Metodo di sistema invocato alla disattivazione dell'applicazione.
     @param application Istanza dell'applicazione principale.
     */
    func applicationWillResignActive(_ application: UIApplication)
    {
        //TODO
    }
    
    /**
     @brief Metodo di sistema invocato alla terminazione dell'applicazione.
     @param application Istanza dell'applicazione principale.
     */
    func applicationWillTerminate(_ application: UIApplication)
    {
        //TODO
    }

    /**
     @brief Metodo di sistema invocato per esecuzione in background.
     @param application Istanza dell'applicazione principale.
     */
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        //TODO
    }

    /**
     @brief Metodo di sistema invocato per esecuzione in foreground.
     @param application Istanza dell'applicazione principale.
     */
    func applicationWillEnterForeground(_ application: UIApplication)
    {
        //TODO
    }
    
    /**
     @brief Metodo per inizializzazione della tabella dell'algoritmo di Gauss.
     */
    func initGaussTable()
    {
        //Inizializza la struttura dati di riferimento.
        gaussTable = NSMutableArray.init()
        var gaussRange: NSMutableDictionary?
        
        //Compone gli intervalli di riferimento.
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 34), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 1582), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 15), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 6), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 1583), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 1699), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 22), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 2), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 1700), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 1799), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 23), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 3), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 1800), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 1899), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 23), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 4), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 1900), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 1999), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 24), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 5), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 2000), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 2099), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 24), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 5), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 2100), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 2199), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 24), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 6), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 2200), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 2299), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 25), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 0), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 2300), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 2399), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 26), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 1), forKey: "nParam");
        gaussTable?.add(gaussRange!)
        
        gaussRange = NSMutableDictionary.init()
        gaussRange?.setValue(NSNumber.init(value: 2400), forKey: "startYear");
        gaussRange?.setValue(NSNumber.init(value: 2499), forKey: "endYear");
        gaussRange?.setValue(NSNumber.init(value: 25), forKey: "mParam");
        gaussRange?.setValue(NSNumber.init(value: 1), forKey: "nParam");
        gaussTable?.add(gaussRange!)
    }
    
    /**
     @brief Metodo per il lancio dell'applicazione principale.
     */
    func startApp()
    {
        //Inizializza la finestra principale.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        //Inizializza la schermata di lancio.
        let splash: SplashController? = SplashController(nibName: Xib.splashXib(), bundle: nil)
        let splashNav = UINavigationController(rootViewController: splash!)
        
        //Personalizza l'aspetto del titolo nella barra di navigazione.
        UINavigationBar.appearance().tintColor = MAIN_COLOR
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: ROBOTO_BOLD, size: (Macros.isIPad() ? 25.0 : 20.0))!, NSForegroundColorAttributeName: BLACK_COLOR]
        
        //Personalizza l'aspetto della Tab Bar principale.
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: ROBOTO_BOLD, size: (Macros.isIPad() ? 23.0 : 19.0))!, NSForegroundColorAttributeName: MAIN_COLOR], for: UIControlState.normal)
        UITabBar.appearance().tintColor = MAIN_COLOR
        UITabBar.appearance().barTintColor = WHITE_COLOR
        
        //Personalizza il colore del cursore nei campi di testo.
        UITextField.appearance().tintColor = MAIN_COLOR
        
        //Configura e lancia la finestra principale.
        window?.rootViewController = splashNav
        window?.makeKeyAndVisible()
    }
}
