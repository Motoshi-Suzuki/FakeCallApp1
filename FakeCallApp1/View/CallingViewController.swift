//
//  CallingViewController.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/05/08.
//

import UIKit

class CallingViewController: UIViewController {
    
    @IBOutlet weak var callerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
//    @IBOutlet weak var muteButton: UIButton!
//    @IBOutlet weak var keypadButton: UIButton!
//    @IBOutlet weak var audioButton: UIButton!
//    @IBOutlet weak var addCallButton: UIButton!
//    @IBOutlet weak var faceTimeButton: UIButton!
//    @IBOutlet weak var contactsButton: UIButton!
//    @IBOutlet weak var muteLabel: UILabel!
//    @IBOutlet weak var keypadLabel: UILabel!
//    @IBOutlet weak var audioLabel: UILabel!
//    @IBOutlet weak var addCallLabel: UILabel!
//    @IBOutlet weak var faceTimeLabel: UILabel!
//    @IBOutlet weak var contactsLabel: UILabel!
    @IBOutlet weak var hangUpButton: UIButton!
    private var timer: Timer?
    private var elapsedTime: Double = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissCallingView), name: .callFinished, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let screenWidth: CGFloat = view.frame.width
        let screenHeight: CGFloat = view.frame.height
        
        // Create blurView
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.frame
        view.insertSubview(blurView, aboveSubview: view)
        
        // Create Caller Name Label
        if let caller = UserDefaults.standard.string(forKey: "caller") {
            callerNameLabel.text = caller
        }
        callerNameLabel.frame.size = CGSize(width: screenWidth - 50, height: 40)
        callerNameLabel.frame.origin = CGPoint(x: (screenWidth - callerNameLabel.frame.width) / 2, y: screenHeight * 0.12)
        blurView.contentView.addSubview(callerNameLabel)
        
        // Create Timer Label
        timerLabel.frame.size = CGSize(width: 5, height: 30)
        timerLabel.frame.origin = CGPoint(x: (screenWidth - timerLabel.frame.width) / 2, y: callerNameLabel.frame.origin.y + callerNameLabel.frame.height)
        blurView.contentView.addSubview(timerLabel)
        
        let timerLabelSize = CGSize(width: 29, height: 35)
        minuteLabel.frame.size = timerLabelSize
        minuteLabel.frame.origin = CGPoint(x: timerLabel.frame.origin.x - timerLabelSize.width, y: timerLabel.frame.origin.y)
        blurView.contentView.addSubview(minuteLabel)
        
        secondLabel.frame.size = timerLabelSize
        secondLabel.frame.origin = CGPoint(x: timerLabel.frame.origin.x + timerLabel.frame.width + 1, y: timerLabel.frame.origin.y)
        blurView.contentView.addSubview(secondLabel)
        
        // Buttons, ButtonImages and Labels in the first row
        let buttonSize = CGSize(width: 75, height: 75)
//        let labelSize = CGSize(width: buttonSize.width, height: 34)
//        let buttonImageSize = CGSize(width: 40, height: 40)
//        let buttonImageWidthMargin = (buttonSize.width - buttonImageSize.width) / 2
//        let buttonImageHeightMargin = (buttonSize.height - buttonImageSize.height) / 2
        let roundOff = buttonSize.width / 2
//        let firstRowMarginFromCentre = screenHeight * 0.00615
        let buttonImageColor = UIColor.white
        let buttonImageContentMode = UIImageView.ContentMode.scaleAspectFit
        
        // keypad Button
//        keypadButton.frame.size = buttonSize
//        keypadButton.frame.origin = CGPoint(x: screenWidth / 2 - buttonSize.width / 2, y: screenHeight / 2 - (buttonSize.height + labelSize.height + firstRowMarginFromCentre))
//        keypadButton.layer.cornerRadius = roundOff
//        keypadButton.showsTouchWhenHighlighted = true
//        blurView.contentView.addSubview(keypadButton)
//
//        let keypadImage = UIImage(named: "keypad4")
//        let keypadImageView = UIImageView(image: keypadImage)
//        keypadImageView.frame.size = buttonImageSize
//        keypadImageView.frame.origin = CGPoint(x: keypadButton.frame.origin.x + buttonImageWidthMargin, y: keypadButton.frame.origin.y + buttonImageHeightMargin)
//        keypadImageView.tintColor = buttonImageColor
//        keypadImageView.contentMode = buttonImageContentMode
//        blurView.contentView.addSubview(keypadImageView)
        
        // mute Button
//        muteButton.frame.size = buttonSize
//        muteButton.frame.origin = CGPoint(x: keypadButton.frame.origin.x - (buttonSize.width + screenWidth * 0.079), y: keypadButton.frame.origin.y)
//        muteButton.layer.cornerRadius = roundOff
//        muteButton.showsTouchWhenHighlighted = true
//        blurView.contentView.addSubview(muteButton)
//
//        let muteImage = UIImage(systemName: "mic.slash.fill")
//        let muteImageView = UIImageView(image: muteImage)
//        muteImageView.frame.size = buttonImageSize
//        muteImageView.frame.origin = CGPoint(x: muteButton.frame.origin.x + buttonImageWidthMargin, y: muteButton.frame.origin.y + buttonImageHeightMargin)
//        muteImageView.tintColor = buttonImageColor
//        muteImageView.contentMode = buttonImageContentMode
//        blurView.contentView.addSubview(muteImageView)
        
        // audio Button
