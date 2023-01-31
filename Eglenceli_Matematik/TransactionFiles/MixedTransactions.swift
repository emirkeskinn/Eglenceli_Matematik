//
//  MixedTransactions.swift
//  Eglenceli_Matematik
//
//  Created by Emir Keskin on 31.01.2023.
//

import UIKit
import AVFoundation

class MixedTransactions: UIViewController {

    @IBOutlet var showAnswerLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var rightTitle: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var wrongTitle: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    

    var randomIndex: Int?
    
    var images = [UIImage(named: "1")]
    var currentIndex = 0
    var audioPlayer = AVAudioPlayer()
    var sonuc: Int?
    var dogru: Int = 0
    var yanlis: Int = 0
    var timer = Timer()
    var counter: Int?
    
    var buttonsAreHidden = true
    var sureTuslariGizle = true
    var secenekleriGizle = false
    
    var seconds = 0
    var timeRecords: [Int] = []
    var skorTablosu: [String] = ["5.00" ] //, "0.03" , "0.02"
    var sureniz: String?
    var timeEkle: [String] = []
    var myisim: String!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //imageView.image = images[currentIndex]
        imageView.image = UIImage(named: "gokce4")
        self.view.bringSubviewToFront(bButton)
        self.view.bringSubviewToFront(cButton)
        self.view.bringSubviewToFront(dButton)
        self.view.bringSubviewToFront(trueButton)
        self.view.bringSubviewToFront(falseButton)
        self.view.bringSubviewToFront(aButton)
        self.view.bringSubviewToFront(easyButton)
        self.view.bringSubviewToFront(normalButton)
        self.view.bringSubviewToFront(hardButton)
        easyButton.layer.cornerRadius = 10
        normalButton.layer.cornerRadius = 10
        hardButton.layer.cornerRadius = 10
        
        tuslariGizle()
        sureTuslariHidden()
        trueFalseTuslariniGizle()
        seconds = 0
        scorTablosu()
        counter = 0
      //  sureLabel.text = "\(counter!)"
        
        
        if let timeEklenecek = UserDefaults.standard.object(forKey: "sure7") as? [String] {
           timeEkle = timeEklenecek
        }
        print("UD set edilen time VDL: \(timeEkle)")
         skorTablosu.append(contentsOf: timeEkle)
             print("UD alınan time verisini alıp -> skorTablosu.append(contentsOf: timeEkle) hali \(skorTablosu)")
      
        
        if let skorTablom = UserDefaults.standard.object(forKey: "surem7") {
            let skorTablom2 = skorTablom
         print("UD set edilen skor tablosu VDL (skorTablosu.append(time)): \(skorTablom2)")
            skorTablosu = skorTablom2 as! [String]
            skorTablosu = skorTablosu.sorted()
            
            print("değiştirilen skor tablosu: \(skorTablosu)")
        }
    }
    
