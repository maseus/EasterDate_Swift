/**
 @file InfoController.swift
 @brief Classe per la gestione della schermata informativa.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit
import MessageUI

class InfoController: UIViewController, MFMailComposeViewControllerDelegate
{
    /** @brief ScrollView principale. */
    @IBOutlet var scrollView: UIScrollView?
    
    /** @brief Titolo principale della schermata. */
    @IBOutlet var infoTitle: UILabel?
    
    /** @brief Etichetta del numero di versione. */
    @IBOutlet var versionLabel: UILabel?
    
    /** @brief Informazione sul numero di versione. */
    @IBOutlet var versionCode: UILabel?
    
    /** @brief Etichetta del nome dell'autore. */
    @IBOutlet var authorLabel: UILabel?
    
    /** @brief Informazione sull'autore. */
    @IBOutlet var authorInfo: UILabel?
    
    /** @brief Layout contenente i pulsanti per i profili dell'autore. */
    @IBOutlet var badgeView: UIView?
    
    /** @brief Pulsante per il profilo Facebook dell'autore. */
    @IBOutlet var facebookBadge: UIButton?
    
    /** @brief Pulsante per il profilo LinkedIn dell'autore. */
    @IBOutlet var linkedinBadge: UIButton?
    
    /** @brief Pulsante per il profilo GitHub dell'autore. */
    @IBOutlet var githubBadge: UIButton?
    
    /** @brief Pulsante per il profilo Skype dell'autore. */
    @IBOutlet var skypeBadge: UIButton?
    
    /** @brief Pulsante per il contatto e-mail dell'autore. */
    @IBOutlet var mailBadge: UIButton?
    
    /** @brief Link alla pagina Wikipedia dell'algoritmo. */
    @IBOutlet var algorithmLink: UIButton?
    
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
        self.navigationItem.title = NSLocalizedString("AppName", comment: "AppName")
        
        //Personalizza l'icona della relativa Tab.
        self.title = nil
        self.tabBarItem.image = UIImage.init(named: "info")
        
        //Ricolloca l'icona nella Tab Bar.
        self.tabBarItem.imageInsets = TAB_INSETS
        
        //Regola l'ampiezza delle Tab.
        if (Utilities.isPortrait())
        {
            UITabBar.appearance().itemWidth = Macros.screenWidth() / CGFloat(TABS)
        }
        else
        {
            UITabBar.appearance().itemWidth = Macros.screenHeight() / CGFloat(TABS)
        }
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
        
        //Adatta le dimensioni della ScrollView alla View principale.
        self.scrollView?.frame = self.view.frame
        
        //Colloca la ScrollView nella View principale.
        self.view.addSubview(self.scrollView!)
        
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
        
        //Inizializza i componenti del layout.
        initLayout()
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
     @brief Funzione di sistema per la gestione di variazioni nell'orientazione del dispositivo.
     *
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        //Invocata la funzione della superclasse.
        super.viewWillTransition(to: size, with: coordinator)
        
        //Gestisce il cambio di orientazione.
        coordinator.animate(alongsideTransition: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            
            //Regola l'altezza della ScrollView principale.
            guard let scrollView = self.scrollView else { return }
            Utilities.adjustInset(scrollView: scrollView, height: self.scrollHeight())
            
        }, completion: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in})
    }
    */
    
    /**
     @brief Funzione per inizializzazione dei componenti del layout.
    */
    func initLayout()
    {
        //Valorizza i testi principali.
        self.infoTitle?.text = NSLocalizedString("InfoDesc", comment: "InfoDesc");
        self.versionLabel?.text = NSLocalizedString("VersionTitle", comment: "VersionTitle");
        self.versionCode?.text = NSLocalizedString("VersionNumber", comment: "VersionNumber");
        self.authorLabel?.text = NSLocalizedString("AuthorTitle", comment: "AuthorTitle");
        self.authorInfo?.text = NSLocalizedString("AuthorText", comment: "AuthorText");
        
        //Inizializza il testo del link alla pagina Wikipedia dell'algoritmo.
        self.algorithmLink?.setTitle(NSLocalizedString("AlgorithmLink", comment: "AlgorithmLink"), for: UIControlState.normal)
        
        //Regola l'altezza della ScrollView principale.
        Utilities.adjustInset(scrollView: self.scrollView!, height: scrollHeight())
    }
    
    /**
     @brief Funzione per il calcolo dell'altezza del contenuto della ScrollView principale.
     @return Altezza per il contenimento dei controlli principali.
     */
    func scrollHeight() -> CGFloat
    {
        var scrollHeight: CGFloat! = 0.0
        scrollHeight = scrollHeight + (self.infoTitle?.frame.size.height)!;
        scrollHeight = scrollHeight + (self.versionLabel?.frame.size.height)!;
        scrollHeight = scrollHeight + (self.versionCode?.frame.size.height)!;
        scrollHeight = scrollHeight + (self.authorLabel?.frame.size.height)!;
        scrollHeight = scrollHeight + (self.authorInfo?.frame.size.height)!;
        scrollHeight = scrollHeight + (self.badgeView?.frame.size.height)!;
        scrollHeight = scrollHeight + (self.algorithmLink?.frame.size.height)!;
        
        if (Macros.isIPad() && Utilities.isLandscape())
        {
             return scrollHeight + 400.0
        }
        
        return scrollHeight + 200.0
    }
    
    /**
     @brief Funzione per l'invio di una e-mail all'indirizzo indicato.
     @param mailAddress Indirizzo e-mail del destinatario.
     */
    func sendMail(mailAddress: String)
    {
        //Verifica la disponibilità del servizio.
        if MFMailComposeViewController.canSendMail()
        {
            //Inizializza il gestore del servizio.
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Indica il destinatario richiesto.
            mailComposer.setToRecipients([mailAddress])
            
            //Visualizza il sistema per la composizione dell'e-mail.
            self.present(mailComposer, animated: true, completion: nil)
        }
        //Notifica la mancanza del supporto richiesto.
        else
        {
            Utilities.showToast(message: "NoSupportAlert")
        }
    }
    
    /**
     @brief Funzione per la gestione dell'esito dell'invio dell'e-mail.
     @param controller ViewController gestore della composizione dell'e-mail.
     @param result Risultato dell'operazione.
     @param error Eventuale errore nella gestione dell'operazione.
     */
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        //Verifica il risultato ottenuto.
        switch (result)
        {
            case MFMailComposeResult.cancelled:
            
                Utilities.showToast(message: "MailCancelledAlert")
                break
            
            case MFMailComposeResult.saved:
            
                Utilities.showToast(message: "MailSavedAlert")
                break
            
            case MFMailComposeResult.sent:
            
                Utilities.showToast(message: "MailSentAlert")
                break
            
            case MFMailComposeResult.failed:
            
                Utilities.showToast(message: "MailErrorAlert")
                break
        }
        
        //Chiude il sistema per la gestione dell'e-mail.
        controller.dismiss(animated: true, completion: nil)
    }
 
    /**
     @brief Funzione di interazione con i pulsanti per i profili dell'autore.
     @param sender Controllo oggetto di interazione.
     */
    @IBAction func handleBadge(sender: UIButton)
    {
        //Interazione con il pulsante per il profilo Facebook.
        if (sender.isEqual(self.facebookBadge))
        {
            //Effetto di animazione visiva.
            self.facebookBadge?.alpha = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100))
            {
                self.facebookBadge?.alpha = 1.0
            }
            
            //Verifica la presenza di connessione di Rete.
            if (Utilities.isOnline())
            {
                //Visualizza il profilo Facebook dell'autore.
                Utilities.openUrl(url: FACEBOOK_URL)
            }
            //Notifica l'assenza di connessione di Rete.
            else
            {
                Utilities.showToast(message: "NoNetworkAlert");
            }
        }
        //Interazione con il pulsante per il profilo LinkedIn.
        else if (sender.isEqual(self.linkedinBadge))
        {
            //Effetto di animazione visiva.
            self.linkedinBadge?.alpha = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100))
            {
                self.linkedinBadge?.alpha = 1.0
            }
            
            //Verifica la presenza di connessione di Rete.
            if (Utilities.isOnline())
            {
                //Visualizza il profilo LinkedIn dell'autore.
                Utilities.openUrl(url: LINKEDIN_URL)
            }
            //Notifica l'assenza di connessione di Rete.
            else
            {
                Utilities.showToast(message: "NoNetworkAlert");
            }
        }
        //Interazione con il pulsante per il profilo GitHub.
        else if (sender.isEqual(self.githubBadge))
        {
            //Effetto di animazione visiva.
            self.githubBadge?.alpha = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100))
            {
                self.githubBadge?.alpha = 1.0
            }
            
            //Verifica la presenza di connessione di Rete.
            if (Utilities.isOnline())
            {
                //Visualizza il profilo GitHub dell'autore.
                Utilities.openUrl(url: GITHUB_URL)
            }
            //Notifica l'assenza di connessione di Rete.
            else
            {
                Utilities.showToast(message: "NoNetworkAlert");
            }
        }
        //Interazione con il pulsante per il profilo Skype.
        else if (sender.isEqual(self.skypeBadge))
        {
            //Effetto di animazione visiva.
            self.skypeBadge?.alpha = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100))
            {
                self.skypeBadge?.alpha = 1.0
            }
            
            //Verifica la presenza di connessione di Rete.
            if (Utilities.isOnline())
            {
                //Contatta il profilo Skype dell'autore.
                Utilities.openSkype(skypeName: SKYPE_NAME)
            }
            //Notifica l'assenza di connessione di Rete.
            else
            {
                Utilities.showToast(message: "NoNetworkAlert");
            }
        }
        //Interazione con il pulsante per il contatto mail.
        else if (sender.isEqual(self.mailBadge))
        {
            //Effetto di animazione visiva.
            self.mailBadge?.alpha = 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100))
            {
                self.mailBadge?.alpha = 1.0
            }
            
            //Verifica la presenza di connessione di Rete.
            if (Utilities.isOnline())
            {
                //Predispone l'invio di un'e-mail all'autore.
                sendMail(mailAddress: MAIL_ADDRESS)
            }
            //Notifica l'assenza di connessione di Rete.
            else
            {
                Utilities.showToast(message: "NoNetworkAlert");
            }
        }
    }
    
    /**
     @brief Funzione di interazione con il link alla pagina Wikipedia dell'algoritmo.
     @param sender Controllo oggetto di interazione.
     */
    @IBAction func showWebPage(sender: UIButton)
    {
        //Effetto di animazione visiva.
        self.algorithmLink?.alpha = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100))
        {
            self.algorithmLink?.alpha = 1.0
        }
        
        //Verifica la presenza di connessione di Rete.
        if (Utilities.isOnline())
        {
            //Lancia la visualizzazione della pagina Wikipedia dell'algoritmo.
            let algorithm: AlgorithmController? = AlgorithmController(nibName: Xib.algorithmXib(), bundle: nil)
            
            DispatchQueue.main.async
            {
                self.navigationController?.pushViewController(algorithm!, animated: true)
            }
        }
        //Notifica l'assenza di connessione di Rete.
        else
        {
            Utilities.showToast(message: "NoNetworkAlert")
        }
    }
}
