//
//  TestViewController.swift
//  Eglenceli_Matematik
//
//  Created by Emir Keskin on 29.01.2023.
//

import UIKit
import AVFoundation
import ImageIO

class TestViewController: UIViewController {
    
    @IBOutlet weak var rightTitle: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongTitle: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel1: UILabel!
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var questionLabel3: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var aferinLabel: UILabel!  // KAÇTA KAÇ SORU KALDIĞI YAZILACAK
    @IBOutlet weak var simgeLabel: UILabel!
    @IBOutlet weak var esittirLabel: UILabel!
    @IBOutlet weak var ghostLabel: UILabel!
    
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
 
    @IBOutlet weak var kolayButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var zorButton: UIButton!
    
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet weak var dogruAferinSanaLabeli: UILabel!
    
    
    
    var audioPlayer = AVAudioPlayer()
    
    
    var randomIndex: Int?
    var currentIndex = 0
    
    var images = [UIImage(named: "1")]
    
    var question: String?
    var answer: String?
    var sonuc: Int!
    var right: Int = 0
    var wrong: Int = 0
    var userAnswer: String?
    
    var timer = Timer()
    var counter: Int?
    
    var sonucToplama: Int?
    var sonucCikarma: Int?
    var sonucCarpma: Int?
    var sonucBolme: Int?
    var sonucTFtoplama: Int?
    
    var soru1: String?
    var soru2: String?
    var soru3: String?
    var soru31: String?
    
    var ghost: String?
    var ghost2: String?
    var ghost3: String?
    var ghost4: String?
    
    var result: Int?
    var labelSonuc: String = "error"
    var sureniz: String?
    var seconds = 0
    var skorTablosu: [String] = ["5.00" ]
    var myisim: String!
    
    var sayilarim = [5,8,10]
    
    var buttonsAreHidden = true
    var sureTuslariGizle = true
    var secenekleriGizle = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "gokce4")
        toggleButtons() // True - False
        sureTuslariHidden()
        secenekleriHidden()
        

        kolayButton.layer.cornerRadius = 10
        normalButton.layer.cornerRadius = 10
        zorButton.layer.cornerRadius = 10


        self.view.bringSubviewToFront(aButton)
        self.view.bringSubviewToFront(bButton)
        self.view.bringSubviewToFront(cButton)
        self.view.bringSubviewToFront(dButton)
        self.view.bringSubviewToFront(trueButton)
        self.view.bringSubviewToFront(falseButton)
        
        self.view.bringSubviewToFront(kolayButton)
        self.view.bringSubviewToFront(normalButton)
        self.view.bringSubviewToFront(zorButton)
        self.view.bringSubviewToFront(dogruAferinSanaLabeli)



    }
    
