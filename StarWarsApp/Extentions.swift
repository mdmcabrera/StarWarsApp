//
//  Extentions.swift
//  StarWarsApp
//
//  Copyright © 2019 Alex Garcia y Mar Cabrera. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    // AÑADIR LOS COLORES DESEADOS AQUI SIGUIENDO LA DECLARACION
    static let colorTableView = UIColor().colorFromHex("03054f")
    static let colorCelda = UIColor().colorFromHex("050a8f")
    
    
    func colorFromHex(_ hex : String) -> UIColor{
        // Convertimos el String en rgb
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6{
            return UIColor.black
        }
        
        var rgb: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha: 1.0)
        
    }
    
    
}
