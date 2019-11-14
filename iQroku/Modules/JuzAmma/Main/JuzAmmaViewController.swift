//
//  JuzAmmaViewController.swift
//  iQroku
//
//  Created by NDS on 09/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit

extension SegueConstants {
    enum JuzAmma {
        static let showJuzAmmaDetail = "showJuzAmmaDetail"
    }
}

class JuzAmmaViewController: BaseViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var imgJuzAmmaHeader: UIImageView!
    @IBOutlet weak var tableViewJuzAmma: UITableView!
    var presenter: JuzAmmaPresenter!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        JuzAmmaPresenter.config(withJuzAmmaViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableJuzAmma()
    }
    
    func setupTableJuzAmma() {
        tableViewJuzAmma.register(JuzAmmaCell.nib, forCellReuseIdentifier: JuzAmmaCell.identifier)
    }
    
}

extension JuzAmmaViewController: JuzAmmaView {
    // TODO: implement view methods
}

extension JuzAmmaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTotalJuzAmma()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellJuzAmma = tableViewJuzAmma.dequeueReusableCell(withIdentifier: JuzAmmaCell.identifier, for: indexPath) as? JuzAmmaCell {
            return cellJuzAmma
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueConstants.JuzAmma.showJuzAmmaDetail, sender: nil)
    }
}
