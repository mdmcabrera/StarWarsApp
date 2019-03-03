//
//  ViewControllerResumen.swift
//  StarWarsApp
//
//  Created by Alejandro on 02/02/2019.
//  Copyright © 2019 Alex Garcia y Mar Cabrera. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerResumen: UIViewController {

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblhistoria: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var item: Personaje?
    func cargarDatos(){
        
    lblNombre.text = item?.nombre
    lblhistoria.text = item?.raza
    img.image =  UIImage(named: "animal.png")!

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatos()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
