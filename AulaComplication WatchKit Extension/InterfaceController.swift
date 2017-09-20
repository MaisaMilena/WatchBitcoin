//
//  InterfaceController.swift
//  AulaComplication WatchKit Extension
//
//  Created by Maisa Milena on 19/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, LoadCotacaoPresenterDelegate {

    var loader: LoaderPresenter?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        loader = LoaderPresenter()
        loader?.delegate = self
        loader?.getCotacao(from: .BTC)
    }
    
    override func willActivate() {
        // This method is called when watch view controllevars about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadCotacaoConcluido(dados: Double){
        print("Print no Load Cotacao no InterfaceController, valor: \(dados)")
    }
    
    func loadCotacaoFalhou(mensagem: String){
        
    }
}