// ----------  SÜRE İŞLEMLERİ -- SKOR İŞLEMLERİ VE ÇETELELER  ----------------
        
        func startTimer() {
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

        }
        
        
        func scorTablosu() {
            rightLabel.text = "\(right)"
            wrongLabel.text = "\(wrong)"
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

    
    
    
    
// ----------------FUNCTIONS ---------------------------------------------
  
    func secenekleriHidden() {
        if secenekleriGizle {
            kolayButton.layer.isHidden = false
            normalButton.layer.isHidden = false
            zorButton.layer.isHidden = false
            imageView.layer.isHidden = false
            aButton.layer.isHidden = true
            bButton.layer.isHidden = true
            cButton.layer.isHidden = true
            dButton.layer.isHidden = true
            answerLabel.layer.isHidden = true
            questionLabel1.layer.isHidden = true
            questionLabel2.layer.isHidden = true
            questionLabel3.layer.isHidden = true
            aferinLabel.layer.isHidden = true
            simgeLabel.layer.isHidden = true
            esittirLabel.layer.isHidden = true

            secenekleriGizle = false
        } else {
            kolayButton.layer.isHidden = true
            normalButton.layer.isHidden = true
            zorButton.layer.isHidden = true
            imageView.layer.isHidden = false
            aButton.layer.isHidden = false
            bButton.layer.isHidden = false
            cButton.layer.isHidden = false
            dButton.layer.isHidden = false
            answerLabel.layer.isHidden = false
            questionLabel1.layer.isHidden = false
            questionLabel2.layer.isHidden = false
            questionLabel3.layer.isHidden = false
            aferinLabel.layer.isHidden = false
            simgeLabel.layer.isHidden = false
            esittirLabel.layer.isHidden = false
            secenekleriGizle = true
        }
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
    
    
    
// ----------------------END ---------------------------------------------

    
    
// ----------------BUTTONS ---------------------------------------------

   
    @IBAction func easyButton(_ sender: UIButton) {
        imageView.image = UIImage(named: "gokce1")
        secenekleriHidden()
        sureTuslariHidden()
        aferinLabel.text = ""
       // fonksiyonIslemler()
        startTimer()
        currentIndex = 0
        seconds = 0
        right = 0
        wrong = 0
        wrongLabel.text = "\(0)"
        rightLabel.text = "\(0)"
    }
    
    
    @IBAction func normalButtons(_ sender: UIButton) {
        
        imageView.image = UIImage(named: "gokce1")
        secenekleriHidden()
        sureTuslariHidden()
        aferinLabel.text = ""
     //   startTimer()
        currentIndex = 0
        seconds = 0
        right = 0
        wrong = 0
        wrongLabel.text = "\(0)"
        rightLabel.text = "\(0)"
        DenemefonksiyonIslemler()
    }
    
    @IBAction func zorButtons(_ sender: Any) {
        imageView.image = UIImage(named: "gokce1")
        secenekleriHidden()
        sureTuslariHidden()
        aferinLabel.text = ""
        startTimer()
        currentIndex = 25
        seconds = 0
        right = 0
        wrong = 0
        wrongLabel.text = "\(0)"
        rightLabel.text = "\(0)"
        ZORfonksiyonIslemler()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.title(for: .normal) == labelSonuc {
           // aferinLabel.text = "Doğru... Aferin Sana"
            dogruAferinSanaLabeli.text = "Doğru... Aferin Sana"
            sender.backgroundColor = .green
            right += 1
            rightLabel.text = "\(right)"
            currentIndex += 1
            alkis()
            questionLabel1.layer.isHidden = false
            questionLabel2.layer.isHidden = false
            questionLabel3.layer.isHidden = false
            
            if currentIndex == 30 {
                secenekleriHidden()
                stopTimer()
                sureTuslariHidden()
                imageView.image = UIImage(named: "gokce4")
                theEndAlert(titleM: "TEBRİKLER", messageM: "Süreniz: \(sureniz!)" )
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                dogruAferinSanaLabeli.text = ""
                DenemefonksiyonIslemler()}
            }
            
        } else if sender.title(for: .normal) == "\(result!)" {
           // aferinLabel.text = "Doğru... Aferin Sana"
            dogruAferinSanaLabeli.text = "Doğru... Aferin Sana"
            sender.backgroundColor = .green
            right += 1
            rightLabel.text = "\(right)"
            currentIndex += 1
            alkis()
            questionLabel1.layer.isHidden = false
            questionLabel2.layer.isHidden = false
            questionLabel3.layer.isHidden = false
            
            if currentIndex == 30 {
                secenekleriHidden()
                stopTimer()
                sureTuslariHidden()
                imageView.image = UIImage(named: "gokce4")
                theEndAlert(titleM: "TEBRİKLER", messageM: "Süreniz: \(sureniz!)" )
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                    dogruAferinSanaLabeli.text = ""
                    DenemefonksiyonIslemler()}
            }
        } else {
            wrong += 1
            tabiEfendim()
            //currentIndex += 1   BÖYLE YAPINCA SÜRE UZAYACAK
            wrongLabel.text = "\(wrong)"
            sender.backgroundColor = .red
            aferinLabel.text = "Yanlış Cevap.. Sonuç \(labelSonuc) olacaktı"
            print("labelSonuc: \(labelSonuc)")
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            questionLabel1.layer.isHidden = false
            questionLabel2.layer.isHidden = false
            questionLabel3.layer.isHidden = false
           NORMALfonksiyonIslemler()

            if wrongLabel.text == "\(3)" {  // MAX 10 YANLIŞ YAPABİLSİN
                stopTimer()
                makeAlert(titleM: "Üzgünüm :(", messageM: "Tüm Haklarını Kullandın")
                secenekleriHidden()
                sureTuslariHidden()
            }
           }
        }
    }
    
    
