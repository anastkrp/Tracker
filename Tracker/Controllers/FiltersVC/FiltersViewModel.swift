//
//  FiltersViewModel.swift
//  Tracker
//
//  Created by Anastasiia Ki on 20.01.2025.
//

import Foundation

final class FiltersViewModel {
    private let storage = TrackersStorage.shared
    
    private var filters: [String] = []
    private var selectedFilter: FilterType = .all
    
    var onFiltersChanged: Binding<[String]>?
    var onSelectedFilterChanged: Binding<FilterType>?
    
    func getFilters() {
        filters = storage.filters
        onFiltersChanged?(filters)
    }
    
    func getSelectedFilter() {
        selectedFilter = storage.selectedFilter
        onSelectedFilterChanged?(selectedFilter)
    }
    
    func updateSelectedFilter(_ index: Int) {
        storage.selectedFilter = FilterType.allCases[index]
    }
}
