//
//  InterfaceController.swift
//  AulaComplication WatchKit Extension
//
//  Created by Maisa Milena on 19/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import WatchKit
import Foundation

protocol CotacaoDelegate{
    func cotacaoDelegateConcluida(cotacaoDolar: Double, cotacaoBitcoin: Double)
}


class InterfaceController: WKInterfaceController, LoadCotacaoPresenterDelegate {

    // MARK: - Delegates
    var loader: LoaderPresenter?
    var cotacaoDelegate: CotacaoDelegate?
    
    // MARK: - Valor das cotações
    var cotacaoDolar: Double!
    var cotacaoBitcoin: Double!
    
    // MARK: - Funções principais
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        loader = LoaderPresenter()
        loader?.delegate = self
        loader?.getCotacao(from: .BTC)
        loader?.getCotacao(from: .USD)
        
        //cotacaoDelegate?.cotacaoDelegateConcluida(cotacaoDolar: cotacaoDolar, cotacaoBitcoin: cotacaoBitcoin)
    }
    
    override func willActivate() {
        // This method is called when watch view controllevars about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: - Funções do Load Presenter
    func loadCotacaoConcluido(cotacao: Double, moeda: Moeda){
        if moeda == Moeda.USD {
            cotacaoDolar = cotacao
        } else {
            cotacaoBitcoin = cotacao
        }
        
        print("Print no Load Cotacao no InterfaceController, valor: \(cotacao), moeda: \(moeda)")
    }
    
    func loadCotacaoFalhou(mensagem: String){
        print("Ocorreu um problema com a conexão com o servidor 🙁")
    }
}