// ------------   TUŞ KOMBİNASYONLARI ------ GİZLE VE GÖSTER ------------------------------
    
    func tuslariGizle(){
        easyButton.layer.isHidden = false
        normalButton.layer.isHidden = false
        hardButton.layer.isHidden = false
        imageView.layer.isHidden = false
        aButton.layer.isHidden = true
        bButton.layer.isHidden = true
        cButton.layer.isHidden = true
        dButton.layer.isHidden = true
        answerLabel.layer.isHidden = true
    }
    
    func secenekleriHidden() {
        if secenekleriGizle {
            easyButton.layer.isHidden = false
            normalButton.layer.isHidden = false
            hardButton.layer.isHidden = false
            imageView.layer.isHidden = false
            aButton.layer.isHidden = true
            bButton.layer.isHidden = true
            cButton.layer.isHidden = true
            dButton.layer.isHidden = true
            answerLabel.layer.isHidden = true
            secenekleriGizle = false
        } else {
            easyButton.layer.isHidden = true
            normalButton.layer.isHidden = true
            hardButton.layer.isHidden = true
            imageView.layer.isHidden = false
            aButton.layer.isHidden = false
            bButton.layer.isHidden = false
            cButton.layer.isHidden = false
            dButton.layer.isHidden = false
            answerLabel.layer.isHidden = false
            secenekleriGizle = true
        }
    }
    
    
    func trueFalseTuslariniGizle() {
        trueButton.layer.isHidden = true
        falseButton.layer.isHidden = true
        
    }
    
    
    func sureTuslariHidden() {
        if sureTuslariGizle {
            timeTitle.layer.isHidden = true
            timeLabel.layer.isHidden = true
            rightTitle.layer.isHidden = true
            rightLabel.layer.isHidden = true
            wrongTitle.layer.isHidden = true
            wrongLabel.layer.isHidden = true
            answerLabel.layer.isHidden = true
            sureTuslariGizle = false
        } else {
            timeTitle.layer.isHidden = false
            timeLabel.layer.isHidden = false
            rightTitle.layer.isHidden = false
            rightLabel.layer.isHidden = false
            wrongTitle.layer.isHidden = false
            wrongLabel.layer.isHidden = false
            answerLabel.layer.isHidden = false
            sureTuslariGizle = true
        }
    }
    
    
    /*
    func sureTuslariGoster() {
    sureTitle.layer.isHidden = false
    sureLabel.layer.isHidden = false
    dogruTitle.layer.isHidden = false
    dogruLabel.layer.isHidden = false
    yanlisTitle.layer.isHidden = false
    yanlisLabel.layer.isHidden = false
    cevapLabel.layer.isHidden = false
    }
    */
    func toggleButtons() {
        if buttonsAreHidden {
            trueButton.layer.isHidden = true
            falseButton.layer.isHidden = true
            buttonsAreHidden = false
            print(trueButton!)
        } else {
            trueButton.layer.isHidden = false
            falseButton.layer.isHidden = false
            buttonsAreHidden = true
            print(trueButton!)
        }
    }
//------------ BİTTİ -------------------------------------------------------------

    
    
    
    
    
    
