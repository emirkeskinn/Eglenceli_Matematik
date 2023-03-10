//
//  SubstractionPage.swift
//  Eglenceli_Matematik
//
//  Created by Emir Keskin on 26.01.2023.
//

import UIKit
import AVFoundation

class SubstractionPage: UIViewController {

    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var showAnswer: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var switchMode: UISwitch!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var audioNoneButton: UIButton!
    
    let customColor = UIColor(red: 0.463, green: 0.839, blue: 1000, alpha: 1.0)
    var audioPlayer = AVAudioPlayer()
    
    var question: String?
    var answer: String?
    var result: Int!
    var right: Int = 0
    var wrong: Int = 0
    var userAnswer: String?
    
    var timer = Timer()
    var counter: Int?
    
    var buttonsIsEnabled = true
    var audioPlayerNone = true
    var imageIndex = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(switchMode)
        print(switchMode.isOn)
        switchMode.isOn = true
        print(switchMode.isOn)
        sendButton.isHidden = true
        textField.isHidden = true
        aButton.layer.cornerRadius = 8
        bButton.layer.cornerRadius = 8
        cButton.layer.cornerRadius = 8
        dButton.layer.cornerRadius = 8
        sendButton.layer.cornerRadius = 8
        showAnswer.layer.cornerRadius = 8
        transactionFunc()
        scoreBoard()
        counter = 0
        timeLabel.text = "\(counter!)"
        audioNoneButton.setImage(UIImage(named: "sound"), for: .normal)
        switchMode.addTarget(self, action: #selector(forSwitchMode), for: .valueChanged)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)


    }
    

// ----------------FUNCTIONS ---------------------------------------------
        
        @objc func timerFunc() {
            counter! += 1
            timeLabel.text = "\(counter!)"
        }
        
        func scoreBoard() {
            rightLabel.text = "\(right)"
            wrongLabel.text = "\(wrong)"
        }
        
        @objc func forSwitchMode(){
            if switchMode.isOn {
                sendButton.isHidden = true
                textField.isHidden = true
                aButton.isHidden = false
                bButton.isHidden = false
                cButton.isHidden = false
                dButton.isHidden = false
                
            } else {
                sendButton.isHidden = false
                textField.isHidden = false
                aButton.isHidden = true
                bButton.isHidden = true
                cButton.isHidden = true
                dButton.isHidden = true
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
        
        
        func transactionFunc(){
            let number1 = Int.random(in: 1...99)
            let number2 = Int.random(in: 1...50)
            let  question = "\(number1) - \(number2)"
            aButton.backgroundColor = customColor
            bButton.backgroundColor = customColor
            cButton.backgroundColor = customColor
            dButton.backgroundColor = customColor
            sendButton.backgroundColor = customColor
            result = number1 - number2
            answer = "\(result!)"
            questionLabel.text = "\(question)"
            answerLabel.text =  ""
            imageView.loadGif(name: "clock")

            let resultButton = buttons.randomElement()!
            resultButton.setTitle("\(result!)", for: .normal)

            for button in buttons where button != resultButton {
                button.setTitle("\(Int.random(in: result-10...result+10))", for: .normal)
                if result  <= 10 {
                    button.setTitle("\(Int.random(in: result+1...result+10))", for: .normal)
                }
            }
        }
//----------------------END---------------------------------------------------------
        
        
        
//--------------------VOICES----------------------------------------------
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
//----------------------END----------------------------------------------------
        
        
        
        
// ---------------------BUTTONS------------------------------------------------
        @IBAction func buttonTapped(_ sender: UIButton) {
            if sender.title(for: .normal) == "\(result!)" {
                answerLabel.text = "Do??ru... Aferin Sana.. "
                imageView.image = UIImage(named: "kalp")
                print("Tebrikler!")
                right += 1
                rightLabel.text = "\(right)"
                sender.backgroundColor = .green
                buttonsEnabled()
                if audioPlayerNone == true {
                    applaud()
                }
                
                
            } else {
                answerLabel.text =  "Do??ru Cevap \(answer!) olacakt??"
                imageView.image = UIImage(named: "hayir")
                print("Yanl???? cevap, tekrar deneyin.")
                wrong += 1
                wrongLabel.text = "\(wrong)"
                sender.backgroundColor = .red
                buttonsEnabled()
                if audioPlayerNone == true {
                    tabiEfendim()
                }
            }
            Dispatch.DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.transactionFunc()
                self.buttonsEnabled()
            }
        }
        
        @IBAction func sendButtonTapped(_ sender: Any) {
        userAnswer = textField.text
          if userAnswer == answer {
              imageView.loadGif(name: "fisek")
              answerLabel.text = "Do??ru... Aferin Sana.. "
              if audioPlayerNone == true {
                  applaud()
              }
            } else {
                imageView.image = UIImage(named: "hayir")
                answerLabel.text = "Yanl????.. Do??ru Cevap \(answer!) olacakt??"
                if audioPlayerNone == true {
                    tabiEfendim()
                }
            }
            textField.text = ""
            transactionFunc()
            buttonsEnabled()
        }
        
        @IBAction func showSendButtonTapped(_ sender: Any) {
            answerLabel.text =  "Do??ru Cevap \(answer!) olacakt??"
            imageView.image = UIImage(named: "hayir")
            if audioPlayerNone == true {
                tabiEfendim()
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
//---------------------END-----------------------------------------------


}
