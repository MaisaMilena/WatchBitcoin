//
//  FormataData.swift
//  AulaComplication
//
//  Created by Maisa Milena on 19/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import WatchKit

class FormataData: NSObject {
    
    /**
     Função que busca a data atual e retorna o formato em String
     */
    class func buscaData() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: date)
        
    }
}
