//
//  TrackerPinnedStore.swift
//  Tracker
//
//  Created by Anastasiia Ki on 18.01.2025.
//

import CoreData

final class TrackerPinnedStore: NSObject {
    private let context = CoreDataStack.shared.context
    weak var delegate: TrackerPinnedStoreDelegate?
    private var fetchedResultsController: NSFetchedResultsController<TrackerPinnedCoreData>!
    
    override init() {
        super.init()
        
        let fetchRequest = TrackerPinnedCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TrackerPinnedCoreData.trackerId, ascending: true)]
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
            print("[TrackerPinnedStore]: Error fetching records - \(error)")
        }
    }
    
    func getPinnedTrackers() -> [TrackerPinned] {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return [] }
        
        let allPinned = fetchedObjects.map {
            TrackerPinned(trackerId: $0.trackerId ?? UUID())
        }
        return allPinned
    }
    
    func savePinnedTracker(trackerId: UUID) {
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", trackerId as CVarArg)
        
        do {
            let trackers = try context.fetch(fetchRequest)
            guard let tracker = trackers.first else { return }
            
            let pinnedCD = TrackerPinnedCoreData(context: context)
            pinnedCD.trackerId = trackerId
            pinnedCD.trackers = tracker
            CoreDataStack.shared.saveContext()
        } catch {
            print("[savePinnedTracker]: Error saving pinned tracker - \(error)")
        }
    }
    
    func deletePinnedTracker(trackerId: UUID) {
        let fetchRequest = TrackerPinnedCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackerId == %@", trackerId as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            results.forEach { context.delete($0) }
            CoreDataStack.shared.saveContext()
        } catch {
            print("[deletePinnedTracker]: Error deleting pinned tracker - \(error)")
        }
    }
}

extension TrackerPinnedStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.pinnedStoreDidUpdate()
    }
}
