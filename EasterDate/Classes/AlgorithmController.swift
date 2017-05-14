/**
 @file AlgorithmController.swift
 @brief Classe per la gestione della schermata per la pagina Web dell'algoritmo.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit

class AlgorithmController: UIViewController, UIWebViewDelegate
{
    /** @brief WebView principale di riferimento. */
    @IBOutlet var algorithmContent: UIWebView?
    
    /** @brief Indicatore di comunicazione con il server. */
    var serverProgress: DRPLoadingSpinner?
    
    /** @brief Overlay associato alla comunicazione con il server. */
    var viewOverlay: UIView?
    
    /**
     @brief Funzione invocata dal sistema per l'inizializzazione del layout.
     @param nibNameOrNil Nome del file di interfaccia di riferimento.
     @param nibBundleOrNil Bundle di riferimento.
     */
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        //Invocata la funzione della superclasse.
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        //Inizializza il titolo della barra di navigazione.
        self.navigationItem.title = NSLocalizedString("AlgorithmTitle", comment: "AlgorithmTitle")
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
        
        //Impedisce a specifici controlli di finire al di sotto della Tab Bar.
        self.edgesForExtendedLayout = UIRectEdge.all;
        
        //Visualizza la barra di navigazione.
        self.navigationController?.navigationBar.isHidden = false
        
        //Personalizza un pulsante per il ritorno a questa interfaccia.
        let backButton: UIBarButtonItem = UIBarButtonItem.init(title: " ", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        //Disattiva il ritorno alla schermata precedente usando la gesture di swipe verso sinistra.
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //Evita l'utilizzo di una Navigation Bar traslucida.
        self.navigationController?.navigationBar.isTranslucent = false
        
        //Se possibile evita l'uso di una Tab Bar traslucida.
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    /**
     @brief Funzione di sistema invocato alla comparsa del layout.
     @param animated Flag per la gestione dell'animazione di comparsa.
     */
    override func viewWillAppear(_ animated: Bool)
    {
        //Invocata la funzione della superclasse.
        super.viewWillAppear(animated)
        
        //Registra la WebView principale.
        self.algorithmContent?.delegate = self
        
        //Lancia e visualizza l'indicatore di progresso.
        if ((viewOverlay?.superview) != nil)
        {
            viewOverlay?.removeFromSuperview()
        }
        
        if ((serverProgress?.superview) != nil)
        {
            serverProgress?.removeFromSuperview()
        }
        
        initSpinner()
        
        self.view.addSubview(viewOverlay!)
        self.view.addSubview(serverProgress!)
        serverProgress?.startAnimating()
        
        //Personalizzazione Back Button (iPad)
        if (Macros.isIPad())
        {
            let negativeSpacer: UIBarButtonItem! = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            negativeSpacer.width = -16.0
            
            let backButton: UIButton! = UIButton.init(frame: CGRect.init(x: 0.0, y: 0.0, width: 44.0, height: (self.navigationController?.navigationBar.frame.size.height)!))
            backButton.setImage(UIImage.init(named: "back"), for: UIControlState.normal)
            backButton.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
            self.navigationItem.leftBarButtonItems = NSArray.init(objects: negativeSpacer, UIBarButtonItem.init(customView: backButton)) as? [UIBarButtonItem]
        }
        
        //Configura l'aspetto della WebView principale.
        self.algorithmContent?.scrollView.showsVerticalScrollIndicator = false
        self.algorithmContent?.scrollView.showsHorizontalScrollIndicator = false
        self.algorithmContent?.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal
    }
    
    /**
     @brief Funzione di sistema invocato alla comparsa del layout.
     @param animated Flag per la gestione dell'animazione di comparsa.
     */
    override func viewDidAppear(_ animated: Bool)
    {
        //Invocata la funzione della superclasse.
        super.viewDidAppear(animated)
        
        //Indica le rotazioni consentite.
        Utilities.lockOrientation(.portrait)
        
        //Verifica la presenza di connessione di Rete.
        if (Utilities.isOnline())
        {
            //Visualizzazione asincrona della pagina Web di riferimento.
            DispatchQueue.global().async
            {
                let urlRequest: NSURLRequest! = NSURLRequest.init(url: NSURL.init(string: NSLocalizedString("WikipediaPage", comment: "WikipediaPage")) as! URL)
                self.algorithmContent?.loadRequest(urlRequest as URLRequest)
            }
        }
        else
        {
            //Ferma e nasconde l'indicatore di progresso.
            if ((viewOverlay?.superview) != nil)
            {
                viewOverlay?.removeFromSuperview()
            }
            
            serverProgress?.stopAnimating()
            
            if ((serverProgress?.superview) != nil)
            {
                serverProgress?.removeFromSuperview()
            }
            
            //Notifica l'assenza di connessione di Rete.
            Utilities.showToast(message: "NoNetworkAlert")
        }
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
     @brief Funzione per il ritorno alla schermata precedente.
     */
    func goBack()
    {
        DispatchQueue.main.async
        {
            if let navController = self.navigationController
            {
                navController.popViewController(animated: true)
            }
        }
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
     @brief Funzione di sistema per la gestione di variazioni nell'orientazione del dispositivo.
     *
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        //Invocata la funzione della superclasse.
        super.viewWillTransition(to: size, with: coordinator)
        
        //Gestisce il cambio di orientazione.
        coordinator.animate(alongsideTransition: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            
            //Aggiorna la visualizzazione dell'indicatore di progresso, se animato.
            if ((self.viewOverlay?.superview) != nil && (self.serverProgress?.superview) != nil)
            {
                self.viewOverlay?.removeFromSuperview()
                self.serverProgress?.removeFromSuperview()
                self.initSpinner()
                self.view.addSubview(self.viewOverlay!)
                self.view.addSubview(self.serverProgress!)
                self.serverProgress?.startAnimating()
            }
            
            
        }, completion: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in})
 
    }
    */
    
    /**
     @brief Funzione per inizializzazione degli indicatori di comunicazione con il server.
     */
    func initSpinner()
    {
        serverProgress = DRPLoadingSpinner.init(frame: CGRect.init(x: self.view.frame.size.width / 2 - 20, y: self.view.frame.size.height / 2 - 90, width: Macros.spinnerSize(), height: Macros.spinnerSize()))
        serverProgress?.rotationCycleDuration = 1.0
        serverProgress?.drawCycleDuration = 0.1
        serverProgress?.lineWidth = 4.0
        serverProgress?.maximumArcLength = CGFloat(M_PI) + CGFloat(M_PI_2)
        serverProgress?.minimumArcLength = CGFloat(M_PI)
        serverProgress?.colorSequence = [MAIN_COLOR]
        viewOverlay = Utilities.customOverlay(dark: false)
    }
    
    /**
     @brief Funzione per la gestione del termine del caricamento del contenuto della WebView.
     @param webView WebView di riferimento.
     */
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        //Ferma e nasconde l'indicatore di progresso.
        if ((viewOverlay?.superview) != nil)
        {
            viewOverlay?.removeFromSuperview()
        }
        
        serverProgress?.stopAnimating()
        
        if ((serverProgress?.superview) != nil)
        {
            serverProgress?.removeFromSuperview()
        }
    }
    
    /**
     @brief Funzione per la gestione di errori nel caricamento del contenuto della WebView.
     @param webView WebView di riferimento.
     @param error Eventuale errore nel caricamento della WebView.
     */
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        //Ferma e nasconde l'indicatore di progresso.
        if ((viewOverlay?.superview) != nil)
        {
            viewOverlay?.removeFromSuperview()
        }
        
        serverProgress?.stopAnimating()
        
        if ((serverProgress?.superview) != nil)
        {
            serverProgress?.removeFromSuperview()
        }
        
        //Visualizza una notifica di errore.
        Utilities.showToast(message: "NoSupportAlert")
    }
}