//        audioButton.frame.size = buttonSize
//        audioButton.frame.origin = CGPoint(x: keypadButton.frame.origin.x + buttonSize.width + screenWidth * 0.079, y: keypadButton.frame.origin.y)
//        audioButton.layer.cornerRadius = roundOff
//        audioButton.showsTouchWhenHighlighted = true
//        blurView.contentView.addSubview(audioButton)
        
        // Size of audioImage is bigger than the others
//        let audioImage = UIImage(systemName: "speaker.wave.3.fill")
//        let audioImageView = UIImageView(image: audioImage)
//        audioImageView.frame.size = CGSize(width: 45, height: 45)
//        audioImageView.frame.origin = CGPoint(x: audioButton.frame.origin.x + (buttonSize.width - audioImageView.frame.width) / 2, y: audioButton.frame.origin.y + (buttonSize.height - audioImageView.frame.height) / 2)
//        audioImageView.tintColor = buttonImageColor
//        audioImageView.contentMode = buttonImageContentMode
//        blurView.contentView.addSubview(audioImageView)
        
        // Labels in the first row
//        keypadLabel.frame.size = labelSize
//        keypadLabel.frame.origin = CGPoint(x: keypadButton.frame.origin.x, y: keypadButton.frame.origin.y + buttonSize.height)
//        blurView.contentView.addSubview(keypadLabel)
//
//        muteLabel.frame.size = labelSize
//        muteLabel.frame.origin = CGPoint(x: muteButton.frame.origin.x, y: keypadLabel.frame.origin.y)
//        blurView.contentView.addSubview(muteLabel)
//
//        audioLabel.frame.size = labelSize
//        audioLabel.frame.origin = CGPoint(x: audioButton.frame.origin.x, y: keypadLabel.frame.origin.y)
//        blurView.contentView.addSubview(audioLabel)
        
        // Buttons, ButtonImages and Labels in the second row
        // FaceTime Button
//        faceTimeButton.frame.size = buttonSize
//        faceTimeButton.frame.origin = CGPoint(x: keypadButton.frame.origin.x, y: screenHeight / 2 + firstRowMarginFromCentre * 1.6)
//        faceTimeButton.layer.cornerRadius = roundOff
//        faceTimeButton.showsTouchWhenHighlighted = true
//        blurView.contentView.addSubview(faceTimeButton)
        
        // Size of faceTimeImage is bigger that the others
//        let faceTimeImage = UIImage(systemName: "questionmark.video.fill")
//        let faceTimeImageView = UIImageView(image: faceTimeImage)
//        faceTimeImageView.frame.size = CGSize(width: 45, height: 45)
//        faceTimeImageView.frame.origin = CGPoint(x: faceTimeButton.frame.origin.x + (buttonSize.width - faceTimeImageView.frame.width) / 2, y: faceTimeButton.frame.origin.y + (buttonSize.height - faceTimeImageView.frame.height) / 2)
//        faceTimeImageView.tintColor = buttonImageColor
//        faceTimeImageView.contentMode = buttonImageContentMode
//        blurView.contentView.addSubview(faceTimeImageView)
        
        // add call Button
//        addCallButton.frame.size = buttonSize
//        addCallButton.frame.origin = CGPoint(x: muteButton.frame.origin.x, y: faceTimeButton.frame.origin.y)
//        addCallButton.layer.cornerRadius = roundOff
//        addCallButton.showsTouchWhenHighlighted = true
//        blurView.contentView.addSubview(addCallButton)
        
        // Size of audioImage is smaller than the others
//        let addCallImage = UIImage(systemName: "plus")
//        let addCallImageView = UIImageView(image: addCallImage)
//        addCallImageView.frame.size = CGSize(width: 35, height: 35)
//        addCallImageView.frame.origin = CGPoint(x: addCallButton.frame.origin.x + (buttonSize.width - addCallImageView.frame.width) / 2, y: addCallButton.frame.origin.y + (buttonSize.height - addCallImageView.frame.height) / 2)
//        addCallImageView.tintColor = buttonImageColor
//        addCallImageView.contentMode = buttonImageContentMode
//        blurView.contentView.addSubview(addCallImageView)
        
        // contacts Button
//        contactsButton.frame.size = buttonSize
//        contactsButton.frame.origin = CGPoint(x: audioButton.frame.origin.x, y: faceTimeButton.frame.origin.y)
//        contactsButton.layer.cornerRadius = roundOff
//        contactsButton.showsTouchWhenHighlighted = true
//        blurView.contentView.addSubview(contactsButton)
        
        // Size of contactsImage is smaller than the others
