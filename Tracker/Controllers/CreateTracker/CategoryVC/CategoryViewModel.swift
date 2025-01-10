//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Anastasiia Ki on 27.12.2024.
//

import Foundation

typealias Binding<T> = (T) -> Void

final class CategoryViewModel {
    
    private let categoryStore = TrackerCategoryStore()
    private let storage = TrackersStorage.shared
    
    private var allCategories: [String] = []
    private var selectedCategory: String?
    
    var onCategoriesChange: Binding<[String]?>?
    var onSelectedCategoryChange: Binding<String?>?
    
    // MARK: - Methods for CategoryViewController
    
    func getAllCategories() {
        allCategories = categoryStore.getCategories().map { $0.title }
        onCategoriesChange?(allCategories)
    }
    
    func getSelectedCategory() {
        selectedCategory = storage.selectedCategory
        onSelectedCategoryChange?(selectedCategory)
    }
    
    func didSelectCategory(indexPath: IndexPath) {
        selectedCategory = allCategories[indexPath.row]
        storage.selectedCategory = selectedCategory
        onSelectedCategoryChange?(selectedCategory)
    }
    
    // MARK: - Methods for NewCategoryViewController
    
    func addCategory(title: String) {
        categoryStore.saveCategory(title)
    }
}
