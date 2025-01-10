//
//  CategoryViewController.swift
//  Tracker
//
//  Created by Anastasiia Ki on 11.12.2024.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorInset = ContentInset.paddingLeftRight()
        tableView.contentInset = ContentInset.paddingTop()
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var addNewCategoryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapAddNewCategory), for: .touchUpInside)
        button.setTitle("Добавить категорию", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.trackerWhite, for: .normal)
        button.backgroundColor = .trackerBlack
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryTableView)
        view.addSubview(addNewCategoryButton)
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        return scrollView
    }()
    
    // MARK: - Properties
    
    let viewModel = CategoryViewModel()
    private let categoryStore = TrackerCategoryStore()
    var categories: [String] = []
    var selectedCategory = ""
    
    var onDismiss: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        categoryStore.delegate = self
        bind()
        viewModel.getAllCategories()
        viewModel.getSelectedCategory()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .trackerWhite
        navigationItem.hidesBackButton = true
        navigationItem.title = "Категория"
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoryTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topAnchor),
            categoryTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryTableView.heightAnchor.constraint(equalToConstant:
                                                        categories.count != 0 ? CGFloat(categories.count) * Constants.tableCellHeight : view.frame.height * 0.67),
            addNewCategoryButton.topAnchor.constraint(greaterThanOrEqualTo: categoryTableView.bottomAnchor, constant: Constants.topAnchor),
            addNewCategoryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.bottomAnchor),
            addNewCategoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingButton),
            addNewCategoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingButton),
            addNewCategoryButton.heightAnchor.constraint(equalToConstant: Constants.heightButton)
        ])
    }
    
    private func bind() {
        viewModel.onCategoriesChange = { [weak self] categories in
            self?.categories = categories ?? []
            self?.categoryTableView.reloadData()
        }
        
        viewModel.onSelectedCategoryChange = { [weak self] selectedCategory in
            self?.selectedCategory = selectedCategory ?? ""
            self?.categoryTableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapAddNewCategory() {
        let newCategoryVC = NewCategoryViewController()
        navigationController?.pushViewController(newCategoryVC, animated: true)
    }
}

// MARK: - Presentation Controller Delegate

extension CategoryViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss?()
    }
}

// MARK: - Category Store Delegate

extension CategoryViewController: TrackerCategoryStoreDelegate {
    func trackerCategoryStoreDidUpdateCategories() {
        viewModel.getAllCategories()
    }
}
