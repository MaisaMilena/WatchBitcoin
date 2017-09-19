//
//  ComplicationController.swift
//  AulaComplication WatchKit Extension
//
//  Created by Maisa Milena on 19/09/17.
//  Copyright © 2017 BEPiD. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
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
        
        let date = FormataData.buscaData()
        switch complication.family {
        case .modularLarge:
            let templateLarge = CLKComplicationTemplateModularLargeStandardBody()
            templateLarge.headerTextProvider = CLKSimpleTextProvider(text: "Data atual")
            templateLarge.body1TextProvider = CLKSimpleTextProvider(text: date)
            templateLarge.body2TextProvider = CLKSimpleTextProvider(text: "Informação")
            
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
            templateLarge.headerTextProvider = CLKSimpleTextProvider(text: "Data atual do template")
            // body 1
            templateLarge.body1TextProvider = CLKSimpleTextProvider(text: "Data")
            // body2
            templateLarge.body2TextProvider = CLKSimpleTextProvider(text: "Informação")
            
            handler(templateLarge)
            
            
        default:
            handler(nil)
        }
        
    }
    
}





