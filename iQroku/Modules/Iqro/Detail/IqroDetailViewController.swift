//
//  IqroDetailViewController.swift
//  iQroku
//
//  Created by NDS on 05/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit
import SwiftEntryKit

extension SegueConstants {
    enum IqroDetail {
        
    }
}

class IqroDetailViewController: BaseViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPreview: UIButton!
    @IBOutlet weak var labelPage: UILabel!
    @IBOutlet weak var collectionViewIqroDetail: UICollectionView!

    var presenter: IqroDetailPresenter!
    var customPopup: CustomPopup?
    var attributes: EKAttributes?
    var page: Int = 0
    var completePage: Int = 0
    
    let textDescPopupComplete = LocalizationSystem.sharedInstance.localizedStringForKey(key: "popup_desc_notif", comment: "")
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        IqroDetailPresenter.config(withIqroDetailViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadPage()
        setupCollectionView()
        setupNavBar()
        page = presenter.getCurrentPage() + 1
        completePage = presenter.getCompletePage()
        labelPage.text = "\(page)"
        presenter.checkCompletePage()
    }
    
    func setupCollectionView() {
        collectionViewIqroDetail.register(IqroDetailCell.nib, forCellWithReuseIdentifier: IqroDetailCell.identifier)
    }
    
    func setupNavBar() {
        setupRightBarItem()
        self.navigationItem.title = presenter.getNavTitle()
    }
    
    func setupRightBarItem() {
        var imageName: String =  ""
        
        if presenter.isDone {
            imageName = "img-complete"
        } else {
            imageName = "img-uncomplete"
        }
        
        let button = UIBarButtonItem(image: UIImage(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(updatePage(sender:)))
        
        self.navigationItem.rightBarButtonItem = button
    }
    
    func hideButton() {
        btnPreview.isEnabled = presenter.getCurrentPage() >= 1 ? true : false
        btnPreview.isUserInteractionEnabled = presenter.getCurrentPage() >= 1 ? true : false
        btnNext.isEnabled = presenter.getCurrentPage() <= presenter.getCountIqro() - 2 ? true : false
        btnNext.isUserInteractionEnabled = presenter.getCurrentPage() <= presenter.getCountIqro() - 2 ? true : false
    }
    
    // Setup Custome Popup
    private func showCustomNibView(attributes: EKAttributes) {
        
        customPopup = CustomPopup()
        customPopup?.delegate = self
        customPopup?.completePage = completePage
        customPopup?.totalPage = presenter.getCountIqro()
        customPopup?.iqroNumber = presenter.getIqroNumber()
        customPopup?.setupPopup()
        SwiftEntryKit.display(entry: customPopup!, using: attributes)
    }
    
    @IBAction func previewTapped(_ sender: Any) {
        let prevPage: Int = presenter.getCurrentPage() - 1
        page = prevPage + 1
        collectionViewIqroDetail.scrollToItem(at: IndexPath(item: prevPage, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        labelPage.text = "\(page)"
        presenter.currentPage = prevPage
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        let nextPage: Int = presenter.getCurrentPage() + 1
        page = nextPage + 1
        collectionViewIqroDetail.scrollToItem(at: IndexPath(item: nextPage, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        labelPage.text = "\(page)"
        presenter.currentPage = nextPage
    }
    
    @objc func updatePage(sender: UIBarButtonItem) {
        presenter.updatePage()
    }
}

extension IqroDetailViewController: IqroDetailView {
    
    func updateRightBarButton() {
        setupRightBarItem()
        collectionViewIqroDetail.reloadItems(at: [presenter.indexPath])
    }
    
    // setup attibutes complete page
    func showNotifCompletePage() {
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [ColourConstant.paleViolet, UIColor.white], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 2), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        let minEdge = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: minEdge), height: .intrinsic)
        let title = EKProperty.LabelContent(text: "", style: .init(font: UIFont(name: "Helvetica", size: 12)!, color: UIColor.blue))
        let description = EKProperty.LabelContent(text: "\(textDescPopupComplete) \(page)", style: .init(font: UIFont(name: "Helvetica", size: 14)!, color: ColourConstant.greyishBrown))
        let image = EKProperty.ImageContent(image: UIImage(named: "img-complete")!, size: CGSize(width: 35, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    // Setup attribute custome popup
    func showCompletePagePopup() {
        attributes = EKAttributes()
        attributes? = .bottomFloat
        attributes?.hapticFeedbackType = .success
        attributes?.displayDuration = .infinity
        attributes?.screenInteraction = .forward
        attributes?.entryInteraction = .absorbTouches
        let minEdge = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        attributes?.entranceAnimation = .init(
            translate: .init(
                duration: 0.5,
                spring: .init(damping: 0.9, initialVelocity: 0)
            ),
            scale: .init(
                from: 0.8,
                to: 1,
                duration: 0.5,
                spring: .init(damping: 0.8, initialVelocity: 0)
            ),
            fade: .init(
                from: 0.7,
                to: 1,
                duration: 0.3
            )
        )
        attributes?.exitAnimation = .init(
            translate: .init(
                duration: 0.5
            ),
            scale: .init(
                from: 1,
                to: 0.8,
                duration: 0.5
            ),
            fade: .init(
                from: 1,
                to: 0,
                duration: 0.5
            )
        )
        attributes?.popBehavior = .animated(
            animation: .init(
                translate: .init(
                    duration: 0.3
                ),
                scale: .init(
                    from: 1,
                    to: 0.8,
                    duration: 0.3
                )
            )
        )
        attributes?.positionConstraints.verticalOffset = 10
        attributes?.positionConstraints.size = .init(
            width: .offset(value: 20),
            height: .intrinsic
        )
        attributes?.positionConstraints.maxSize = .init(
            width: .constant(value: minEdge),
            height: .intrinsic
        )
        attributes?.statusBar = .inferred
        attributes?.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes?.screenBackground = .color(color: UIColor(white: 0.5, alpha: 0.5))
        showCustomNibView(attributes: attributes!)
    }
    
}

extension IqroDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCountIqro()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let iqroDetailCell = collectionViewIqroDetail.dequeueReusableCell(withReuseIdentifier: IqroDetailCell.identifier, for: indexPath) as? IqroDetailCell {
            let data = presenter.getIqroItem()
            if data.indices.contains(indexPath.row) {
                iqroDetailCell.data = data[indexPath.row]
                iqroDetailCell.updateUI()
            }
            return iqroDetailCell
        }
            
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionViewIqroDetail.frame.width
        let height = collectionViewIqroDetail.frame.height

        return CGSize(width: width, height: height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        page = presenter.getCurrentPage() + 1
        presenter.currentPage = pageNumber
        labelPage.text = "\(page)"
        hideButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        hideButton()
        
        presenter.indexPath = indexPath
        let data = presenter.getIqroItem()
        if data.indices.contains(indexPath.row) {
            presenter.isDone = data[indexPath.row].done == "Y" ? true : false
            guard let rowId = data[indexPath.row].rowid else {
                return
            }
            presenter.rowId = rowId
//            print(data[indexPath.row].done)
            setupRightBarItem()
        }
    }
    
}

extension IqroDetailViewController: CustomPopupDelegate {
    func goToPage() {
        page = completePage + 1
        collectionViewIqroDetail.scrollToItem(at: IndexPath(item: completePage, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        labelPage.text = "\(page)"
        presenter.currentPage = completePage
        SwiftEntryKit.dismiss()
    }
    
    func dismissPopUp() {
        SwiftEntryKit.dismiss()
    }
}
