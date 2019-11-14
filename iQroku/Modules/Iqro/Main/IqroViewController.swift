//
//  IqroViewController.swift
//  iQroku
//
//  Created by NDS on 04/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit

extension SegueConstants {
    enum Iqro {
        static let showIqroDetail = "showIqroDetail"
    }
}

class IqroViewController: BaseViewController {
    
    // MARK: Properties
    
    var presenter: IqroPresenter!
    @IBOutlet weak var tableViewIqro: UITableView!
    @IBOutlet weak var imgViewHeader: UIImageView!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        IqroPresenter.config(withIqroViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadPage()
        setupTableView()
        setupNavBar()
    }
    
    func setupTableView() {
        tableViewIqro.register(IqroCell.nib, forCellReuseIdentifier: IqroCell.identifier)
    }
    
    func setupNavBar() {
        let logo = UIImage(named: "img-iqroku")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueConstants.Iqro.showIqroDetail {
            if let viewController = segue.destination as? IqroDetailViewController {
                viewController.presenter.iqroNumber = sender as! Int
            }
        }
    }
}

extension IqroViewController: IqroView {
    // TODO: implement view methods
}

extension IqroViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getIqroCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let iqroCell = tableViewIqro.dequeueReusableCell(withIdentifier: IqroCell.identifier) as? IqroCell {
            let data = presenter.getIqroPageItem()
            if data.indices.contains(indexPath.row) {
                iqroCell.data = data[indexPath.row]
                iqroCell.updateUI()
            }
            return iqroCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let iqroNumber = indexPath.row + 1
        performSegue(withIdentifier: SegueConstants.Iqro.showIqroDetail, sender: iqroNumber)
    
    }
}
