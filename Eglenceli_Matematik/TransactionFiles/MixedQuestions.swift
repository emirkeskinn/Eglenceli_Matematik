//
//  MixedQuestions.swift
//  Eglenceli_Matematik
//
//  Created by Emir Keskin on 4.02.2023.
//

import UIKit
import AVFoundation


class MixedQuestions: UIViewController {

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
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet weak var audioNoneButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    
    var randomIndex: Int?
    var currentIndex = 0
    
    var images = [UIImage(named: "1")]
    
    var question: String?
    var answer: String?
    var right: Int = 0
    var wrong: Int = 0
    var userAnswer: String?
    
    var timer = Timer()
    var counter: Int?
    
    var question3: String?

    var result: Int?
    var labelSonuc: String = "error"
    var yourTime: String?
    var seconds = 0
    var scoreBoard: [String] = ["5.00" ]
    
    var sayilarim = [5,8,10]
    
    var buttonsAreHidden = true
    var timeKeysHiddeny = true
    var hideButtons = true
    var switchKey = "difficulty"
    
    var addTime: [String] = []
    
    var audioPlayerNone = true
    
    var imageIndex = 1
    var buttonsIsEnabled = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(audioPlayerNone)

        imageView.image = UIImage(named: "gokce4")
        audioNoneButton.setImage(UIImage(named: "sound"), for: .normal)
        toggleButtons() // True - False
        timeKeysHidden()
        allButtonsHidden()
        
    

        easyButton.layer.cornerRadius = 10
        normalButton.layer.cornerRadius = 10
        hardButton.layer.cornerRadius = 10


        self.view.bringSubviewToFront(aButton)
        self.view.bringSubviewToFront(bButton)
        self.view.bringSubviewToFront(cButton)
        self.view.bringSubviewToFront(dButton)
        self.view.bringSubviewToFront(trueButton)
        self.view.bringSubviewToFront(falseButton)
        
        self.view.bringSubviewToFront(easyButton)
        self.view.bringSubviewToFront(normalButton)
        self.view.bringSubviewToFront(hardButton)
        self.view.bringSubviewToFront(answerLabel)
        
        if let timeEklenecek = UserDefaults.standard.object(forKey: "sure7") as? [String] {
           addTime = timeEklenecek
        }
        print("UD set edilen time VDL: \(addTime)")
         scoreBoard.append(contentsOf: addTime)
             print("UD alınan time verisini alıp -> skorTablosu.append(contentsOf: addTime) hali \(scoreBoard)")
      
        
        if let skorTablom = UserDefaults.standard.object(forKey: "surem7") {
            let skorTablom2 = skorTablom
         print("UD set edilen skor tablosu VDL (skorTablosu.append(time)): \(skorTablom2)")
            scoreBoard = skorTablom2 as! [String]
            scoreBoard = scoreBoard.sorted()
            
            print("değiştirilen skor tablosu: \(scoreBoard)")
        }
    }
    
    
    
    
    
// ----------  TIME TRANSACTIONS -- SCORE TRANSACTIONS AND TABLES  ----------------
        
        func startTimer() {
            seconds = 0
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }

        @objc func updateCounter() {
            seconds += 1
            timeLabel.text = "\(seconds)"
        }
        
        
        func stopTimer() {
            timer.invalidate()
            let minutes = seconds / 60
            let remainingSeconds = seconds % 60
            let time = "\(minutes) Dakika :\(remainingSeconds < 10 ? "0\(remainingSeconds)" : "\(remainingSeconds) Saniye")"
            print("time: \(time)")
            yourTime = time
            
            scoreBoard.append(time)
            print(("skorTablosu.append: \(time)"))
            
             UserDefaults.standard.set(time, forKey: "sure")
            if let myTimer = UserDefaults.standard.object(forKey: "sure") {
                         let myTimer2 = myTimer
                         print("UD set edilen time: \(myTimer2)")
            }
        }
        
        
        func scoreBoarding() {
            rightLabel.text = "\(right)"
            wrongLabel.text = "\(wrong)"
        }
        
//------------ END -------------------------------------------------------------

        
        
        
        
