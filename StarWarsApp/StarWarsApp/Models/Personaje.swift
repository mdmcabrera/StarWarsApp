//
//  Personaje.swift
//  StarWarsApp
//
//  Copyright © 2019 Alex Garcia y Mar Cabrera. All rights reserved.
//

import Foundation
import Firebase

struct Personaje {
    
    let ref: DatabaseReference?
    let key: String
    let nombre: String
    let edad: String
    var raza: String
    
    init(nombre: String, edad: String, raza: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.nombre = nombre
        self.edad = edad
        self.raza = raza
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let nombre = value["nombre"] as? String,
            let edad = value["edad"] as? String,
            let raza = value["raza"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.nombre = nombre
        self.edad = edad
        self.raza = raza
    }
    
    func toAnyObject() -> Any {
        return [
            "nombre": nombre,
            "edad": edad,
            "raza": raza
        ]
    }
    
}

