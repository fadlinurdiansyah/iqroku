//
//  WriteHijaiyahViewController.swift
//  iQroku
//
//  Created by NDS on 13/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit

extension SegueConstants {
    enum WriteHijaiyah {
        // TODO: Add segue ids
    }
}

class WriteHijaiyahViewController: BaseViewController {
    
    // MARK: Properties
    @IBOutlet weak var imageViewHijaiyah: UIImageView!
    @IBOutlet weak var drawViewHijaiyah: SwiftyDrawView!
    @IBOutlet weak var collectionViewWriteHijaiyah: UICollectionView!
    
    var presenter: WriteHijaiyahPresenter!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        WriteHijaiyahPresenter.config(withWriteHijaiyahViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearDraw()
        setupCollectionView()
        setupDraw()
        setupNavBar()
    }
    
    func setupCollectionView() {
        collectionViewWriteHijaiyah.register(WriteHijaiyahCell.nib, forCellWithReuseIdentifier: WriteHijaiyahCell.identifier)
    }
    
    func setupNavBar() {
        let logo = UIImage(named: "img-iqroku")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
    func setupDraw() {
        
        drawViewHijaiyah.brush.width = 25
        drawViewHijaiyah.brush.color = ColourConstant.paleViolet
        drawViewHijaiyah.brush.blendMode = .normal
        drawViewHijaiyah.brush.opacity = 0.9
        
        if #available(iOS 9.1, *) {
            drawViewHijaiyah.allowedTouchTypes = [.finger, .pencil]
        }
    }
    
    func clearDraw() {
        drawViewHijaiyah.clear()
    }
    
    @IBAction func clearDrawTapped(_ sender: Any) {
        
        clearDraw()
        
    }
}

extension WriteHijaiyahViewController: WriteHijaiyahView {
    // TODO: implement view methods
}

extension WriteHijaiyahViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCountHijaiyah()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let writeHijaiyahCell = collectionViewWriteHijaiyah.dequeueReusableCell(withReuseIdentifier: WriteHijaiyahCell.identifier, for: indexPath) as? WriteHijaiyahCell {
            
            writeHijaiyahCell.index = indexPath.row + 1
            writeHijaiyahCell.updateUI()
            return writeHijaiyahCell
        } else {
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionViewWriteHijaiyah.frame.width / 4
        let height = collectionViewWriteHijaiyah.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clearDraw()
        let imageHijaiyah = "img-draw-hijaiyah-\(indexPath.row + 1)"
        imageViewHijaiyah.image = UIImage(named: imageHijaiyah)
    }
    
}

extension WriteHijaiyahViewController: SwiftyDrawViewDelegate {
    
    func swiftyDraw(shouldBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) -> Bool { return true }
    func swiftyDraw(didBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {  }
    func swiftyDraw(isDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {  }
    func swiftyDraw(didFinishDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {  }
    func swiftyDraw(didCancelDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {  }
    
}
