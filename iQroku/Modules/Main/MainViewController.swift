//
//  MainViewController.swift
//  iQroku
//
//  Created by NDS on 02/08/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit

extension SegueConstants {
    enum Main {
        static let showIqro = "showIqro"
        static let showJuzAmma = "showJuzAmma"
        static let showWriteHijaiyah = "showWriteHijaiyah"
        static let showSayHijaiyah = "showSayHijaiyah"
        static let showSettings = "showSettings"
    }
}

class MainViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var collectionViewMainMenu: UICollectionView!
    @IBOutlet var mainView: UIView!
    
    var presenter: MainPresenter!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MainPresenter.config(withMainViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        setupNavBar()
    }
    
    func setupCollectionView() {
        collectionViewMainMenu.register(MainCell.nib, forCellWithReuseIdentifier: MainCell.identifier)
    }
    
    func setupNavBar() {
        let logo = UIImage(named: "img-iqroku")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
}

extension MainViewController: MainView {
    // TODO: implement view methods
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCountMainMenu()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let mainCell = collectionViewMainMenu.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as? MainCell {
            mainCell.index = indexPath.row + 1
            mainCell.updateUI()
            return mainCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftSpace = 7
        let rightSpace = 7
        let centerSpace = 0
        let frameWidth = self.view.frame.width
        let cellWidth = ((frameWidth / 2) - CGFloat(leftSpace + centerSpace + rightSpace))
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch MainSection(rawValue: indexPath.row) {
            
        case .learnIqro?:
            performSegue(withIdentifier: SegueConstants.Main.showIqro, sender: nil)
            
        case .writeHijaiyah?:
            performSegue(withIdentifier: SegueConstants.Main.showWriteHijaiyah, sender: nil)
            
        case .learnJuzamma?:
            performSegue(withIdentifier: SegueConstants.Main.showJuzAmma, sender: nil)
            
        case .speakHijaiyah?:
            performSegue(withIdentifier: SegueConstants.Main.showSayHijaiyah, sender: nil)
            
        case .setting?:
            performSegue(withIdentifier: SegueConstants.Main.showSettings, sender: nil)
            
        case .none:
            break
            
        }
    }
    
}
