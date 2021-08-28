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
        
        // blurView
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.frame
        view.insertSubview(blurView, aboveSubview: view)
        
        // Icon Image View
        let iconImageView = UIImageView()
        iconImageView.frame.size = CGSize(width: 150, height: 150)
        iconImageView.frame.origin = CGPoint(x: (screenWidth - iconImageView.frame.size.width) / 2, y: screenHeight * 0.11)
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2
        iconImageView.layer.borderWidth = 1.0
        iconImageView.layer.borderColor = UIColor.white.cgColor
        blurView.contentView.addSubview(iconImageView)
        
        // Default Icon
        let defaultIconView = UIImageView(image: UIImage(systemName: "person.fill"))
        defaultIconView.frame.size = CGSize(width: 100, height: 100)
        defaultIconView.frame.origin = CGPoint(x: (iconImageView.frame.origin.x + iconImageView.frame.width / 2) - defaultIconView.frame.width / 2, y: (iconImageView.frame.origin.y + iconImageView.frame.height / 2) - defaultIconView.frame.height / 2)
        defaultIconView.contentMode = .scaleAspectFit
        defaultIconView.tintColor = .white
        blurView.contentView.addSubview(defaultIconView)
        
        // Caller Name Label
        if let caller = UserDefaults.standard.string(forKey: "caller") {
            callerNameLabel.text = caller
        }
        callerNameLabel.frame.size = CGSize(width: screenWidth - 50, height: 40)
        callerNameLabel.frame.origin = CGPoint(x: (screenWidth - callerNameLabel.frame.width) / 2, y: iconImageView.frame.origin.y + iconImageView.frame.height + 15)
        blurView.contentView.addSubview(callerNameLabel)
        
        // Timer Label
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
        
        // New Mute Image
        let muteImageView = UIImageView(image: UIImage(systemName: "mic.slash.fill"))
        muteImageView.frame.size = CGSize(width: 30, height: 30)
        muteImageView.frame.origin = CGPoint(x: screenWidth * 0.25 - muteImageView.frame.width / 2, y: screenHeight * 0.65)
        muteImageView.tintColor = .white
        muteImageView.contentMode = .scaleAspectFit
        blurView.contentView.addSubview(muteImageView)
        
        let muteLabel = UILabel()
        muteLabel.frame.size = CGSize(width: 40, height: 20)
        muteLabel.frame.origin = CGPoint(x: (muteImageView.frame.origin.x + muteImageView.frame.width / 2) - muteLabel.frame.width / 2, y: muteImageView.frame.origin.y + muteImageView.frame.height + 5)
        muteLabel.text = "mute"
        muteLabel.textAlignment = .center
        muteLabel.textColor = .white
        blurView.contentView.addSubview(muteLabel)
        
        // New Speaker Image
        let speakerImageView = UIImageView(image: UIImage(systemName: "speaker.wave.3.fill"))
        speakerImageView.frame.size = CGSize(width: 35, height: 35)
        speakerImageView.frame.origin = CGPoint(x: screenWidth * 0.75 - speakerImageView.frame.width / 2, y: muteImageView.frame.origin.y - (speakerImageView.frame.height - muteImageView.frame.height) / 2)
        speakerImageView.tintColor = .white
        speakerImageView.contentMode = .scaleAspectFit
        blurView.contentView.addSubview(speakerImageView)
        
        let speakerLabel = UILabel()
        speakerLabel.frame.size = CGSize(width: 80, height: 20)
        speakerLabel.frame.origin = CGPoint(x: (speakerImageView.frame.origin.x + speakerImageView.frame.width / 2) - speakerLabel.frame.width / 2, y: muteLabel.frame.origin.y)
        speakerLabel.text = "speaker"
        speakerLabel.textAlignment = .center
        speakerLabel.textColor = .white
        blurView.contentView.addSubview(speakerLabel)
        
        // Hang Up Button
        let hangUpImage = UIImage(systemName: "phone.down.fill")
        hangUpButton.frame.size = CGSize(width: 75, height: 75)
        hangUpButton.frame.origin = CGPoint(x: screenWidth / 2 - hangUpButton.frame.size.width / 2, y: screenHeight * 0.77)
        hangUpButton.setImage(hangUpImage, for: .normal)
        hangUpButton.imageView?.tintColor = .white
        hangUpButton.imageView?.contentMode = .scaleAspectFit
        hangUpButton.contentHorizontalAlignment = .fill
        hangUpButton.contentVerticalAlignment = .fill
        hangUpButton.imageEdgeInsets = UIEdgeInsets(top: 16, left: 17, bottom: 18, right: 17)
        hangUpButton.layer.cornerRadius = hangUpButton.frame.size.width / 2
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