// ----------------------END ---------------------------------------------

    
    
    
// ----------- İŞLEM FONKSİYONLARI ------------------------------------------------
    /*
    func fonksiyonIslemler(){
        imageView.image = UIImage(named: "gokce1")
        aButton.backgroundColor = .none
        bButton.backgroundColor = .none
        cButton.backgroundColor = .none
        dButton.backgroundColor = .none
        aButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        var number1 = Int.random(in: 1...10)
        var number2 = Int.random(in: 1...10)
        
        if number1 > number2 {
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        } else {
            let changeNumber = number1
            number1 = number2
            number2 = changeNumber
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        }
        
        let  toplama = "\(number1) + \(number2)"
        let  cikarma = "\(number1) - \(number2)"
        let  carpma = "\(number1) x \(number2)"
        let  bolme = "\(number1) / \(number2)"

        sonucToplama = number1 + number2
        sonucCikarma = number1 - number2
        sonucCarpma = number1 * number2
        sonucBolme = number1 / number2

        soru1 = "\(number1)"
        soru2 = "\(number2)"
        
        
        questionLabel1.text = soru1
        questionLabel2.text = soru2
        
        
        
        let sayilar = [toplama,cikarma,carpma,bolme]
        
        let randomIndex = Int.random(in: 0..<sayilar.count)
        question = sayilar[randomIndex]
        
        
        if question == sayilar[0]{
            number1 = Int.random(in: 1...90)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "+"
            result = sonucToplama
        } else if question == sayilar[1] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "-"
            result = sonucCikarma
        } else if question == sayilar[2] {
            number1 = Int.random(in: 1...10)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "X"
            result = sonucCarpma
        } else if question == sayilar[3] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "/"
            result = sonucBolme
            
        }
        soru3 = "\(result!)"
        questionLabel3.text = soru3
        aferinLabel.text = "\(question!) = \(result!)"
        
        let labeller = labels.randomElement()!
        labeller.layer.isHidden = true
        labelSonuc = "\(labeller.text!)"
        print("Label Sonuc: \(labelSonuc)")
        if  labeller.text == soru1 {
            print("1 gizlendi")
        } else if labeller.text == soru2 {
            print("2 gizlendi")
        } else if labeller.text == soru3 {
            print("3 gizlendi")
        }
        
        // rastgele bir button seç ve işlem sonucunu göster
        let resultButton = buttons.randomElement()!
        resultButton.setTitle("\(labelSonuc)", for: .normal)
    


        // diğer buttonlara farklı sayılar ata
        for button in buttons where button != resultButton {
            button.setTitle("\(Int.random(in: result!-10...result!+10))", for: .normal)
            if result!  <= 10 {
                button.setTitle("\(Int.random(in: result!+1...result!+10))", for: .normal)
            }
        }
    }
    */
    
    
    
    func ZORfonksiyonIslemler(){
        imageView.image = UIImage(named: "gokce1")
        aButton.backgroundColor = .none
        bButton.backgroundColor = .none
        cButton.backgroundColor = .none
        dButton.backgroundColor = .none
        aButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        var number1 = Int.random(in: 1...10)
        var number2 = Int.random(in: 1...10)
        
        if number1 > number2 {
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        } else {
            let changeNumber = number1
            number1 = number2
            number2 = changeNumber
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        }
        
        let  toplama = "\(number1) + \(number2)"
        let  cikarma = "\(number1) - \(number2)"
        let  carpma = "\(number1) x \(number2)"
        let  bolme = "\(number1) / \(number2)"

        sonucToplama = number1 + number2
        sonucCikarma = number1 - number2
        sonucCarpma = number1 * number2
        sonucBolme = number1 / number2

        soru1 = "\(number1)"
        soru2 = "\(number2)"
        
        
        questionLabel1.text = soru1
        questionLabel2.text = soru2
        
        
        let sayilar = [toplama,cikarma,carpma,bolme]
        
        let randomIndex = Int.random(in: 0..<sayilar.count)
        question = sayilar[randomIndex]
        
        
        if question == sayilar[0]{
            number1 = Int.random(in: 1...90)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "+"
            result = sonucToplama
        } else if question == sayilar[1] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "-"
            result = sonucCikarma
        } else if question == sayilar[2] {
            number1 = Int.random(in: 1...10)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "X"
            result = sonucCarpma
        } else if question == sayilar[3] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "/"
            result = sonucBolme
            
        }
        soru3 = "\(result!)"
        questionLabel3.text = soru3
        aferinLabel.text = "\(question!) = \(result!)"
        
        let labeller = labels.randomElement()!
        labeller.layer.isHidden = true
        labelSonuc = "\(labeller.text!)"
        print("Label Sonuc: \(labelSonuc)")
        if  labeller.text == soru1 {
            print("1 gizlendi")
        } else if labeller.text == soru2 {
            print("2 gizlendi")
        } else if labeller.text == soru3 {
            print("3 gizlendi")
        }
        
        // rastgele bir button seç ve işlem sonucunu göster
        let resultButton = buttons.randomElement()!
        resultButton.setTitle("\(labelSonuc)", for: .normal)
    


        // diğer buttonlara farklı sayılar ata
        for button in buttons where button != resultButton {
            button.setTitle("\(Int.random(in: result!-10...result!+10))", for: .normal)
            if result!  <= 10 {
                button.setTitle("\(Int.random(in: result!+1...result!+10))", for: .normal)
            }
        }
    }
    
    
    
    
    
 
    
    
    
    
    
    
    func NORMALfonksiyonIslemler(){
        imageView.image = UIImage(named: "gokce1")
        aButton.backgroundColor = .none
        bButton.backgroundColor = .none
        cButton.backgroundColor = .none
        dButton.backgroundColor = .none
        
        var number1 = Int.random(in: 1...10)
        var number2 = Int.random(in: 1...10)
        
        if number1 > number2 {
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        } else {
            let changeNumber = number1
            number1 = number2
            number2 = changeNumber
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        }
        
        let  toplama = "\(number1) + \(number2)"
        let  cikarma = "\(number1) - \(number2)"
        let  carpma = "\(number1) x \(number2)"
        let  bolme = "\(number1) / \(number2)"

        sonucToplama = number1 + number2
        sonucCikarma = number1 - number2
        sonucCarpma = number1 * number2
        sonucBolme = number1 / number2

        soru1 = "\(number1)"
        soru2 = "\(number2)"
        
        
        questionLabel1.text = soru1
        questionLabel2.text = soru2
        ghostLabel.text = ghost
        ghostLabel.text = ghost2
        ghostLabel.text = ghost3
        ghostLabel.text = ghost4
        
        let sayilar = [toplama,cikarma,carpma,bolme]
        
        let randomIndex = Int.random(in: 0..<sayilar.count)
        question = sayilar[randomIndex]
        
        
        if question == sayilar[0]{
            number1 = Int.random(in: 1...90)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "+"
            result = sonucToplama
        } else if question == sayilar[1] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "-"
            result = sonucCikarma
        } else if question == sayilar[2] {
            number1 = Int.random(in: 1...10)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "X"
            result = sonucCarpma
        } else if question == sayilar[3] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "/"
            result = sonucBolme
            
        }
        soru31 = "\(result!)"
        questionLabel3.text = soru31
        soru3 = "\(result!)"
        questionLabel3.text = soru3
       
        aferinLabel.text = "\(question!) = \(result!)"
                
        let labeller = labels.randomElement()!
        labeller.layer.isHidden = true
        labelSonuc = "\(labeller.text!)"
        print("Label Sonuc: \(labelSonuc)")
        if  labeller.text == soru1 {
            print("1 gizlendi")
        } else if labeller.text == soru2 {
            print("2 gizlendi")
        } else if labeller.text == soru3 {
            print("3 gizlendi")
        }  else if labeller.text == soru3 {
            print("31 gizlendi")
        }
       
        
        // rastgele bir button seç ve işlem sonucunu göster
        let resultButton = buttons.randomElement()!
        resultButton.setTitle("\(labelSonuc)", for: .normal)
    


        // diğer buttonlara farklı sayılar ata
        for button in buttons where button != resultButton {
            button.setTitle("\(Int.random(in: result!-10...result!+10))", for: .normal)
            if result!  <= 10 {
                button.setTitle("\(Int.random(in: result!+1...result!+10))", for: .normal)
            }
        }
    }
    
    
    func DenemefonksiyonIslemler(){
        imageView.image = UIImage(named: "gokce1")
        aButton.backgroundColor = .none
        bButton.backgroundColor = .none
        cButton.backgroundColor = .none
        dButton.backgroundColor = .none
        
      
          var number1 = Int.random(in: 1...10)
          var number2 = Int.random(in: 1...10)
        
        if number1 > number2 {
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        } else {
            let changeNumber = number1
            number1 = number2
            number2 = changeNumber
            let sonuc = number1 / number2
            print("Sonuç: \(sonuc)")
        }
        
        let  toplama = "\(number1) + \(number2)"
        let  cikarma = "\(number1) - \(number2)"
        let  carpma = "\(number1) x \(number2)"
        let  bolme = "\(number1) / \(number2)"

        sonucToplama = number1 + number2
        sonucCikarma = number1 - number2
        sonucCarpma = number1 * number2
        sonucBolme = number1 / number2

        soru1 = "\(number1)"
        soru2 = "\(number2)"
        
        
        questionLabel1.text = soru1
        questionLabel2.text = soru2
        ghostLabel.text = ghost
        ghostLabel.text = ghost2
        ghostLabel.text = ghost3
        ghostLabel.text = ghost4
        
        let sayilar = [toplama,cikarma,carpma,bolme]
        
        let randomIndex = Int.random(in: 0..<sayilar.count)
        question = sayilar[randomIndex]
        
        /*
        if question == sayilar[1]{
            number1 = Int.random(in: 1...90)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "-"
            result = sonucCikarma
        }
        */
        
      // /*
        if question == sayilar[0]{
           let  number3 = Int.random(in: 90...99)
           let number4 = Int.random(in: 90...99)
            
            number1 = number3
            number2 = number4
            
            
            simgeLabel.text = "+"
            result = sonucToplama
        } else if question == sayilar[1] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "-"
            result = sonucCikarma
        } else if question == sayilar[2] {
            number1 = Int.random(in: 1...10)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "X"
            result = sonucCarpma
        } else if question == sayilar[3] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...10)
            simgeLabel.text = "/"
            result = sonucBolme
            
        }
    //     */
       
        soru3 = "\(result!)"
        questionLabel3.text = soru3
       
        aferinLabel.text = "\(question!) = \(result!)"
                print("currentIndex: \(currentIndex)")
        
        questionLabel3.layer.isHidden = true
        
        
        let icindeSec = [5, 8, 10]
        if icindeSec.contains(currentIndex) {
            questionLabel3.layer.isHidden = false
            let labeller = labels.randomElement()!
            labeller.layer.isHidden = true
            labelSonuc = "\(labeller.text!)"
            print("Label Sonuc: \(labelSonuc)")
            if  labeller.text == soru1 {
                print("1 gizlendi")
            } else if labeller.text == soru2 {
                print("2 gizlendi")
            } else if labeller.text == soru3 {
                print("3 gizlendi")
            }
            
            var assignedNumbers = Set<Int>()

            let resultButton = buttons.randomElement()!
            resultButton.setTitle("\(labelSonuc)", for: .normal)
            assignedNumbers.insert(Int(labelSonuc)!)

            for button in buttons where button != resultButton {
                if let labelSonucInt = Int(labelSonuc) {
                    var randomNumber = Int.random(in: labelSonucInt-10...labelSonucInt+10)
                    while assignedNumbers.contains(randomNumber) {
                        randomNumber = Int.random(in: labelSonucInt-10...labelSonucInt+10)
                    }
                    button.setTitle("\(randomNumber)", for: .normal)
                    assignedNumbers.insert(randomNumber)

                    if result! <= 10 {
                        var randomNumber = Int.random(in: labelSonucInt+1...labelSonucInt+5)
                        while assignedNumbers.contains(randomNumber) {
                            randomNumber = Int.random(in: labelSonucInt+1...labelSonucInt+5)
                        }
                        button.setTitle("\(randomNumber)", for: .normal)
                        assignedNumbers.insert(randomNumber)
                    }
                } else {
                    // labelSonuc Int tipine dönüştürülemedi, hata işleme kodu eklenmeli
                }
            }


            
        } else {
            
            var assignedNumbers = Set<Int>()

            let resultButton = buttons.randomElement()!
            resultButton.setTitle("\(result!)", for: .normal)
            assignedNumbers.insert(result!)

            for button in buttons where button != resultButton {
                if let labelSonucInt = result {
                    var randomNumber = Int.random(in: result!-10...result!+10)
                    while assignedNumbers.contains(randomNumber) {
                        randomNumber = Int.random(in: result!-10...result!+10)
                    }
                    button.setTitle("\(randomNumber)", for: .normal)
                    assignedNumbers.insert(randomNumber)

                    if result! <= 10 {
                        var randomNumber = Int.random(in: result!+1...result!+5)
                        while assignedNumbers.contains(randomNumber) {
                            randomNumber = Int.random(in: result!+1...result!+5)
                        }
                        button.setTitle("\(randomNumber)", for: .normal)
                        assignedNumbers.insert(randomNumber)
                    }
                } else {
                    // labelSonuc Int tipine dönüştürülemedi, hata işleme kodu eklenmeli
                }
            }


            /*
            let resultButton = buttons.randomElement()!
            resultButton.setTitle("\(result!)", for: .normal)
            
            // diğer buttonlara farklı sayılar ata
            for button in buttons where button != resultButton {
                button.setTitle("\(Int.random(in: result!-10...result!+10))", for: .normal)
                if result!  <= 10 {
                    button.setTitle("\(Int.random(in: result!+1...result!+10))", for: .normal)
                }
            }
             */
        }
        
        print("result: \(result!)")

        
 
    



    }
    
// ----------------------END ---------------------------------------------

}
