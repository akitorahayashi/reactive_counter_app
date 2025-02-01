//
//  CounterDetailVC.swift
//  reactive_counter_app
//
//  Created by 林 明虎 on 2025/01/12.
//

import UIKit
import Combine

class CounterDetailVC: UIViewController, UITextViewDelegate {
    private let viewModel: CounterViewModel
    private let counterIndex: Int
    private var cancellables = Set<AnyCancellable>()
    // component
    private let valueLabel = UILabel()
    private let incrementButton = UIButton()
    private let decrementButton = UIButton()
    // input form
    private let titleHeader = UILabel()
    private let titleInputField = UITextField()
    private let memoHeader = UILabel()
    private let memoTextView = UITextView()
    // UITextViewの高さの制約を保持
    private var memoInputFieldHeightConstraint: NSLayoutConstraint?
    // テキストビュー関連の定数
    private struct TextViewConstants {
        static let textViewHeightInRows: CGFloat = 3
        static let oneLineHeight: CGFloat = 20
    }
    
    init(viewModel: CounterViewModel, counterIndex: Int) {
        self.viewModel = viewModel
        self.counterIndex = counterIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        super.loadView()
        self.setupUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupButtonAction()
        self.bindViewModel()
    }
    
    // MARK: - binding
    private func bindViewModel() {
        viewModel.$counters
            .map { $0[self.counterIndex] } // 該当するカウンターの値を取得
            .sink { [weak self] corrCounter in
                // 中央のCounterの値
                self?.valueLabel.text = "\(corrCounter.value)"
            }
            .store(in: &cancellables)
    }
    
    private func setupButtonAction() {
        incrementButton.addTarget(self, action: #selector(incrementCounterAction), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementCounterAction), for: .touchUpInside)
    }
    
    @objc private func incrementCounterAction() {
        viewModel.incrementCounter(at: counterIndex)
        RCVibrator.vibrate()
    }
    
    @objc private func decrementCounterAction() {
        viewModel.decrementCounter(at: counterIndex)
        RCVibrator.vibrate()
    }
    
    // MARK: - UIのセットアップ
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.titleView = RCNavigationBarTitle(title: "Counter Detail")
        
        // ボタンのデザインを整える
        setupAdjustCounterValueButtonDesign(corrButton: incrementButton, systemName: "chevron.right")
        setupAdjustCounterValueButtonDesign(corrButton: decrementButton, systemName: "chevron.left")
        
        // valueLabelのデザインを整える
        setupValueLabelDesign()
        
        // 増減ボタンとvalueLabelを含むStackViewの設定
        let stackView = UIStackView(arrangedSubviews: [decrementButton, valueLabel, incrementButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 画面の横幅を基準とする正方形のコンテナに追加して配置する
        let valueContainerSquareView = UIView()
        valueContainerSquareView.translatesAutoresizingMaskIntoConstraints = false
        valueContainerSquareView.addSubview(stackView)
        view.addSubview(valueContainerSquareView)
        
        // 制約を設定
        NSLayoutConstraint.activate([
            // 正方形のコンテナを画面の横幅に基づいて設定
            valueContainerSquareView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            valueContainerSquareView.heightAnchor.constraint(equalTo: valueContainerSquareView.widthAnchor),
            valueContainerSquareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            valueContainerSquareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // StackViewを正方形の中央に配置
            stackView.centerXAnchor.constraint(equalTo: valueContainerSquareView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: valueContainerSquareView.centerYAnchor),
            
            // ボタンのサイズ
            incrementButton.widthAnchor.constraint(equalToConstant: 60),
            incrementButton.heightAnchor.constraint(equalToConstant: 60),
            decrementButton.widthAnchor.constraint(equalToConstant: 60),
            decrementButton.heightAnchor.constraint(equalToConstant: 60),
            
            // valueLabelの高さを固定
            valueLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // Counterのvalueを増減させるボタンのデザインを整える関数
    private func setupAdjustCounterValueButtonDesign(corrButton: UIButton, systemName: String) {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 24, weight: .bold))
        corrButton.setImage(UIImage(systemName: systemName, withConfiguration: config), for: .normal)
        corrButton.tintColor = .accent
        corrButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // counterのvalueを表示するLabelのデザインを設定する関数
    private func setupValueLabelDesign() {
        valueLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        valueLabel.textColor = .systemGray2
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 各入力要素のヘッダーを生成する関数
    private func setupHeader(_ header: UILabel, text: String) {
        header.text = text
        header.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        header.textAlignment = .left
        header.textColor = .gray
    }
    
    // 入力フィールドのペアを作成する関数
    private func createInputFieldPair(header: UILabel, inputField: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [header, inputField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        inputField.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    // UITextViewの設定する関数
    private func configureTextView(_ textView: UITextView, heightConstraint: inout NSLayoutConstraint?) {
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.cornerRadius = 5.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        // 初期高さを3行分かそれ以上に設定
        let minHeight = TextViewConstants.textViewHeightInRows * TextViewConstants.oneLineHeight + textView.textContainerInset.top + textView.textContainerInset.bottom
        let heightConstraintInstance = textView.heightAnchor.constraint(equalToConstant: minHeight)
        heightConstraintInstance.isActive = true
        heightConstraint = heightConstraintInstance
        self.adjustHeight(for: textView, constraint: heightConstraint)
    }
    
    // MARK: - UITextViewDelegate（textViewDidChange）
    func textViewDidChange(_ textView: UITextView) {
        if textView == memoTextView,
           let constraint = memoInputFieldHeightConstraint {
            self.adjustHeight(for: textView, constraint: constraint)
        }
    }
    
    private func adjustHeight(for textView: UITextView, constraint: NSLayoutConstraint?) {
        guard let constraint = constraint else { return }
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let minHeight = TextViewConstants.textViewHeightInRows * TextViewConstants.oneLineHeight + textView.textContainerInset.top + textView.textContainerInset.bottom
        
        constraint.constant = max(size.height, minHeight)
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
