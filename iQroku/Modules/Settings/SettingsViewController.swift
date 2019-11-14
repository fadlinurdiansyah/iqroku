//
//  SettingsViewController.swift
//  iQroku
//
//  Created by NDS on 23/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit

extension SegueConstants {
    enum Settings {
        // TODO: Add segue ids
    }
}

class SettingsViewController: BaseViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var textFieldLanguage: UITextField!
    var presenter: SettingsPresenter!
    private var pickerLanguage: UIPickerView?
    var listLanguage: [String] = []
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SettingsPresenter.config(withSettingsViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerLanguage()
    }
    
    func setupPickerLanguage() {
        listLanguage = presenter.getListLanguage()
        pickerLanguage = UIPickerView()
        pickerLanguage?.delegate = self
        pickerLanguage?.dataSource = self
        textFieldLanguage.inputView = pickerLanguage
    }
    
    @IBAction func superViewTapped(_ sender: Any) {
        view.endEditing(true)
    }
}

extension SettingsViewController: SettingsView {
    // TODO: implement view methods
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listLanguage[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldLanguage.text = listLanguage[row]
    }
    
}
