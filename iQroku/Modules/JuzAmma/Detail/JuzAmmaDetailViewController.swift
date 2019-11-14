//
//  JuzAmmaDetailViewController.swift
//  iQroku
//
//  Created by NDS on 11/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit

extension SegueConstants {
    enum JuzAmmaDetail {
        // TODO: Add segue ids
    }
}

class JuzAmmaDetailViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var labelPage: UILabel!
    @IBOutlet weak var collectionViewJuzAmmaDetail: UICollectionView!
    
    var presenter: JuzAmmaDetailPresenter!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        JuzAmmaDetailPresenter.config(withJuzAmmaDetailViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavbar()
//        hideButton()
        labelPage.text = "\(presenter.getCurrentPage() + 1)"
    }
    
    func setupCollectionView() {
        
        collectionViewJuzAmmaDetail.register(JuzAmmaDetailCell.nib, forCellWithReuseIdentifier: JuzAmmaDetailCell.identifier)
    }
    
    func setupNavbar() {
        
        let buttonComplete = UIBarButtonItem(image: UIImage(named: "img-complete")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: nil)
        
        self.navigationItem.title = presenter.getNavTitle()
        self.navigationItem.rightBarButtonItem = buttonComplete
    }
    
    func hideButton() {
        btnPreview.isEnabled = presenter.getCurrentPage() >= 1 ? true : false
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let nextPage: Int = presenter.getCurrentPage() + 1
        let indexPath = IndexPath(item: nextPage, section: 0)
        collectionViewJuzAmmaDetail.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        labelPage.text = "\(nextPage + 1)"
        presenter.currentPage = nextPage
    }
    
    @IBAction func previewTapped(_ sender: Any) {
        let prevPage: Int = presenter.getCurrentPage() - 1
        let indexPath = IndexPath(item: prevPage, section: 0)
        collectionViewJuzAmmaDetail.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        labelPage.text = "\(prevPage + 1)"
        presenter.currentPage = prevPage
    }
}

extension JuzAmmaDetailViewController: JuzAmmaDetailView {
    // TODO: implement view methods
}

extension JuzAmmaDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter.getTotalPages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let juzAmmaDetailCell = collectionViewJuzAmmaDetail.dequeueReusableCell(withReuseIdentifier: JuzAmmaDetailCell.identifier, for: indexPath) as? JuzAmmaDetailCell else {
            fatalError()
        }
        
        return juzAmmaDetailCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionViewJuzAmmaDetail.frame.width
        let height = collectionViewJuzAmmaDetail.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        presenter.currentPage = pageNumber
        labelPage.text = "\(presenter.getCurrentPage() + 1)"
        hideButton()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        hideButton()
    }
    
}