// ----------  SÜRE İŞLEMLERİ -- SKOR İŞLEMLERİ VE ÇETELELER  ----------------
/*
    func timerFunc(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFonsiyonu), userInfo: nil, repeats: true)
    }
    
    
    @objc func timerFonsiyonu() {
        counter! += 1
        sureLabel.text = "\(counter!)"
    }
    */
    
    func startTimer() {
       // print("skor tablosu (start timer): \(skorTablosu)")
        seconds = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter() {
        seconds += 1
        timeLabel.text = "\(seconds)"
        print("Geçen Süre: \(seconds)")
    }
    
 
    
    
    func stopTimer() {
        timer.invalidate()
       // timer.invalidate()
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        let time = "\(minutes) Dakika :\(remainingSeconds < 10 ? "0\(remainingSeconds)" : "\(remainingSeconds) Saniye")"
        print("time: \(time)")
        sureniz = time
        
        
        
      
        
        
        
        
        

        skorTablosu.append(time)
        print(("skorTablosu.append: \(time)"))
        
         UserDefaults.standard.set(time, forKey: "sure7")
        if let timerim = UserDefaults.standard.object(forKey: "sure7") {
                     let timerim2 = timerim
                     print("UD set edilen time: \(timerim2)")
                    
                 }

        
        //isimAlert1()
    }
    
    
    func scorTablosu() {
        rightLabel.text = "\(dogru)"
        wrongLabel.text = "\(yanlis)"
    }
    
//------------ BİTTİ -------------------------------------------------------------

    
    
    
    
// ------------ SES DOSYALARI ----------------------------------------------------

    func alkis() {
        let alkis = Bundle.main.url(forResource: "alkis", withExtension: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: alkis!)
    audioPlayer.prepareToPlay()
    audioPlayer.play()
    }
    
    func tabiEfendim() {
        let soundURL = Bundle.main.url(forResource: "ses2", withExtension: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
    audioPlayer.prepareToPlay()
    audioPlayer.play()
    }
   
//------------ BİTTİ -------------------------------------------------------------

    
    
    
    
    
// ----------- ALLERT FONKSİYONLARI ------------------------------------------------

    
    func theEndAlert(titleM: String, messageM: String) {
        
        let alertController = UIAlertController(title: titleM, message: messageM, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "Tamam", style: .default) { (action) in
               let newViewController = ScoreBoard() // Create a new view controller
               self.navigationController?.pushViewController(newViewController, animated: true)
               self.performSegue(withIdentifier: "toScorVC", sender: nil)
               print("pushViewController called")
           }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        print("pushViewController called2")
    }



    func makeAlert(titleM: String, messageM: String) {
        if self.presentedViewController == nil {
        let alert = UIAlertController(title: titleM, message: messageM, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "Yeniden Başla", style: UIAlertAction.Style.default, handler: nil)
        
        let okAction = UIAlertAction(title: "Ana Menüye Dön", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            //self.navigationController?.popViewController(animated: true)
        }

        alert.addAction(okAction)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    
       
        } else {
            print("sıkıntı var")
        }
    }
    
    func isimAlert1() {
        let alert = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name1"
        }
        let action = UIAlertAction(title: "Save", style: .default) { (_) in
            let name = alert.textFields?.first?.text ?? ""
            UserDefaults.standard.set(name, forKey: "userName1")
            self.myisim = name
            print("UserDefaults name: \(self.myisim ?? "nil")")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
//------------ BİTTİ -------------------------------------------------------------

 
    
    
 
// ----------- İŞLEM FONKSİYONLARI ------------------------------------------------

    func randomButtons() {
        
        // rastgele bir button seç ve işlem sonucunu göster
        let resultButton = buttons.randomElement()!
        resultButton.setTitle("\(sonuc!)", for: .normal)

        // diğer buttonlara farklı sayılar ata
        for button in buttons where button != resultButton {
            button.setTitle("\(Int.random(in: sonuc!-10...sonuc!+10))", for: .normal)
            if sonuc!  <= 10 {
                button.setTitle("\(Int.random(in: sonuc!+1...sonuc!+10))", for: .normal)
            }
        }
    }

    func fonksiyonIslemler(){
        aButton.backgroundColor = .systemGray5
        bButton.backgroundColor = .systemGray5
        cButton.backgroundColor = .systemGray5
        dButton.backgroundColor = .systemGray5
        trueButton.tintColor = .green
        falseButton.tintColor = .red
        
        let soru1 = UIImage(named: "soru30")
        let soru2 = UIImage(named: "true1")
        let soru3 = UIImage(named: "soru3")
        let soru4 = UIImage(named: "soru28")
        let soru5 = UIImage(named: "soru2")
        let soru6 = UIImage(named: "soru19")
        let soru7 = UIImage(named: "soru21")
        let soru8 = UIImage(named: "soru20")
        let soru9 = UIImage(named: "soru13")
        let soru10 = UIImage(named: "soru22")
        let soru11 = UIImage(named: "soru5")
        let soru12 = UIImage(named: "soru12")
        let soru13 = UIImage(named: "soru29")
        let soru14 = UIImage(named: "true2")
        let soru15 = UIImage(named: "true3")
     //   let soru16 = UIImage(named: "soru26")
     //   let soru17 = UIImage(named: "true2")
     //   let soru18 = UIImage(named: "true3")
     //   let soru19 = UIImage(named: "true4")
     //   let soru20 = UIImage(named: "soru7")
       // let soru11 = UIImage(named: "end")
        
        let randomIndex = Int.random(in: 0..<images.count)
        imageView.image = images[randomIndex]
    //    print("randım index: \(images[randomIndex]!)")
        
        
        
        switch imageView.image {
        case soru1:
            
          
            if randomIndex == 0 {
                sonuc = 8
                randomButtons()
                showAnswerLabel.text = "\(sonuc!)"
                print("sonuc: \(sonuc ?? 0)")}
                
        case soru2:
            if randomIndex == 1 {
                trueButton.layer.isHidden = false
                falseButton.layer.isHidden = false
                aButton.layer.isHidden = true
                bButton.layer.isHidden = true
                cButton.layer.isHidden = true
                dButton.layer.isHidden = true
                trueButton.setTitle("Doğru", for: .normal)}
        
        case soru3:
         
            if randomIndex == 2 {
                sonuc = 43
                randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
            
      case soru4:
            if randomIndex == 3 {
                sonuc = 9
                randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
            
      case soru5:
            if randomIndex == 4 {
               sonuc = 70
               randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
            
      case soru6:
             if randomIndex == 5 {
                sonuc = 27
                randomButtons()
                 showAnswerLabel.text = "\(sonuc!)"}
            
      case soru7:
            if randomIndex == 6 {
               sonuc = 20
               randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
            
      case soru8:
            if randomIndex == 7 {
               sonuc = 34
               randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
            
      case soru9:
            if randomIndex == 8 {
               sonuc = 12
               randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
           
      case soru10:
            if randomIndex == 9 {
               sonuc = 48
               randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
 
        case soru11:
              if randomIndex == 10 {
                 sonuc = 90
                 randomButtons()
                  showAnswerLabel.text = "\(sonuc!)"}
        case soru12:
              if randomIndex == 11 {
                 sonuc = 20
                 randomButtons()
                  showAnswerLabel.text = "\(sonuc!)"}
        case soru13:
              if randomIndex == 12 {
                 sonuc = 4
                 randomButtons()
                  showAnswerLabel.text = "\(sonuc!)"}
        case soru14:
              if randomIndex == 13 {
                  trueButton.layer.isHidden = false
                  falseButton.layer.isHidden = false
                  aButton.layer.isHidden = true
                  bButton.layer.isHidden = true
                  cButton.layer.isHidden = true
                  dButton.layer.isHidden = true
                  trueButton.setTitle("Doğru", for: .normal)}
        case soru15:
              if randomIndex == 14 {
                  trueButton.layer.isHidden = false
                  falseButton.layer.isHidden = false
                  aButton.layer.isHidden = true
                  bButton.layer.isHidden = true
                  cButton.layer.isHidden = true
                  dButton.layer.isHidden = true
                  trueButton.setTitle("Doğru", for: .normal)}
            
      default:
          break
}
        
        

      answerLabel.text = ""
  }
           
        /*
          switch imageView.image {
          case soru1:
            sonuc = 8
            randomButtons()
              }
          case soru2:
              trueButton.layer.isHidden = false
              falseButton.layer.isHidden = false
              aButton.layer.isHidden = true
              bButton.layer.isHidden = true
              cButton.layer.isHidden = true
              dButton.layer.isHidden = true
              trueButton.setTitle("Doğru", for: .normal)
            //sonuc = 7         // false
            randomButtons()
          case soru3:
            self.trueButton.layer.isHidden = true
            self.falseButton.layer.isHidden = true
            self.aButton.layer.isHidden = false
            self.bButton.layer.isHidden = false
            self.cButton.layer.isHidden = false
            self.dButton.layer.isHidden = false
            self.sonuc = 43
            self.randomButtons()
        case soru4:
            sonuc = 9
            randomButtons()
        case soru5:
            sonuc = 70
            randomButtons()
        case soru6:
            sonuc = 27
            randomButtons()
        case soru7:
            sonuc = 20
            randomButtons()
        case soru8:
            sonuc = 34
            randomButtons()
        case soru9:
            sonuc = 12
            randomButtons()
        case soru10:
            sonuc = 48
            randomButtons()
      //  case soru11:
        //      tuslariGizle()
        default:
            break
        }
        cevapLabel.text = ""
    }
    */

//------------ BİTTİ -------------------------------------------------------------


    
    

    
    
// ------------ BUTTON FONKSİYONLARI -----------------------------------------------

    
    @IBAction func buttonTapped(_ sender: UIButton!) {
                if sender.title(for: .normal) == "\(sonuc!)" {
                    print("tebrikler")
                    answerLabel.text = "Doğru... Aferin Sana"
                    currentIndex += 1
                    print(currentIndex)
                    dogru += 1
                    rightLabel.text = "\(dogru)"
                    sender.backgroundColor = .green
                   // alkis()
                    print("currentIndex\(currentIndex)")
                    
                    /*
                    if self.dogruLabel.text == "\(1)" {
                        self.stopTimer()
                    }
                     */
                    
                    if currentIndex == images.count {
                        
                        tuslariGizle()
                        sureTuslariHidden()
                        stopTimer()
                        
                        UserDefaults.standard.set(skorTablosu, forKey: "surem7")
                       if let skorTablom = UserDefaults.standard.object(forKey: "surem7") {
                           let skorTablom2 = skorTablom
                        print("UD set edilen skor tablosu (skorTablosu.append(time)): \(skorTablom2)")
                       }
                        
                        theEndAlert(titleM: "Tebrikler", messageM: "Süreniz: \(sureniz!)" )
                        imageView.image = UIImage(named: "gokce4")
                    } else {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                            
                            
                            
                        imageView.image = images[currentIndex]
                        fonksiyonIslemler()}
                        
                    }
                
                    if self.currentIndex == 10 {
                      //  theEndAlert(titleM: "Tebrikler", messageM: "\(skorTablosu[0])" )
            }
                    
        } else {
            currentIndex += 1
            yanlis += 1
            wrongLabel.text = "\(yanlis)"
            answerLabel.text = "Doğru Cevap \(sonuc!) olacaktı"
            sender.backgroundColor = .red
            tabiEfendim()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            self.imageView.image = self.images[self.currentIndex]
            imageView.image = images[currentIndex]
            fonksiyonIslemler()
                if wrongLabel.text == "\(1)" {
                    stopTimer()
                    makeAlert(titleM: "Üzgünüm :(", messageM: "Tüm Haklarını Kullandın")
                    self.tuslariGizle()
                    imageView.image = UIImage(named: "gokce4")
                    // self.trueFalseTuslariniGizle()  //YENİ EKLENDİ..............................
                    sureTuslariHidden()
                    
                    self.trueButton.layer.isHidden = (self.trueButton != nil)  //YENİ EKLENDİ..............................
                    self.falseButton.layer.isHidden = (self.trueButton != nil)  //YENİ EKLENDİ..............................
                }
            }
        print("olmadı")
    }
}
    
    // yukarıdakinin yedeği
    /*
     @IBAction func buttonTapped(_ sender: UIButton!) {
         if sender.title(for: .normal) == "\(sonuc!)" {
             print("tebrikler")
             currentIndex += 1
                     if currentIndex == images.count {
                         currentIndex = 0
                     }
                     imageView.image = images[currentIndex]
             fonksiyonIslemler()
         } else {
         print("olmadı")
     }
     
     }
     */
    
    
    
    
    @IBAction func TrueFalseButtonTapped(_ sender: UIButton!) {
            print("currentIndex\(currentIndex)")
        if sender.title(for: .normal) == "Doğru" {
            alkis()
            dogru += 1
            currentIndex += 1
            print(currentIndex)
            rightLabel.text = "\(dogru)"
            sender.backgroundColor = .green
            answerLabel.text = "Doğru... Aferin Sana"
         //   toggleButtons()
            
            
            
                    if currentIndex == images.count {
                        stopTimer()
                        tuslariGizle()
                        sureTuslariHidden()
                        theEndAlert(titleM: "Tebrikler", messageM: "\(sureniz!)" )
                        imageView.image = UIImage(named: "gokce4")
                        
                    } else {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in

                      //  imageView.image = images[currentIndex]
                        fonksiyonIslemler()}
                        
                    }
            
                //   if self.currentIndex == 10 {
               //    }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                secenekleriHidden()
                   // imageView.image = images[currentIndex]
                    fonksiyonIslemler()
            }
           
        } else {
            yanlis += 1
            tabiEfendim()
            currentIndex += 1
            wrongLabel.text = "\(yanlis)"
            sender.backgroundColor = .red
            answerLabel.text = "Doğru Cevap \(sonuc!) olacaktı"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            self.imageView.image = self.images[self.currentIndex]
            imageView.image = images[currentIndex]
            fonksiyonIslemler()
                
                if wrongLabel.text == "\(1)" {
                    stopTimer()
                    makeAlert(titleM: "Üzgünüm :(", messageM: "Tüm Haklarını Kullandın")
                    self.tuslariGizle()
                    imageView.image = UIImage(named: "gokce4")
                    sureTuslariHidden()
                    
                    self.trueButton.layer.isHidden = (self.trueButton != nil)
                    self.falseButton.layer.isHidden = (self.trueButton != nil)
                }
            }
        }
    }
    


    
    
    @IBAction func kolayButton(_ sender: Any) {
        seconds = 0
        startTimer()
        sureTuslariHidden()
        seconds = 0
        currentIndex = 0
        dogru = 0
        yanlis = 0
        wrongLabel.text = "\(0)"
        rightLabel.text = "\(0)"
        easyButton.layer.isHidden = true
        normalButton.layer.isHidden = true
        hardButton.layer.isHidden = true
        imageView.layer.isHidden = false
        aButton.layer.isHidden = false
        bButton.layer.isHidden = false
        cButton.layer.isHidden = false
        dButton.layer.isHidden = false
        
        images = [UIImage(named: "soru30"), UIImage(named: "true1"),UIImage(named: "soru3"), UIImage(named: "soru28"),UIImage(named: "soru2"), UIImage(named: "soru19"),UIImage(named: "soru21"), UIImage(named: "soru20"),UIImage(named: "soru13"), UIImage(named: "soru22"), UIImage(named: "soru5"), UIImage(named: "soru12"), UIImage(named: "soru29"), UIImage(named: "true2"), UIImage(named: "true3")]
       
        
       // imageView.image = images[currentIndex]
        fonksiyonIslemler()
    }
    
    @IBAction func normalButton(_ sender: Any) {
        seconds = 0
        startTimer()
        sureTuslariHidden()
        seconds = 0
        currentIndex = 0
        dogru = 0
        yanlis = 0
        wrongLabel.text = "\(0)"
        rightLabel.text = "\(0)"
        easyButton.layer.isHidden = true
        normalButton.layer.isHidden = true
        hardButton.layer.isHidden = true
        imageView.layer.isHidden = false
        aButton.layer.isHidden = false
        bButton.layer.isHidden = false
        cButton.layer.isHidden = false
        dButton.layer.isHidden = false
        
        images = [UIImage(named: "soru30"), UIImage(named: "true1"),UIImage(named: "soru3"), UIImage(named: "true2"),UIImage(named: "soru26"), UIImage(named: "true3")]
       
        aButton.backgroundColor = .systemGray5
        bButton.backgroundColor = .systemGray5
        cButton.backgroundColor = .systemGray5
        dButton.backgroundColor = .systemGray5
        trueButton.tintColor = .green
        falseButton.tintColor = .red
        
        let soru1 = UIImage(named: "soru30")
        let soru2 = UIImage(named: "true1")
        let soru3 = UIImage(named: "soru3")
        let soru4 = UIImage(named: "true2")
        let soru5 = UIImage(named: "soru26")
        let soru6 = UIImage(named: "true3")

        let randomIndex = Int.random(in: 0..<images.count)
        imageView.image = images[randomIndex]
        print("randım index: \(images[randomIndex]!)")
        
        switch imageView.image {
        case soru1:
            if randomIndex == 0 {
                sonuc = 8
                randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
        case soru2:
            if randomIndex == 1 {
                trueButton.layer.isHidden = false
                falseButton.layer.isHidden = false
                aButton.layer.isHidden = true
                bButton.layer.isHidden = true
                cButton.layer.isHidden = true
                dButton.layer.isHidden = true
                trueButton.setTitle("Doğru", for: .normal)}
        case soru3:
            if randomIndex == 2 {
                sonuc = 43
                randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
      case soru4:
            if randomIndex == 3 {
                trueButton.layer.isHidden = false
                falseButton.layer.isHidden = false
                aButton.layer.isHidden = true
                bButton.layer.isHidden = true
                cButton.layer.isHidden = true
                dButton.layer.isHidden = true
                trueButton.setTitle("Doğru", for: .normal)}
      case soru5:
            if randomIndex == 4 {
               sonuc = 70
               randomButtons()
                showAnswerLabel.text = "\(sonuc!)"}
      case soru6:
             if randomIndex == 5 {
                 trueButton.layer.isHidden = false
                 falseButton.layer.isHidden = false
                 aButton.layer.isHidden = true
                 bButton.layer.isHidden = true
                 cButton.layer.isHidden = true
                 dButton.layer.isHidden = true
                 trueButton.setTitle("Doğru", for: .normal)}
      default:
          break
}
        
        
        /*
        print("skor tablosu: \(skorTablosu)")
        seconds = 0
        startTimer()
        seconds = 0
        dogru = 0   //YENİ EKLENDİ..............................
        yanlis = 0  //YENİ EKLENDİ..............................
        yanlisLabel.text = "\(0)"  //YENİ EKLENDİ..............................
        dogruLabel.text = "\(0)"  //YENİ EKLENDİ..............................
        currentIndex = 0
        sureTuslariHidden()
        kolayBut.layer.isHidden = true
        normalBut.layer.isHidden = true
        zorBut.layer.isHidden = true
        imageView.layer.isHidden = false
        aButton.layer.isHidden = false
        bButton.layer.isHidden = false
        cButton.layer.isHidden = false
        dButton.layer.isHidden = false
        
        images = [UIImage(named: "soru30")]
        
        imageView.image = images[currentIndex]
        fonksiyonIslemler()
         */
    }
    
    @IBAction func zorButton(_ sender: Any) {
        easyButton.layer.isHidden = true
        normalButton.layer.isHidden = true
        hardButton.layer.isHidden = true
        imageView.layer.isHidden = false
        aButton.layer.isHidden = false
        bButton.layer.isHidden = false
        cButton.layer.isHidden = false
        dButton.layer.isHidden = false
        
        currentIndex = 0
        
        images = [UIImage(named: "resim\(1)"), UIImage(named: "resim\(2)"), UIImage(named: "resim\(4)"),UIImage(named: "resim\(5)"), UIImage(named: "resim\(6)"),UIImage(named: "resim\(7)"), UIImage(named: "resim\(8)"),UIImage(named: "resim\(9)"), UIImage(named: "resim\(10)")]
        
        
        imageView.image = images[currentIndex]
        fonksiyonIslemler()
    }
    
//------------ BİTTİ -------------------------------------------------------------


    
    func islems() {
        
        
        var images1 = [UIImage(named: "")]
        
         images1 = [UIImage(named: "resim\(1)"), UIImage(named: "resim\(2)"), UIImage(named: "resim\(4)"),UIImage(named: "resim\(5)"), UIImage(named: "resim\(6)"),UIImage(named: "resim\(7)"), UIImage(named: "resim\(8)"),UIImage(named: "resim\(9)"), UIImage(named: "resim\(10)")]
        
        
        for i in 1...10 {
            let image = UIImage(named: "resim\(i)")
            let lastDigit = i % 10
            if lastDigit % 2 == 0 {
                print("false true")
            } else {
                print("buttonlar")
            }
            images1.append(image)
        }
}

    func cevaplar() {
        
        
       
        
        if randomIndex == 0 {
            sonuc = 8
        } else if randomIndex == 1 {
            trueButton.setTitle("Doğru", for: .normal)
        } else if randomIndex == 2 {
        sonuc = 43
        } else if randomIndex == 3 {
            sonuc = 9
            } else if randomIndex == 4 {
                sonuc = 70
                } else if randomIndex == 5 {
                    sonuc = 27
                    } else if randomIndex == 6 {
                        sonuc = 20
                        } else if randomIndex == 7 {
                            sonuc = 34
                            } else if randomIndex == 8 {
                                sonuc = 12
                                } else if randomIndex == 9 {
                                    sonuc = 48
                                    }
        
        
        
        
        /*
        switch randomIndex {
        case 0:
            sonuc = 8
        case 1:
            trueButton.setTitle("Doğru", for: .normal)
        case 2:
            sonuc = 43
        case 3:
            sonuc = 9
        case 4:
            sonuc = 70
        case 5:
            sonuc = 27
        case 6:
            sonuc = 20
        case 7:
            sonuc = 34
        case 8:
            sonuc = 12
        case 9:
            sonuc = 48
  
        default:
            break
        }
        
        
        */

        
    }
    
    
    
}