// ------------ VOICES ----------------------------------------------------

        func applaud() {
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
        
    func noneVoices(){
        
        
        if  audioPlayerNone {
            audioPlayer.volume = 0
            audioPlayerNone = false
        } else {
            audioPlayer.volume = 1
            audioPlayerNone = true
        }
    }
        
//------------ END -------------------------------------------------------------

        
        
// ----------- ALERT FUNCTIONS ------------------------------------------------
        
        
        func theEndAlert(titleM: String, messageM: String) {
            
            let alertController = UIAlertController(title: titleM, message: messageM, preferredStyle: .alert)
               let okAction = UIAlertAction(title: "Tamam", style: .default) { (action) in
                 //  let newViewController = ScoreBoard()
                //   self.navigationController?.pushViewController(newViewController, animated: true)
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
        
//------------ END -------------------------------------------------------------

        
        
        
        
        
// ----------------FUNCTIONS ---------------------------------------------
          
            func allButtonsHidden() {
                if hideButtons {
                    easyButton.layer.isHidden = false
                    normalButton.layer.isHidden = false
                    hardButton.layer.isHidden = false
                    imageView.layer.isHidden = false
                    aButton.layer.isHidden = true
                    bButton.layer.isHidden = true
                    cButton.layer.isHidden = true
                    dButton.layer.isHidden = true
                    answerLabel.layer.isHidden = true
                    questionLabel1.layer.isHidden = true
                    questionLabel2.layer.isHidden = true
                    questionLabel3.layer.isHidden = true
                    answerLabel.layer.isHidden = true
                    iconLabel.layer.isHidden = true
                    audioNoneButton.layer.isHidden = true
                    equalLabel.layer.isHidden = true
                    hideButtons = false
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
                    questionLabel1.layer.isHidden = false
                    questionLabel2.layer.isHidden = false
                    questionLabel3.layer.isHidden = false
                    answerLabel.layer.isHidden = false
                    iconLabel.layer.isHidden = false
                    equalLabel.layer.isHidden = false
                    audioNoneButton.layer.isHidden = false
                    hideButtons = true
                }
            }
            
            
            func timeKeysHidden() {
                if timeKeysHiddeny {
                    timeTitle.layer.isHidden = true
                    timeLabel.layer.isHidden = true
                    rightTitle.layer.isHidden = true
                    rightLabel.layer.isHidden = true
                    wrongTitle.layer.isHidden = true
                    wrongLabel.layer.isHidden = true
                    answerLabel.layer.isHidden = true
                    timeKeysHiddeny = false
                } else {
                    timeTitle.layer.isHidden = false
                    timeLabel.layer.isHidden = false
                    rightTitle.layer.isHidden = false
                    rightLabel.layer.isHidden = false
                    wrongTitle.layer.isHidden = false
                    wrongLabel.layer.isHidden = false
                    answerLabel.layer.isHidden = false
                    timeKeysHiddeny = true
                }
            }
            
            func toggleButtons() {
                if buttonsAreHidden {
                    trueButton.layer.isHidden = true
                    falseButton.layer.isHidden = true
                    buttonsAreHidden = false
                } else {
                    trueButton.layer.isHidden = false
                    falseButton.layer.isHidden = false
                    buttonsAreHidden = true
                }
            }
            
    func buttonsEnabled() {
        if buttonsIsEnabled {
            aButton.isEnabled = false
            bButton.isEnabled = false
            cButton.isEnabled = false
            dButton.isEnabled = false
            buttonsIsEnabled = false
        } else {
            aButton.isEnabled = true
            bButton.isEnabled = true
            cButton.isEnabled = true
            dButton.isEnabled = true
            buttonsIsEnabled = true
        }
    }
            
            
// ----------------------END ---------------------------------------------


    
    
// ----------------BUTTONS ---------------------------------------------
       
        @IBAction func easyButton(_ sender: UIButton) {
            imageView.image = UIImage(named: "gokce1")
            allButtonsHidden()
            timeKeysHidden()
            answerLabel.text = ""
            startTimer()
            currentIndex = 38
            seconds = 0
            right = 0
            wrong = 0
            wrongLabel.text = "\(0)"
            rightLabel.text = "\(0)"
            switchKey = "easy"
            transactionFunction()
        }
        
        @IBAction func normalButtons(_ sender: UIButton) {
            
            imageView.image = UIImage(named: "gokce1")
            allButtonsHidden()
            timeKeysHidden()
            answerLabel.text = ""
            startTimer()
            currentIndex = 20
            seconds = 0
            right = 0
            wrong = 0
            wrongLabel.text = "\(0)"
            rightLabel.text = "\(0)"
            switchKey = "normal"
            transactionFunction()
        }
        
        @IBAction func zorButtons(_ sender: Any) {
            imageView.image = UIImage(named: "sablon2")
            allButtonsHidden()
            timeKeysHidden()
            answerLabel.text = ""
            startTimer()
            currentIndex = 0
            seconds = 0
            right = 0
            wrong = 0
            wrongLabel.text = "\(0)"
            rightLabel.text = "\(0)"
            switchKey = "hard"
            transactionFunction()
        }
        
    
        
        @IBAction func buttonTapped(_ sender: UIButton) {
            if sender.title(for: .normal) == labelSonuc {
                answerLabel.text = "Doğru... Aferin Sana"
                sender.backgroundColor = .green
                right += 1
                rightLabel.text = "\(right)"
                currentIndex += 1
                buttonsEnabled()
                
                questionLabel1.layer.isHidden = false
                questionLabel2.layer.isHidden = false
                questionLabel3.layer.isHidden = false
                
                if audioPlayerNone == true {
                    applaud()
                }
                
                
                
                if currentIndex == 40 {
                    stopTimer()
                    allButtonsHidden()
                    timeKeysHidden()
                    
                    UserDefaults.standard.set(scoreBoard, forKey: "surem7")
                   if let myScoreBoard = UserDefaults.standard.object(forKey: "surem7") {
                       let myScoreBoard2 = myScoreBoard
                    print("UD set edilen skor tablosu (skorTablosu.append(time)): \(myScoreBoard2)")
                   }
                    
                    imageView.image = UIImage(named: "gokce4")
                    theEndAlert(titleM: "TEBRİKLER", messageM: "Süreniz: \(yourTime!)" )
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                        answerLabel.text = ""
                        transactionFunction()
                        buttonsEnabled()
                    }
                }
                
            } else if sender.title(for: .normal) == "\(result!)" {
                answerLabel.text = "Doğru... Aferin Sana"
                sender.backgroundColor = .green
                right += 1
                rightLabel.text = "\(right)"
                currentIndex += 1
                buttonsEnabled()
                questionLabel1.layer.isHidden = false
                questionLabel2.layer.isHidden = false
                questionLabel3.layer.isHidden = false
                
                if audioPlayerNone == true {
                    applaud()
                }
                
                if currentIndex == 40 {
                    stopTimer()
                    allButtonsHidden()
                    timeKeysHidden()
                    
                    UserDefaults.standard.set(scoreBoard, forKey: "surem7")
                   if let myScoreBoard = UserDefaults.standard.object(forKey: "surem7") {
                       let myScoreBoard2 = myScoreBoard
                    print("UD set edilen skor tablosu (skorTablosu.append(time)): \(myScoreBoard2)")
                   }
                    
                    
                    imageView.image = UIImage(named: "gokce4")
                    theEndAlert(titleM: "TEBRİKLER", messageM: "Süreniz: \(yourTime!)" )
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                        answerLabel.text = ""
                        transactionFunction()
                        buttonsEnabled()
                        
                    }
                }
            } else {
                if labelSonuc == "error" {
                    answerLabel.text = "Yanlış Cevap.. Sonuç \(result!) olacaktı"
                } else {
                    answerLabel.text = "Yanlış Cevap.. Sonuç \(labelSonuc) olacaktı"
                }
                wrong += 1
                wrongLabel.text = "\(wrong)"
                sender.backgroundColor = .red
                buttonsEnabled()
                if audioPlayerNone == true {
                    tabiEfendim()
                }
                
                print("labelSonuc: \(labelSonuc)")
                questionLabel1.layer.isHidden = false
                questionLabel2.layer.isHidden = false
                questionLabel3.layer.isHidden = false
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                self.buttonsEnabled()
               transactionFunction()
                

                if wrongLabel.text == "\(5)" {  // MAX 10 YANLIŞ YAPABİLSİN
                    stopTimer()
                    makeAlert(titleM: "Üzgünüm :(", messageM: "Tüm Haklarını Kullandın")
                    allButtonsHidden()
                    timeKeysHidden()
                }
               }
            }
        }
    
  
    @IBAction func noVoices(_ sender: Any) {
        
       noneVoices()
    
        if imageIndex == 1 {
                audioNoneButton.setImage(UIImage(named: "nosound2"), for: .normal)
                imageIndex = 2
            } else {
                audioNoneButton.setImage(UIImage(named: "sound"), for: .normal)
                imageIndex = 1
        }
    }
    
    
        
        
