//
//  GiphyImage+CoreDataProperties.swift
//  
//
//  Created by Ahmad Ansari on 02/04/2019.
//
//

import Foundation
import CoreData

extension GiphyImage {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GiphyImage> {
        return NSFetchRequest<GiphyImage>(entityName: "GiphyImage")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var downsizedURL: String?
    @NSManaged public var originalURL: String?
    @NSManaged public var previewURL: String?
    @NSManaged public var title: String?
    @NSManaged public var trendingDate: NSDate?
    @NSManaged public var cachedDate: NSDate?
    
}
