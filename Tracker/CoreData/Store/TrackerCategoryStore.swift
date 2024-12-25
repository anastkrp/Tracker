//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Anastasiia Ki on 18.12.2024.
//

import CoreData

final class TrackerCategoryStore: NSObject {
    private let context = CoreDataStack.shared.context
    weak var delegate: TrackerCategoryStoreDelegate?
    private var fetchedResultsController: NSFetchedResultsController<TrackerCategoryCoreData>!
    
    override init() {
        super.init()
        
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TrackerCategoryCoreData.title, ascending: true)]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("[TrackerCategoryStore]: Error fetching categories - \(error)")
        }
    }
    
    func getCategories() -> [TrackerCategory] {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return [] }
        let allCategories = fetchedObjects.map{ TrackerCategory(title: $0.title ?? "", trackers: []) }
        return allCategories
    }
    
    func getCategoriesWithTrackers(trackers: [Tracker]) -> [TrackerCategory] {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return [] }
        
        return fetchedObjects.map { categoryCD in
            TrackerCategory(
                title: categoryCD.title ?? "",
                trackers: trackers.filter { tracker in
                    (categoryCD.trackers as? Set<TrackerCoreData>)?.contains { $0.id == tracker.id } ?? false
                }
            )
        }
    }
    
    func saveCategory(_ category: String){
        let categoryCD = TrackerCategoryCoreData(context: context)
        categoryCD.title = category
        CoreDataStack.shared.saveContext()
    }
}

extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.trackerCategoryStoreDidUpdateCategories()
    }
}
