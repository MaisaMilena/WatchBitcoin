//
//  ComplicationController.swift
//  AulaComplication WatchKit Extension
//
//  Created by Maisa Milena on 19/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource, LoadCotacaoPresenterDelegate {
    
    var loader: LoaderPresenter?
    var cotacaoDolar: Double! = 0
    var cotacaoBitcoin: Double! = 0
    
    override init(){
        super.init()
        loader = LoaderPresenter()
        loader?.delegate = self
        loader?.getCotacao(from: .USD)
        

    }
    
    // MARK: - Funções do Load Presenter
    func loadCotacaoConcluido(cotacao: Double, moeda: Moeda){
        if moeda == Moeda.USD && cotacaoDolar == 0 {
            cotacaoDolar = cotacao
            loader?.getCotacao(from: .BTC)
        } else {
            cotacaoBitcoin = cotacao
            requestedUpdateDidBegin() //necessário após todo o carregamento para que os dados sejam atualizados na complication
        }
        
        print(" 🥁 Print no Load Cotacao Concluído em Complication Controller, valor: \(cotacao), moeda: \(moeda)")
        
    }
    
    func loadCotacaoFalhou(mensagem: String){
        print("Ocorreu um problema com a conexão com o servidor 🙁")
    }

    func requestedUpdateDidBegin() {
        let server=CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications! {
            server.reloadTimeline(for: complication)
        }
    }
    
    
    
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler(.init(rawValue: 0))
        
//        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        
        switch complication.family {
        case .modularLarge:
            let templateLarge = CLKComplicationTemplateModularLargeStandardBody()
            templateLarge.headerTextProvider = CLKSimpleTextProvider(text: "Cotações")
            templateLarge.body1TextProvider = CLKSimpleTextProvider(text: "USD: \(String(cotacaoDolar))")
            templateLarge.body2TextProvider = CLKSimpleTextProvider(text: "BTC: \(String(cotacaoBitcoin))")
            
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: templateLarge)
            handler(entry)
            
        default:
            print("to no default")
            handler(nil)
        }
        
        
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    // Cria um complication modelo
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        switch complication.family {
        case .modularLarge:
            let templateLarge = CLKComplicationTemplateModularLargeStandardBody()
            // header
            templateLarge.headerTextProvider = CLKSimpleTextProvider(text: "Cotação")
            // body 1
            templateLarge.body1TextProvider = CLKSimpleTextProvider(text: "USD (dólar)")
            // body2
            templateLarge.body2TextProvider = CLKSimpleTextProvider(text: "BTC (bitcoin)")
            
            handler(templateLarge)
            
            
        default:
            handler(nil)
        }
        
    }
    
}





