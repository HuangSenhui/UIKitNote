//
//  Meal.swift
//  UIKitNote
//
//  Created by HuangSenhui on 2020/12/20.
//

import UIKit
import os.log

class Meal: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    
    var name: String
    var image: UIImage?
    var rating: Int
    
     init?(name: String, image: UIImage?, rating: Int) {
        if name.isEmpty || rating > 5 || rating < 0 {
            return nil
        }
        self.name = name
        self.image = image
        self.rating = rating
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(image, forKey: PropertyKey.photo)
        coder.encode(rating, forKey: PropertyKey.rating)
        
    }
    
    required convenience init?(coder: NSCoder) {
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("name 解挡失败", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = coder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name: name, image: photo, rating: rating)
    }
    
    static let directory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveUrl = directory.appendingPathComponent("meals")
    
    static func save(meals: [Meal]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: true)
            try data.write(to: Self.archiveUrl)
            os_log("meal 归档成功", log: OSLog.default, type: .debug)
        } catch {
            os_log("meal 归档失败", log: OSLog.default, type: .error)
        }
        
    }
    
    static func read() -> [Meal]? {
        do {
            let data = try Data(contentsOf: Self.archiveUrl)
            let meals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Meal]
            return meals
        } catch {
            os_log("meal 解挡失败", log: OSLog.default, type: .error)
        }
        return nil
    }
}
