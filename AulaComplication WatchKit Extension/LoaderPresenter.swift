//
//  BitcoinPresenter.swift
//  AulaComplication
//
//  Created by Maisa Milena on 19/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import WatchKit

enum Moeda{
    case USD, BTC
}

protocol LoadCotacaoPresenterDelegate{
    func loadCotacaoConcluido(dados: String)
    func loadCotacaoFalhou(mensagem: String)
}


class LoaderPresenter: NSObject, JsonLoaderDelegate {

    let dolarURL = "http://api.promasters.net.br/cotacao/v1/valores?moedas=USD&alt=json"
    let bitcoinURL = "http://api.promasters.net.br/cotacao/v1/valores?moedas=BTC&alt=json"

    let loader = JsonLoaderDelegate()
    let delegate : LoadCotacaoPresenterDelegate?
    
    
    var moeda: Moeda!
    
    override init() {
        super.init()
        loader.delegate = self
        // Faz a requisição para a classe JsonLoader que chama o webservice
        loader
        
    }
    
    
    func loaderJsonConcluido(arrayDicionario: [NSDictionary]){
        let dados = tratarJson(arrayDicionario: arrayDicionario)
        // Transmite esses dados tratados para uma outra classe
        self.delegate.loadCotacaoConcluido(dados: dados)
    }
    
    func loaderJsonFalhou(mensagem: String){
        delegate.loadCotacaoFalhou(mensagem)
    }
    
    private func tratarJson(arrayDicionario: [NSDictionary]) -> Array<String>{
        
        var dados = Array<NSDictionary>()
        var valoresKey = Array<NSDictionary>()
        
        print("✨ Array dicionario no Presenter ✨")
        print(arrayDicionario)
        
        
        
//        
//        for dado in arrayDicionario{
//            
//            valoresKey = dado.object(forKey: "valores") as! Array<NSDictionary>
//            let bpi = dado.object(forKey: "bpi")
//            
//            
//            
//           
//        }
        
        return []
    }
}
