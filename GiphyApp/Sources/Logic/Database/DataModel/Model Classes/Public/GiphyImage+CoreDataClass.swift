//
//  GiphyImage+CoreDataClass.swift
//  
//
//  Created by Ahmad Ansari on 02/04/2019.
//
//

import Foundation
import CoreData

@objc(GiphyImage)
public class GiphyImage: NSManagedObject {
    //Entity Name
    static let entityName = GiphyImage.entity().name ?? "GiphyImage"
    
    //DTO
    lazy var giphyImageDTO: GiphyImageDTO = {
        return GiphyImageDTO.init(image: self)
    }()
}

extension GiphyImage: DataTransferProtocol {
    func dataTransferObject() -> Any? {
        return self.giphyImageDTO
    }
}

//Data Persistence
extension GiphyImage {
    
    class func saveImages(_ images: [ImageData], context: NSManagedObjectContext) {
        context.perform {
            for imageData in images {
                let id: String = imageData.id
                let request: NSFetchRequest = GiphyImage.fetchRequest()
                request.predicate = NSPredicate(format: "SELF.id LIKE[cd] %@", id)
                let filteredResults = try? context.fetch(request)
                
                var image: GiphyImage?
                if (filteredResults?.isEmpty == false) {
                    image = filteredResults?.first
                } else {
                    image = GiphyImage(context: context)
                }
                image?.id = id
                image?.title = imageData.title
                image?.originalURL = imageData.images.original.url
                image?.previewURL = imageData.images.preview.url
            }
            CoreDataStack.saveContext(context)
        }
    }
    
}
