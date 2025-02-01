//
//  ViewController.swift
//  reactive_counter_app
//
//  Created by 林 明虎 on 2025/01/12.
//

import UIKit
import Combine

class CounterGridVC: UIViewController {
    private let viewModel = CounterViewModel()
    internal var counters: [RCCounter] = []
    private var cancellables = Set<AnyCancellable>()
    // component
    private let addCounterButton = UIButton()
    private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        setupUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - UIのセットアップ
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let navigationBarTitleLabel = RCNavigationBarTitle(title: "Reactive Counter")
        navigationItem.titleView = navigationBarTitleLabel
        
        setupCollectionView()
        setupAddCounterButton()
    }
    
    private func setupCollectionView() {
        // MARK: - Gridレイアウトの設定
        let spacingBetweenCell: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = spacingBetweenCell * (numberOfItemsPerRow + 1)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        // 以上の情報をもとにLayoutを組む
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: 120)
        layout.minimumLineSpacing = spacingBetweenCell
        layout.minimumInteritemSpacing = spacingBetweenCell
        layout.sectionInset = UIEdgeInsets(top: spacingBetweenCell, left: spacingBetweenCell, bottom: spacingBetweenCell, right: spacingBetweenCell)
        // UICollectionViewの設定、配置
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CounterGridCell.self, forCellWithReuseIdentifier: CounterGridCell.identifier)
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // Counterを追加する丸型のボタンの設定、配置
    private func setupAddCounterButton() {
        addCounterButton.setTitle("+", for: .normal)
        addCounterButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        addCounterButton.backgroundColor = .accent
        addCounterButton.layer.cornerRadius = 30
        addCounterButton.translatesAutoresizingMaskIntoConstraints = false
        addCounterButton.addTarget(self, action: #selector(showSetInitialValueAlert), for: .touchUpInside)
        view.addSubview(addCounterButton)
        
        NSLayoutConstraint.activate([
            addCounterButton.widthAnchor.constraint(equalToConstant: 60),
            addCounterButton.heightAnchor.constraint(equalToConstant: 60),
            addCounterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addCounterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func bindViewModel() {
        viewModel.$counters
            .sink { [weak self] counters in
                self?.counters = counters
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc private func showSetInitialValueAlert() {
        let alert = UIAlertController(title: "新しい Counter の初期値", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "0"
            textField.keyboardType = .numberPad
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] _ in
            guard let self = self, let textField = alert?.textFields?.first else { return }
            if let text = textField.text, let initialValue = Int(text) {
                self.viewModel.addCounter(initialValue: initialValue)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension CounterGridVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return counters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let counterGridViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CounterGridCell.identifier,
            for: indexPath
        ) as? CounterGridCell else {
            return UICollectionViewCell()
        }
        
        let counter = counters[indexPath.item]
        counterGridViewCell.configure(with: counter)
        
        return counterGridViewCell
    }
}


extension CounterGridVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Cellをタップしたら対応するCounterの詳細を表示する
        let detailVC = CounterDetailVC(viewModel: viewModel, counterIndex: indexPath.row)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
