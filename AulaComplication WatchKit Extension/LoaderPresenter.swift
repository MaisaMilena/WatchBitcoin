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
    func loadCotacaoConcluido(dados: Double)
    func loadCotacaoFalhou(mensagem: String)
}


class LoaderPresenter: NSObject, JsonLoaderDelegate {

    let dolarURL = "http://api.promasters.net.br/cotacao/v1/valores?moedas=USD&alt=json"
    let bitcoinURL = "http://api.promasters.net.br/cotacao/v1/valores?moedas=BTC&alt=json"

    let loader = JsonLoader()
    var delegate : LoadCotacaoPresenterDelegate?
    
    var moeda: Moeda!
    
    override init() {
        super.init()
        loader.delegate = self
        
    }
    
    func getCotacao(from moeda: Moeda){
        self.moeda = moeda
        if moeda == Moeda.USD{
            loader.getDados(url: dolarURL)
        } else {
            loader.getDados(url: bitcoinURL)
        }
    }
    
    
    func loaderJsonConcluido(arrayDicionario: [NSDictionary]){
        let dados = tratarJson(arrayDicionario: arrayDicionario)
        // Transmite esses dados tratados para uma outra classe
        self.delegate?.loadCotacaoConcluido(dados: dados)
    }
    
    func loaderJsonFalhou(mensagem: String){
        delegate?.loadCotacaoFalhou(mensagem: mensagem)
    }
    
    private func tratarJson(arrayDicionario: [NSDictionary]) -> Double{

        print("✨ Resposta do servidor ✨")
        print(arrayDicionario)
        
        let moeda:String = {
            return self.moeda == Moeda.USD ? "USD" : "BTC"
        }()
        
        let valoresKey = arrayDicionario[0].object(forKey: "valores") as! NSDictionary
        let dadosMoeda = valoresKey.object(forKey: moeda) as! NSDictionary
        let valorMoeda = dadosMoeda.object(forKey: "valor") as! NSNumber
        
        return valorMoeda as! Double
    }
}
