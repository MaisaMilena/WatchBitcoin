//
//  JsonLoader.swift
//  AulaComplication
//
//  Created by Maisa Milena on 19/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import WatchKit
import Alamofire

protocol JsonLoaderDelegate {
    /// Passar esse método adiante significa sucesso
    func loaderJsonConcluido(arrayDicionario: [NSDictionary])
    
    /// Repassar a mensagem de erro adiante
    func loaderJsonFalhou(mensagem: String)
}


class JsonLoader: NSObject {

    var delegate:JsonLoaderDelegate?
    
    public func getDados(url: String){
        Alamofire.request(url, method: .get).responseJSON { response in
            
            switch response.result {
            case .success:
                let arrayDadosJSON = response.result.value as! NSDictionary
                self.delegate?.loaderJsonConcluido(arrayDicionario: [arrayDadosJSON])
                break
            case .failure(let error):
                self.delegate?.loaderJsonFalhou(mensagem: "🦊 Algum erro ocorreu, verifique o status do servidor: \(error)")
                break
            }
        }
    }
    
}
