//
//  ByteCoinView.swift
//  ByteCoin
//
//  Created by murad on 30.11.2024.
//

import UIKit

class ByteCoinView: UIView {
    //MARK: - Properties
    
    private let topVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let byteCoinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ByteCoin"
        label.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    private let containerCoinView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiaryLabel
        view.layer.cornerRadius = 40
        return view
    }()
    
    
    private let coinHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let bitcoinSignImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .icon
        return imageView
    }()
    
    private let bitcoinPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let currencySymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "USD"
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup UI
    private func setupView() {
        backgroundColor = .background
        
        addSubview(topVerticalStackView)
        containerCoinView.addSubview(coinHorizontalStackView)
        addSubview(pickerView)
        
        [byteCoinLabel, containerCoinView].forEach { view in
            topVerticalStackView.addArrangedSubview(view)
        }
        
        [bitcoinSignImageView, bitcoinPriceLabel, currencySymbolLabel].forEach { view in
            coinHorizontalStackView.addArrangedSubview(view)
        }
        
        NSLayoutConstraint.activate([
            topVerticalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            topVerticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -20),
            
            containerCoinView.heightAnchor.constraint(equalToConstant: 80),
            
            coinHorizontalStackView.leadingAnchor.constraint(equalTo: containerCoinView.leadingAnchor),
            coinHorizontalStackView.trailingAnchor.constraint(equalTo: containerCoinView.trailingAnchor, constant: -10),
            coinHorizontalStackView.topAnchor.constraint(equalTo: containerCoinView.topAnchor),
            coinHorizontalStackView.bottomAnchor.constraint(equalTo: containerCoinView.bottomAnchor),
            
            bitcoinSignImageView.topAnchor.constraint(equalTo: coinHorizontalStackView.topAnchor),
            bitcoinSignImageView.bottomAnchor.constraint(equalTo: coinHorizontalStackView.bottomAnchor),
            bitcoinSignImageView.widthAnchor.constraint(equalToConstant: 80),
            
            currencySymbolLabel.trailingAnchor.constraint(equalTo: coinHorizontalStackView.trailingAnchor),
            
            pickerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 216)
        ])
    }
    
    //MARK: - Methods
    
    func setPickerViewDelegate(_ delegate: UIPickerViewDelegate) {
        pickerView.delegate = delegate
    }
    
    func setPickerViewDataSource(_ dataSouce: UIPickerViewDataSource) {
        pickerView.dataSource = dataSouce
    }
    
    func updateUI(with coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinPriceLabel.text = coin.rateString
            self.currencySymbolLabel.text = coin.fiatCurrency
        }
    }
    
    func setDefaultPickerSelection(coinsArray: [String], currency: String) {
        if let index = coinsArray.firstIndex(of: currency) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }
}
