//
//  GuestSoundTableViewController.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/16.
//

import UIKit

class GuestSoundTableViewController: UITableViewController {
    
    typealias ContentSectionRow = (Section: String, Row: Array<String>)
    var soundVibrationArrays: [ContentSectionRow] = []
    var soundCheckmarkArray: [Bool] = []
//    var vibrationCheckmarkArray: [Bool] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundVibrationArrays.append(("Sound",["ringtone", "sample", "apple", "banana", "orange"]))
//        soundVibrationArrays.append(("Vibration", ["Lion", "Chimp", "Horse"]))
        
        if let savedSoundCheckmark = UserDefaults.standard.array(forKey: "soundCheckmark")
//           , let savedVibrationCheckmark = UserDefaults.standard.array(forKey: "vibrationCheckmark")
        {
            soundCheckmarkArray = savedSoundCheckmark as! [Bool]
//            vibrationCheckmarkArray = savedVibrationCheckmark as! [Bool]
        }
        
        print("viewDidLoad soundCheckmarkArray\(soundCheckmarkArray)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let savedSoundCheckmark = UserDefaults.standard.array(forKey: "soundCheckmark") as! [Bool]
//        let savedVibrationCheckmark = UserDefaults.standard.array(forKey: "vibrationCheckmark") as! [Bool]
        
        if soundCheckmarkArray != savedSoundCheckmark {
            UserDefaults.standard.removeObject(forKey: "soundCheckmark")
            UserDefaults.standard.set(soundCheckmarkArray, forKey: "soundCheckmark")
            print("soundCheckmark has been successfully saved. \(soundCheckmarkArray)")
            
        } else if soundCheckmarkArray == savedSoundCheckmark {
            print("soundCheckmark has not been changed.")
        }
        
//        if vibrationCheckmarkArray != savedVibrationCheckmark {
//            UserDefaults.standard.removeObject(forKey: "vibrationCheckmark")
//            UserDefaults.standard.set(vibrationCheckmarkArray, forKey: "vibrationCheckmark")
//            print("vibrationCheckmark has been successfully saved. \(vibrationCheckmarkArray)")
//
//        } else if vibrationCheckmarkArray == savedVibrationCheckmark {
//            print("vibrationCheckmark has not been changed.")
//        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return soundVibrationArrays.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return soundVibrationArrays[section].Row.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return soundVibrationArrays[section].Section
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = soundVibrationArrays[indexPath.section].Row[indexPath.row]
        
        if soundVibrationArrays[indexPath.section] == soundVibrationArrays[0] {
            if soundCheckmarkArray[indexPath.row] == true {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
//        } else if soundVibrationArrays[indexPath.section] == soundVibrationArrays[1] {
//            if vibrationCheckmarkArray[indexPath.row] == true {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selctedSection: String = soundVibrationArrays[indexPath.section].Section
        let selectedRow: String = soundVibrationArrays[indexPath.section].Row[indexPath.row]
        let userDefaults = UserDefaults.standard
        
        if soundVibrationArrays[indexPath.section] == soundVibrationArrays[0] {
            guard soundCheckmarkArray[indexPath.row] == false else {
                print("Same cell was tapped. \(selctedSection) '\(selectedRow)'")
                return
            }
            soundCheckmarkArray = []
            if soundCheckmarkArray.count == 0 {
                for _ in 0 ... soundVibrationArrays[0].Row.count - 1 {
                    soundCheckmarkArray.append(false)
                }
            }
            soundCheckmarkArray[indexPath.row] = changeBooleanValue(value: soundCheckmarkArray[indexPath.row])
            
            if userDefaults.string(forKey: "soundName") != nil {
                userDefaults.removeObject(forKey: "soundName")
                userDefaults.set(selectedRow, forKey: "soundName")
                print("soundName has been successfully saved. '\(selectedRow)'")
            } else {
                print("Default 'soundName' is nil.")
            }
//        } else if soundVibrationArrays[indexPath.section] == soundVibrationArrays[1] {
//            guard vibrationCheckmarkArray[indexPath.row] == false else {
//                print("Same cell was tapped. \(selctedSection) \(selectedRow)")
//                return
//            }
//            vibrationCheckmarkArray = []
//            if vibrationCheckmarkArray.count == 0 {
//                for _ in 0 ... soundVibrationArrays[1].Row.count - 1 {
//                    vibrationCheckmarkArray.append(false)
//                }
//            }
//            vibrationCheckmarkArray[indexPath.row] = changeBooleanValue(value: vibrationCheckmarkArray[indexPath.row])
        }
        
        self.tableView.reloadData()
        print("didSelectRowAt \(selctedSection) '\(selectedRow)' soundCheckmarkArray\(soundCheckmarkArray)")
    }
    
    private func changeBooleanValue(value: Bool) -> Bool {
        if value == true {
            return false
        } else {
            return true
        }
    }
    
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
