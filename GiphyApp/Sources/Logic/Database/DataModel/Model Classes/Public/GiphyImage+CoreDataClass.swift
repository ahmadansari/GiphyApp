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
    
    class func saveImages(_ images: [ImageData], context: NSManagedObjectContext,
                          completion:@escaping (Error?) -> Void) {
        context.perform {
            
            //Date Type
            let convertToDate: ((String?) -> NSDate?) = { timestamp in
                guard let timestamp = timestamp else { return nil }
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
                return formatter.date(from: timestamp) as NSDate?
            }
            
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
                image?.downsizedURL = imageData.images.downsized.url
                image?.trendingDate = convertToDate(imageData.trendingDatetime)
                image?.cachedDate = Date() as NSDate
            }
            CoreDataStack.saveContext(context, { (error) in
                completion(error)
            })
        }
    }
    
}
