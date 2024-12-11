//
//  CoreDataManager.swift
//  CineFlix
//
//  Created by Rajat Sachdeva on 2024-12-10.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CineFlix") // Replace with your .xcdatamodeld name
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // MARK: - Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Save Movie to Core Data
    func saveMovie(_ movie: Movie) {
        let movieEntity = MovieCoreDataEntity(context: context) // Use persistentContainer context directly
        movieEntity.id = Int64(movie.id)
        movieEntity.title = movie.displayTitle
        movieEntity.overview = movie.overview
        movieEntity.posterPath = movie.poster_path
        movieEntity.releaseDate = movie.release_date
        movieEntity.voteAverage = movie.vote_average ?? 0.0

        saveContext()
    }

    // MARK: - Fetch Movies from Core Data
    func fetchMovies() -> [MovieCoreDataEntity] {
        let fetchRequest: NSFetchRequest<MovieCoreDataEntity> = MovieCoreDataEntity.fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Delete Movie from Core Data
    func deleteMovie(_ movie: MovieCoreDataEntity) {
        context.delete(movie)
        saveContext()
    }

    // MARK: - Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("Changes saved to Core Data.")
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
