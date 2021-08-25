//
//  SignInFirstTableViewController.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/23.
//

import UIKit
import Network

class SignInFirstTableViewController: UITableViewController {
    
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var callerLabel: UILabel!
    @IBOutlet weak var setCallButton: UIButton!
    let setCall = SetCall()
    let monitor = NWPathMonitor()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange(_:)), name: UserDefaults.didChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reenableUIBUtton(_:)), name: .callFinished, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertInternalError(_:)), name: .internalError, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertPinpointError(_:)), name: .pinpointError, object: nil)
        
//        if let sound = UserDefaults.standard.string(forKey: "soundName") {
//            soundLabel.text = sound
//        }
        if let caller = UserDefaults.standard.string(forKey: "caller") {
            callerLabel.text = caller
        }
                
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                UserDefaults.standard.set(true, forKey: "isConnected")
                print("Connected to the Internet")
            } else {
                UserDefaults.standard.set(false, forKey: "isConnected")
                print("No Internet connection")
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 180
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    @objc func userDefaultsDidChange(_ notification: Notification) {
//        if let sound = UserDefaults.standard.string(forKey: "soundName") {
//            self.soundLabel.text = sound
//        }
        if let caller = UserDefaults.standard.string(forKey: "caller") {
            DispatchQueue.main.async {
                self.callerLabel.text = caller
            }
        }
    }
    
    @objc func reenableUIBUtton(_ notification: Notification) {
        setCallButton.isEnabled = true
    }
    
    @IBAction func startCall(_ sender: Any) {
        let isConnected = UserDefaults.standard.bool(forKey: "isConnected")
        
        if isConnected == true {
            DispatchQueue.main.async {
                self.setCall.startCall(deviceToken: SharedInstance.deviceToken)
                self.setCallButton.isEnabled = false
            }
        } else {
            self.alertWhenNoConnection()
            print("'startCall' was blocked because device is not connected to the internet")
        }
    }
    
    func alertWhenNoConnection() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func alertInternalError(_ notification: Notification) {
        let message = notification.userInfo?["message"] as? String
        let alert = UIAlertController(title: "Your Request Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.setCallButton.isEnabled = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // This method will be modified before official release
    @objc private func alertPinpointError(_ notification: Notification) {
        let statusMessage = notification.userInfo?["statusMessage"] as? String
        let alert = UIAlertController(title: "Internal Server Error", message: statusMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.setCallButton.isEnabled = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
