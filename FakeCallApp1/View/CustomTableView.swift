//
//  CustomTableView.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/13.
//

import UIKit

class CustomTableView: UITableView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}