//        let contactsImage = UIImage(systemName: "person.crop.circle")
//        let contactsImageView = UIImageView(image: contactsImage)
//        contactsImageView.frame.size = CGSize(width: 37, height: 37)
//        contactsImageView.frame.origin = CGPoint(x: contactsButton.frame.origin.x + (buttonSize.width - contactsImageView.frame.width) / 2, y: contactsButton.frame.origin.y + (buttonSize.height - contactsImageView.frame.height) / 2)
//        contactsImageView.tintColor = buttonImageColor
//        contactsImageView.contentMode = buttonImageContentMode
//        blurView.contentView.addSubview(contactsImageView)
        
        // Labels in the second row
//        faceTimeLabel.frame.size = labelSize
//        faceTimeLabel.frame.origin = CGPoint(x: keypadButton.frame.origin.x, y: faceTimeButton.frame.origin.y + buttonSize.height)
//        blurView.contentView.addSubview(faceTimeLabel)
//
//        addCallLabel.frame.size = labelSize
//        addCallLabel.frame.origin = CGPoint(x: muteButton.frame.origin.x, y: faceTimeLabel.frame.origin.y)
//        blurView.contentView.addSubview(addCallLabel)
//
//        contactsLabel.frame.size = labelSize
//        contactsLabel.frame.origin = CGPoint(x: audioButton.frame.origin.x, y: faceTimeLabel.frame.origin.y)
//        blurView.contentView.addSubview(contactsLabel)
        
        // New Mute Image
        let muteImageView = UIImageView(image: UIImage(systemName: "mic.slash.fill"))
        muteImageView.frame.size = CGSize(width: 30, height: 30)
        muteImageView.frame.origin = CGPoint(x: screenWidth * 0.25 - muteImageView.frame.width / 2, y: screenHeight * 0.6)
        muteImageView.tintColor = buttonImageColor
        muteImageView.contentMode = buttonImageContentMode
        blurView.contentView.addSubview(muteImageView)
        
        let muteLabel = UILabel()
        muteLabel.frame.size = CGSize(width: 40, height: 20)
        muteLabel.frame.origin = CGPoint(x: (muteImageView.frame.origin.x + muteImageView.frame.width / 2) - muteLabel.frame.width / 2, y: muteImageView.frame.origin.y + muteImageView.frame.height + 5)
        muteLabel.text = "mute"
        muteLabel.textAlignment = .center
        muteLabel.textColor = buttonImageColor
        blurView.contentView.addSubview(muteLabel)
        
        // New Speaker Image
        let speakerImageView = UIImageView(image: UIImage(systemName: "speaker.wave.3.fill"))
        speakerImageView.frame.size = CGSize(width: 35, height: 35)
        speakerImageView.frame.origin = CGPoint(x: screenWidth * 0.75 - speakerImageView.frame.width / 2, y: muteImageView.frame.origin.y - (speakerImageView.frame.height - muteImageView.frame.height) / 2)
        speakerImageView.tintColor = buttonImageColor
        speakerImageView.contentMode = buttonImageContentMode
        blurView.contentView.addSubview(speakerImageView)
        
        let speakerLabel = UILabel()
        speakerLabel.frame.size = CGSize(width: 80, height: 20)
        speakerLabel.frame.origin = CGPoint(x: (speakerImageView.frame.origin.x + speakerImageView.frame.width / 2) - speakerLabel.frame.width / 2, y: muteLabel.frame.origin.y)
        speakerLabel.text = "speaker"
        speakerLabel.textAlignment = .center
        speakerLabel.textColor = buttonImageColor
        blurView.contentView.addSubview(speakerLabel)
        
        // Hang Up Button
        let hangUpImage = UIImage(systemName: "phone.down.fill")
        hangUpButton.frame.size = buttonSize
        hangUpButton.frame.origin = CGPoint(x: screenWidth / 2 - buttonSize.width / 2, y: screenHeight * 0.75)
        hangUpButton.setImage(hangUpImage, for: .normal)
        hangUpButton.imageView?.tintColor = buttonImageColor
        hangUpButton.imageView?.contentMode = buttonImageContentMode
        hangUpButton.contentHorizontalAlignment = .fill
        hangUpButton.contentVerticalAlignment = .fill
        hangUpButton.imageEdgeInsets = UIEdgeInsets(top: 16, left: 17, bottom: 18, right: 17)
        hangUpButton.layer.cornerRadius = roundOff
        blurView.contentView.addSubview(hangUpButton)
        hangUpButton.isEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard timer == nil else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func handleTimer() {
        elapsedTime += 0.01
        let minute = Int(elapsedTime / 60)
        let second = Int(elapsedTime) % 60
        minuteLabel.text = String(format: "%02d", minute)
        secondLabel.text = String(format: "%02d", second)
    }
    
    @IBAction func hangUpButton(_ sender: Any) {
        hangUpButton.isEnabled = false
        
        if let timer = timer {
            timer.invalidate()
        }
        elapsedTime = 0.0
        
        if let uuid = CallManager.shared.callIDs.first {
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.endCall(with: uuid)
        } else {
            print("failed to end calling")
        }
    }
    
    @objc private func dismissCallingView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
