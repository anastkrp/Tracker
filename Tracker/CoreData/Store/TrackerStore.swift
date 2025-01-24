//
//  TrackerStore.swift
//  Tracker
//
//  Created by Anastasiia Ki on 18.12.2024.
//

import CoreData

final class TrackerStore: NSObject {
    private let context = CoreDataStack.shared.context
    weak var delegate: TrackerStoreDelegate?
    private var fetchedResultsController: NSFetchedResultsController<TrackerCoreData>!
    
    override init() {
        super.init()
        
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TrackerCoreData.name, ascending: true)]
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
            print("[TrackerStore]: Error fetching tracker - \(error.localizedDescription)")
        }
    }
    
    func getTrackers() -> [Tracker] {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return [] }
        
        let allTrackers = fetchedObjects.map {
            Tracker(id: $0.id ?? UUID(),
                    name: $0.name ?? "",
                    color: $0.color?.hexColor ?? .selection1,
                    emoji: $0.emoji ?? "",
                    schedule: $0.schedule as? [Schedule] ?? [])
        }
        return allTrackers
    }
    
    func saveTrackerWithCategory(tracker: Tracker, category: String) {
        guard let categoryCD = fetchCategory(title: category) else { return }
        
        let newTracker = TrackerCoreData(context: context)
        newTracker.id = tracker.id
        newTracker.name = tracker.name
        newTracker.color = tracker.color.hexString
        newTracker.emoji = tracker.emoji
        newTracker.schedule = tracker.schedule as NSObject
        
        categoryCD.addToTrackers(newTracker)
        CoreDataStack.shared.saveContext()
    }
    
    func deleteTracker(withId id: UUID) {
        let fetchRequest: NSFetchRequest<TrackerCoreData> = TrackerCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let results = try? context.fetch(fetchRequest).first {
                results.category = nil
                context.delete(results)
                CoreDataStack.shared.saveContext()
            }
        }
    }
    
    func updateTracker(category: String, tracker: Tracker) {
        guard let currentCategory = fetchCategory(trackerId: tracker.id) else { return }
        guard let currentTracker = fetchTracker(trackerId: tracker.id) else { return }
        
        if currentTracker.name != tracker.name {
            currentTracker.name = tracker.name
        }
        
        if currentTracker.color != tracker.color.hexString {
            currentTracker.color = tracker.color.hexString
        }
        
        if currentTracker.emoji != tracker.emoji {
            currentTracker.emoji = tracker.emoji
        }
        
        if currentTracker.schedule as? [Schedule] != tracker.schedule {
            currentTracker.schedule = tracker.schedule as NSObject
        }
        
        if currentCategory.title != category {
            currentCategory.removeFromTrackers(currentTracker)
            
            if let newCategory = fetchCategory(title: category) {
                newCategory.addToTrackers(currentTracker)
            } else {
                let newCategory = TrackerCategoryCoreData(context: context)
                newCategory.title = category
                newCategory.addToTrackers(currentTracker)
            }
        }
        CoreDataStack.shared.saveContext()
    }
    
    private func fetchTracker(trackerId: UUID) -> TrackerCoreData? {
        let fetchRequest: NSFetchRequest<TrackerCoreData> = TrackerCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", trackerId as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            return nil
        }
    }
    
    private func fetchCategory(title: String) -> TrackerCategoryCoreData? {
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            return nil
        }
    }
    
    private func fetchCategory(trackerId: UUID) -> TrackerCategoryCoreData? {
        let fetchRequest = TrackerCategoryCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ANY trackers.id == %@", trackerId as CVarArg)
        
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            return nil
        }
    }
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.trackerStoreDidUpdateTrackers()
    }
}
