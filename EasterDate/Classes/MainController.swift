/**
 @file MainController.swift
 @brief Classe per la gestione della schermata principale.
 @author Eustachio Maselli
 @copyright © 2017 Eustachio Maselli All rights reserved.
 */

import UIKit
import QuartzCore

class MainController: UIViewController, UITextFieldDelegate
{
    /** @brief ScrollView principale. */
    @IBOutlet var scrollView: TPKeyboardAvoidingScrollView?
    
    /** @brief Titolo principale della schermata. */
    @IBOutlet var mainTitle: UILabel?
    
    /** @brief Campo di testo per l'inserimento dell'anno. */
    @IBOutlet var yearField: ACFloatingTextField?
    
    /** @brief Pulsante per il calcolo richiesto. */
    @IBOutlet var computeButton: UIButton?
    
    /** @brief Layout del risultato finale. */
    @IBOutlet var resultView: UIView?
    
    /** @brief Etichetta del risultato finale. */
    @IBOutlet var resultLabel: UILabel?
    
    /** @brief Campo per il risultato finale. */
    @IBOutlet var easterDate: UILabel?
    
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
        self.tabBarItem.image = UIImage.init(named: "main")
        
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
     @brief Funzione per inizializzazione dei componenti del layout.
     */
    func initLayout()
    {
        //Valorizza il testo del titolo principale.
        self.mainTitle?.text = NSLocalizedString("MainTitle", comment: "MainTitle")
        
        //Inizializza il campo di testo per l'inserimento dell'anno.
        self.yearField?.delegate = self
        Utilities.floatingField(field: self.yearField!, placeholderId: "YearHint", withLine: true)
        
        //Inizializza il pulsante per il calcolo richiesto.
        self.computeButton?.setTitle(NSLocalizedString("ComputeButton", comment: "ComputeButton"), for: UIControlState.normal)
        self.computeButton?.layer.cornerRadius = (Macros.isIPad() ? 30.0 : 20.0)
        self.computeButton?.layer.shadowColor = INACTIVE_COLOR.cgColor
        self.computeButton?.layer.shadowOffset = CGSize.init(width: 0.0, height: 3.0)
        self.computeButton?.layer.shadowOpacity = 0.8
        self.computeButton?.layer.shadowRadius = 3.0
        self.computeButton?.layer.masksToBounds = false
        
        //Inizializza il layout contenente il risultato richiesto.
        self.resultLabel?.text = NSLocalizedString("EasterDay", comment: "EasterDay")
        self.easterDate?.text = ""
        self.resultView?.isHidden = true
        
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
        scrollHeight = scrollHeight + (self.mainTitle?.frame.size.height)!
        scrollHeight = scrollHeight + (self.yearField?.frame.size.height)!
        scrollHeight = scrollHeight + (self.computeButton?.frame.size.height)!
        
        if (!((self.resultView?.isHidden)!))
        {
            scrollHeight = scrollHeight + (self.resultView?.frame.size.height)!
        }
        
        return scrollHeight
    }
    
    /**
     @brief Funzione per la gestione dell'anno indicato.
     */
    func handleYear()
    {
        //Legge l'anno indicato dall'utente.
        let yearString: String! = Utilities.trimSides(string: self.yearField!.text!)
        let year: Int! = (Utilities.notNull(string: yearString) ? Int(yearString) : 0)
        
        //Verifica il rispetto dei limiti consentiti.
        if (year >= MIN_YEAR && year <= MAX_YEAR)
        {
            //Chiude la tastiera eventualmente aperta.
            self.yearField?.resignFirstResponder()
            
            //Applica l'algoritmo previsto.
            let easter: String! = Utilities.gaussAlgorithm(year: year)
            
            //Verifica una data non nulla.
            if (Utilities.notNull(string: easter))
            {
                //Visualizza la data calcolata.
                self.easterDate?.text = easter
                self.resultView?.isHidden = false
            }
            else
            {
                //Nasconde il risultato finale.
                self.resultView?.isHidden = true
            }
        }
        else
        {
            //Notifica il mancato inserimento di un anno.
            Utilities.showToast(message: "WrongYearAlert")
            
            //Nasconde il risultato finale.
            self.resultView?.isHidden = true
        }
    }
    
    /**
     @brief Funzione per la gestione della variazione del testo contenuto in un campo di testo.
     @param textField Campo di testo di riferimento.
     @param range Intervallo interessato dalla variazione.
     @param string Stringa rappresentativa del testo variato.
     @return Esito della gestione dell'operazione.
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        //Gestisce solo il campo di testo per l'inserimento dell'anno.
        if (textField.isEqual(self.yearField))
        {
            //Gestisce l'attivazione del pulsante di conferma.
            let year: String! = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            self.computeButton?.isEnabled = Utilities.notNull(string: year)
            
            //Gestisce la visibilità del risultato finale.
            if (!(Utilities.notNull(string: year)))
            {
                self.resultView?.isHidden = true
            }
            
            //Operazione correttamente gestita.
            return true
        }
        
        //Operazione non gestita.
        return false
    }
    
    /**
     @brief Funzione di sistema per interazione con i campi di testo.
     @param textField Campo di testo di riferimento.
     @return Esito della gestione dell'operazione.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //Gestisce solo il campo di testo per l'inserimento dell'anno.
        if (textField.isEqual(self.yearField))
        {
            //Verifica l'inserimento di un anno.
            if (Utilities.notNull(string: textField.text!))
            {
                //Verifica e gestisce l'anno inserito.
                handleYear()
            }
            else
            {
                //Notifica il mancato inserimento di un anno.
                Utilities.showToast(message: "WrongYearAlert")
                
                //Nasconde il risultato finale.
                self.resultView?.isHidden = true
            }
            
            //Operazione correttamente gestita.
            return true
        }
        
        //Operazione non gestita.
        return false
    }
    
    /**
     @brief Funzione per la gestione dell'interazione con il pulsante per il calcolo richiesto.
     @param sender Controllo oggetto di interazione.
     */
    @IBAction func computeResult(sender: UIButton)
    {
        //Effetto di animazione visiva.
        self.computeButton?.alpha = 0.4
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(100))
        {
            self.computeButton?.alpha = 1.0
        }
        
        //Verifica e gestisce l'anno inserito.
        handleYear()
    }
}
