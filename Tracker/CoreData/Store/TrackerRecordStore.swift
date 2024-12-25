//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Anastasiia Ki on 18.12.2024.
//

import CoreData

final class TrackerRecordStore: NSObject {
    private let context = CoreDataStack.shared.context
    weak var delegate: TrackerRecordStoreDelegate?
    private var fetchedResultsController: NSFetchedResultsController<TrackerRecordCoreData>!
    
    override init() {
        super.init()
        
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TrackerRecordCoreData.date, ascending: true)]
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
            print("[TrackerRecordStore]: Error fetching records - \(error)")
        }
    }
    
    func getRecords() -> [TrackerRecord] {
        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return [] }
        
        let allRecords = fetchedObjects.map {
            TrackerRecord(
                trackerId: $0.trackerId ?? UUID(),
                date: $0.date ?? Date()
            )
        }
        return allRecords
    }
    
    func saveRecord(trackerId: UUID, date: Date) {
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", trackerId as CVarArg)
        
        do {
            let trackers = try context.fetch(fetchRequest)
            guard let tracker = trackers.first else { return }
            
            let recordCD = TrackerRecordCoreData(context: context)
            recordCD.trackerId = tracker.id
            recordCD.date = date
            recordCD.tracker = tracker
            CoreDataStack.shared.saveContext()
        } catch {
            print("[saveRecord]: Error saving record - \(error)")
        }
    }
    
    func deleteRecord(trackerId: UUID, date: Date) {
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "%K == %@ AND %K == %@",
            #keyPath(TrackerRecordCoreData.trackerId), trackerId as CVarArg,
            #keyPath(TrackerRecordCoreData.date), date as CVarArg
        )
        
        do {
            let results = try context.fetch(fetchRequest)
            results.forEach { context.delete($0) }
            CoreDataStack.shared.saveContext()
        } catch {
            print("[deleteRecord]: Error deleting record - \(error)")
        }
    }
}

extension TrackerRecordStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.trackerRecordStoreDidUpdate()
    }
}
