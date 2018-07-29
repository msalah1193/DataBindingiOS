//
//  HomeViewController.swift
//  DataBindingiOS
//
//  Created by Mohamed Salah on 7/29/18.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    
    // MARK: - Variables
    var viewModel: HomeViewModel
    
    // MARK: - init(s)
    required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    // MARK: - Bindings
    func setupBindings() {
        viewModel.isLoadingData.bind(to: activityIndicator.reactive.isAnimating)
        viewModel.networkError.bind(to: errorLabel.reactive.text)
        
        segmentControl.reactive.selectedSegmentIndex.skip(first: 1).observeNext { [unowned self] value in
            self.viewModel.cityCode.value = value == 0 ? .cairo : .london
        }.dispose(in: viewModel.disposeBag)
        
        viewModel.cityViewModel.observeNext { [unowned self] cityViewModel in
            guard let viewModel = cityViewModel else {
                self.resetViews()
                return
            }
            self.weatherDegreeLabel.text = viewModel.temp
            self.conditionLabel.text = viewModel.conditionText
            self.conditionImageView.sd_setImage(with: viewModel.conditionIcon)
            
        }.dispose(in: viewModel.disposeBag)
    }
    
    func resetViews() {
        weatherDegreeLabel.text = "__"
        conditionLabel.text = "__"
        conditionImageView.image = nil
    }
}