// ----------------------END --------------------------------------------

    
    
    
// ----------- İŞLEM FONKSİYONLARI ------------------------------------------------
    
    
    func fixUpNumbers() {
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
    }
    
    
    
    
    func transactionFunction(){
        aButton.backgroundColor = .none
        bButton.backgroundColor = .none
        cButton.backgroundColor = .none
        dButton.backgroundColor = .none
        
          var number1 = 0
          var number2 = 0
        
        let transactions = ["toplama","cikarma","carpma","bolme"]
        let randomIndex = Int.random(in: 0..<transactions.count)
        question = transactions[randomIndex]
        
        if question == transactions[0]{
            number1 = Int.random(in: 1...99)
            number2 = Int.random(in: 1...99)
            questionLabel1.text = "\(number1)"
            questionLabel2.text = "\(number2)"
            result = number1 + number2
            iconLabel.text = "+"
            fixUpNumbers()
        } else if question == transactions[1] {
            number1 = Int.random(in: 1...100)
            number2 = Int.random(in: 1...50)
            
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
            questionLabel1.text = "\(number1)"
            questionLabel2.text = "\(number2)"
            result = number1 - number2
            iconLabel.text = "-"
            
        } else if question == transactions[2] {
            number1 = Int.random(in: 1...10)
            number2 = Int.random(in: 1...10)
            questionLabel1.text = "\(number1)"
            questionLabel2.text = "\(number2)"
            result = number1 * number2
            iconLabel.text = "X"
            fixUpNumbers()
        } else if question == transactions[3] {
            number1 = Int.random(in: 1...100)
            let factors = (1...number1).filter { number1 % $0 == 0 }
            number2 = factors.randomElement()!
            questionLabel1.text = "\(number1)"
            questionLabel2.text = "\(number2)"
            result = number1 / number2
            iconLabel.text = "/"
            fixUpNumbers()
        }

        question3 = "\(result!)"
        questionLabel3.text = question3
        answerLabel.text = "\(question!) = \(result!) LabelSonuc: \(result!)"
        print("currentIndex: \(currentIndex)")
        
    
        
        if switchKey == "normal" {
            
        let chooseFrom = [5,8,10,14,18,22,28,33,38]
        if chooseFrom.contains(currentIndex) {
            questionLabel3.layer.isHidden = false
            let labeller = labels.randomElement()!
            labeller.layer.isHidden = true
            labelSonuc = "\(labeller.text!)"
            print("Label Sonuc: \(labelSonuc)")
            answerLabel.text = labelSonuc
            
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

                    if labelSonucInt <= 10 {
                        var randomNumber = Int.random(in: labelSonucInt+1...labelSonucInt+5)
                        while assignedNumbers.contains(randomNumber) {
                            randomNumber = Int.random(in: labelSonucInt+1...labelSonucInt+5)
                        }
                        button.setTitle("\(randomNumber)", for: .normal)
                        assignedNumbers.insert(randomNumber)
                    }
                } else {
                    print("error")
                }
            }
        } else {
            questionLabel3.layer.isHidden = true
            
            var assignedNumbers = Set<Int>()

            let resultButton = buttons.randomElement()!
            resultButton.setTitle("\(result!)", for: .normal)
            assignedNumbers.insert(result!)

            for button in buttons where button != resultButton {
                if let labelSonucInt = result {
                    var randomNumber = Int.random(in: labelSonucInt-10...labelSonucInt+10)
                    while assignedNumbers.contains(randomNumber) {
                        randomNumber = Int.random(in: labelSonucInt-10...labelSonucInt+10)
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
        }
        print("result: \(result!)")
            
        } else if  switchKey == "easy" {
      questionLabel3.layer.isHidden = true
            labelSonuc = question3 ?? "olmadi be"
            // rastgele bir button seç ve işlem sonucunu göster
            let resultButton = buttons.randomElement()!
            resultButton.setTitle("\(labelSonuc)", for: .normal)
        
            for button in buttons where button != resultButton {
                button.setTitle("\(Int.random(in: result!-10...result!+10))", for: .normal)
                if result!  <= 10 {
                    button.setTitle("\(Int.random(in: result!+1...result!+10))", for: .normal)
                }
            }
            
        } else if switchKey == "hard" {
            let labeller = labels.randomElement()!
            labeller.layer.isHidden = true
            labelSonuc = "\(labeller.text!)"
            print("Label Sonuc: \(labelSonuc)")
            answerLabel.text = labelSonuc

            var assignedNumbers = Set<Int>()
            let resultButton = buttons.randomElement()!
            resultButton.setTitle("\(labelSonuc)", for: .normal)
            assignedNumbers.insert(Int(labelSonuc)!)  //ATANMIŞ NUMARALAR

            for button in buttons where button != resultButton {
                if let labelSonucInt = Int(labelSonuc) {
                    var randomNumber = Int.random(in: labelSonucInt-5...labelSonucInt+10)
                    while assignedNumbers.contains(randomNumber) {
                        randomNumber = Int.random(in: labelSonucInt-5...labelSonucInt+10)
                    }
                    button.setTitle("\(randomNumber)", for: .normal)
                    assignedNumbers.insert(randomNumber)

                    if labelSonucInt <= 5 {
                        var randomNumber = Int.random(in: labelSonucInt+1...labelSonucInt+5)
                        while assignedNumbers.contains(randomNumber) {
                            randomNumber = Int.random(in: labelSonucInt+1...labelSonucInt+5)
                        }
                        button.setTitle("\(randomNumber)", for: .normal)
                        assignedNumbers.insert(randomNumber)
                    }
                    
                    
                    
                    
                } else {
                   print("error")
                }
            }
        }
    }
// ----------------------END ---------------------------------------------
}
