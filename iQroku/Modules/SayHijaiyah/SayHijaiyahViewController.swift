//
//  SayHijaiyahViewController.swift
//  iQroku
//
//  Created by NDS on 21/09/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Pulsator

extension SegueConstants {
    enum SayHijaiyah {
        // TODO: Add segue ids
    }
}

class SayHijaiyahViewController: BaseViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var viewPulseAnimation: UIView!
    @IBOutlet weak var imageViewSayHijaiyah: UIImageView!
    @IBOutlet weak var collectionViewSayHijaiyah: UICollectionView!
    var audioPlayer: AVAudioPlayer?
    var presenter: SayHijaiyahPresenter!
    let pulsator = Pulsator()
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SayHijaiyahPresenter.config(withSayHijaiyahViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupNavBar()
    }
    
    func setupCollectionView() {
        collectionViewSayHijaiyah.register(SayHijaiyahCell.nib, forCellWithReuseIdentifier: SayHijaiyahCell.identifier)
        
    }
    
    func setupNavBar() {
        let logo = UIImage(named: "img-iqroku")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    }
    
    func playSound(soundName: String) {
        viewPulseAnimation.layer.addSublayer(pulsator)
        pulsator.numPulse = 5
        pulsator.radius = 100
        pulsator.backgroundColor = ColourConstant.paleViolet.cgColor
        pulsator.duration = 5
        pulsator.start()
        
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying { audioPlayer.stop() }
        
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
//            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
        } catch let error {
            pulsator.stop()
            print(error.localizedDescription)
        }
    }
    
    @IBAction func imageHijaiyahTapped(_ sender: UITapGestureRecognizer) {
        let numHijaiyah = presenter.getCurrentHijaiyah()
        let soundHijaiyah = "sound-hijaiyah-\(numHijaiyah)"
        
        playSound(soundName: soundHijaiyah)
    }
}

extension SayHijaiyahViewController: SayHijaiyahView {
    // TODO: implement view methods
}

extension SayHijaiyahViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCountHijaiyah()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let sayHijaiyahCell = collectionViewSayHijaiyah.dequeueReusableCell(withReuseIdentifier: SayHijaiyahCell.identifier, for: indexPath) as? SayHijaiyahCell {
            
            sayHijaiyahCell.index = indexPath.row + 1
            sayHijaiyahCell.updateUI()
            return sayHijaiyahCell
        } else {
            return UICollectionViewCell()
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionViewSayHijaiyah.frame.width / 4
        let height = collectionViewSayHijaiyah.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageHijaiyah = "img-hijaiyah-big-\(indexPath.row + 1)"
        imageViewSayHijaiyah.image = UIImage(named: imageHijaiyah)
        presenter.currentHijaiyah = indexPath.row + 1
    }
}

extension SayHijaiyahViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        pulsator.stop()
    }
}
