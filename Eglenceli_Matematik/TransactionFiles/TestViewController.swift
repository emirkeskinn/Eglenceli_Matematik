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
    @IBOutlet weak var aferinLabel: UILabel!
    @IBOutlet weak var simgeLabel: UILabel!
    @IBOutlet weak var esittirLabel: UILabel!
    
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
    
    var result: Int?
    var labelSonuc: String = "error"
    
    
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



    }
    

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
        fonksiyonIslemler()
    }
    
    
    @IBAction func normalButtons(_ sender: UIButton) {
        
        secenekleriHidden()
        sureTuslariHidden()
        aferinLabel.text = ""
        NORMALfonksiyonIslemler()

    }
    
    
    @IBAction func zorButtons(_ sender: Any) {
        result = 0
        secenekleriHidden()
        sureTuslariHidden()
        aferinLabel.text = ""
        ZORfonksiyonIslemler()
        
    }
    
    
    
    
    
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.title(for: .normal) == labelSonuc {
            aferinLabel.text = "Doğru... Aferin Sana"
        } else {
            aferinLabel.text = "Yanlış Cevap.. Sonuç \(labelSonuc) olacaktı"
            print("labelSonuc: \(labelSonuc)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
        imageView.image = images[currentIndex]
            questionLabel1.layer.isHidden = false
            questionLabel2.layer.isHidden = false
            questionLabel3.layer.isHidden = false
           fonksiyonIslemler()

            
           
            
        }}
    
    
    
// ----------------------END ---------------------------------------------

    
    
    
// ----------- İŞLEM FONKSİYONLARI ------------------------------------------------

    
    func ZORfonksiyonIslemler(){
        aButton.backgroundColor = .systemGray5
        bButton.backgroundColor = .systemGray5
        cButton.backgroundColor = .systemGray5
        dButton.backgroundColor = .systemGray5
        trueButton.tintColor = .green
        falseButton.tintColor = .red
        
 
        
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
        let  TFtoplama = "\(number1) + \(number2)"

        sonucToplama = number1 + number2
        sonucCikarma = number1 - number2
        sonucCarpma = number1 * number2
        sonucBolme = number1 / number2
        sonucTFtoplama = number1 + number2

        soru1 = "\(number1)"
        soru2 = "\(number2)"
        
        
        questionLabel1.text = soru1
        questionLabel2.text = soru2
        
        
        let sayilar = [toplama,cikarma,carpma,bolme,TFtoplama]
        
        let randomIndex = Int.random(in: 0..<sayilar.count)
        question = sayilar[randomIndex]
        
      
        
        if question == sayilar[0]{
            number1 = Int.random(in: 1...90)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "+"
            result = sonucToplama
            print("oldu gardas")
            toggleButtons()
            questionLabel1.layer.isHidden = false
            questionLabel2.layer.isHidden = false
            questionLabel3.layer.isHidden = false
        } else if question == sayilar[1] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...50)
            simgeLabel.text = "-"
            result = sonucCikarma
            labelleriGizle()
        }
        
        
        
        
        
        soru3 = "\(result!)"
        questionLabel3.text = soru3
        aferinLabel.text = "\(question!) = \(result!)"
        
        
    }
        
        func labelleriGizle() {
            
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
        aButton.backgroundColor = .systemGray5
        bButton.backgroundColor = .systemGray5
        cButton.backgroundColor = .systemGray5
        dButton.backgroundColor = .systemGray5
        trueButton.tintColor = .green
        falseButton.tintColor = .red
        
 
        
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
            print("oldu gardas")
            toggleButtons()
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
            result = sonucBolme }
        
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
    
    
    
    
    
    
    
    
    
    func fonksiyonIslemler(){
        imageView.image = UIImage(named: "gokce1")
        aButton.backgroundColor = .none
        aButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        aButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)


        bButton.backgroundColor = .systemGray5
        cButton.backgroundColor = .systemGray5
        dButton.backgroundColor = .systemGray5

        
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
    
// ----------------------END ---------------------------------------------

}
