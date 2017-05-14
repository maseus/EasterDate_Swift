/**
 @file SplashController.swift
 @brief Classe per la gestione della schermata di lancio.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit

class SplashController: UIViewController
{
    /**
     @brief Funzione invocata dal sistema per l'inizializzazione del layout.
     @param nibNameOrNil Nome del file di interfaccia di riferimento.
     @param nibBundleOrNil Bundle di riferimento.
    */
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        //Invocata la funzione della superclasse.
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    /**
     @brief Funzione predefinita per l'inizializzazione del layout.
     @param aDecoder Istanza del decoder di riferimento.
    */
    required init(coder aDecoder: NSCoder)
    {
        //Invocata la funzione della superclasse.
        super.init(nibName: nil, bundle: nil)
    }
    
    /**
     @brief Funzione di sistema invocato al caricamento del layout.
     */
    override func viewDidLoad()
    {
        //Invocata la funzione della superclasse.
        super.viewDidLoad()
        
        //Disattiva il ritorno alla schermata precedente usando la gesture di swipe verso sinistra.
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //Nasconde la barra di navigazione.
        self.navigationController?.navigationBar.isHidden = true
        
        //Lancia l'applicazione principale dopo ritardo specifico.
        _ = Timer.scheduledTimer(timeInterval: REFRESH_DELAY, target: self, selector: #selector(SplashController.startMain), userInfo: nil, repeats: false)
    }
    
    /**
     @brief Funzione di sistema invocata alla comparsa del layout.
     @param animated Flag per eventuale animazione.
     */
    override func viewDidAppear(_ animated: Bool)
    {
        //Invocata la funzione della superclasse.
        super.viewDidAppear(animated)
        
        //Indica le rotazioni consentite.
        Utilities.lockOrientation(.portrait)
    }
    
    /**
     @brief Funzione di sistema invocata alla scomparsa del layout.
     @param animated Flag per eventuale animazione.
     */
    override func viewWillDisappear(_ animated: Bool)
    {
        //Invocata la funzione della superclasse.
        super.viewWillDisappear(animated)
        
        //Ripristina la rotazione predefinita.
        Utilities.lockOrientation(.all)
    }

    /**
     @brief Funzione di sistema per contesti di sovrautilizzo di memoria.
     */
    override func didReceiveMemoryWarning()
    {
        //Invocata la funzione della superclasse.
        super.didReceiveMemoryWarning()
    }
    
    /**
     @brief Funzione per il lancio dell'applicazione principale.
     */
    func startMain()
    {
        //Inizializza le schermate principali dell'applicazione.
        let main = MainController(nibName: Xib.mainXib(), bundle: nil)
        let info = InfoController(nibName: Xib.infoXib(), bundle: nil)
        main.extendedLayoutIncludesOpaqueBars = true
        info.extendedLayoutIncludesOpaqueBars = true
        let mainNav = UINavigationController(rootViewController: main)
        let infoNav = UINavigationController(rootViewController: info)
        
        //Inserisce le schermate nel TabBarController principale.
        let controllers = [mainNav, infoNav]
        Utilities.appDelegate().tabBarController = UITabBarController()
        Utilities.appDelegate().tabBarController?.viewControllers = controllers
        
        //Lancia l'applicazione principale.
        DispatchQueue.main.async
        {
            self.navigationController?.pushViewController((Utilities.appDelegate().tabBarController)!, animated: true)
        }
    }
}
