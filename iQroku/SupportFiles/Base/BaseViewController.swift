
//
//  BaseViewController.swift
//  iQroku
//
//  Created by NDS on 11/08/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Data member
    
    var loadingView: LoadingView?
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    deinit {
        self.deinitView()
    }
    
    // MARK: - Implementation LoadingProtocol
    
    func initView() {
        loadingView = LoadingView.instantiateFromNib()
    }
    
    func deinitView() {
        loadingView = nil
    }
    
    func addLoadingAsSubViewIfNeed(withView view: UIView) {
        if let loadingView = self.loadingView {
            if !view.subviews.contains(loadingView) {
                loadingView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
                view.addSubview(loadingView)
            }
        }
    }
    
    func showBlockLoading(withView view: UIView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        addLoadingAsSubViewIfNeed(withView: view)
        loadingView?.showBlockLoading()
    }
    
    func showErrorConnection(withView view: UIView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        addLoadingAsSubViewIfNeed(withView: view)
        loadingView?.showNoConnection()
    }
    
    func showShowServerError(withView view: UIView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        addLoadingAsSubViewIfNeed(withView: view)
        loadingView?.showServerError()
    }
    
    func stopBlockLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        loadingView?.stop()
    }
    
    func viewController(forStoryboardName: String) -> UIViewController? {
        return UIStoryboard(name: forStoryboardName, bundle: nil).instantiateInitialViewController()
    }
}
