//
//  DataMasterSearch.swift
//  Phobit
//
//  Created by Paul Wiesinger on 25.02.18.
//  Copyright © 2018 Paul Wiesinger. All rights reserved.
//

import Foundation

extension DataMaster {
    // billdata..
    // searched
    func search(text: String) {
        
        print("Eingabe: " + text);
        print("Now checking DATE");
        checkDate(text: text)
        print("Now checking MONTH")
        checkMonth(text: text);
        print("Now checking STRING")
        checkElse(text: text)
        
    }
    
    
    //
    //  DatumConvert.swift
    //  ConverterSearch
    //
    //  Created by Paul Krenn on 03.03.18.
    //  Copyright © 2018 Paul Krenn. All rights reserved.
    //
    
    
    
        
        func checkDate(text: String) -> Bool {
            let deletLerzeichen = text.replacingOccurrences(of: " ", with: "");
            var splited = Array(deletLerzeichen);
            
            
            while(true){
                if(splited.count <= 0){
                    return false;
                }
                
                var test:String = "";
                test.append(splited.first!);
                let first = test;
                
                
                if let number = Double(first){
                    break;
                } else {
                    splited.removeFirst();
                }
            }
            var fullTextString: String = "";
            
            for stelle in splited {
                fullTextString.append(stelle);
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = fullTextString;
            guard let date = dateFormatter.date(from: fullTextString) else {
                return false;
            }
            
            
            durchsuche(deinDatum: date, datumArray: billdata)
            
            return true;
        }
        
        
        
        func checkMonth(text: String) -> Bool {
            let deletLerzeichen = text.replacingOccurrences(of: " ", with: "");
            let month = Monate.init(searchText: deletLerzeichen);
            if(month.getMonth() == nil){
                return false;
            }
            var finished:String = "00.";
            let monates = month.getMonth()?.description;
            finished.append(monates!);
            
            var counter:Int = 2018;
            while foundResults(jahr: counter, texting: finished) <= 1 {
                counter = counter - 1;
                
                if(counter <= 2000){
                    
                    return false;
                    
                }
            }
            
            return true;
        }
        
    func foundResults(jahr: Int, texting: String) ->Int {
        
        var text = texting;
        let dateFormatter = DateFormatter()
        text.append(".");
        text.append(jahr.description);
        dateFormatter.dateFormat = text;
        guard let date = dateFormatter.date(from: text) else {
            return 0;
        }
        durchsucheMonat(deinDatum: date, array: billdata);
        
        
        if(searchedbilldata == nil){
            return 0;
        }
        return (searchedbilldata?.count)!;
        
        
        }
        
        func durchsuche(deinDatum: Date, datumArray: [BillData2]) {
            
            
            for choosenDate in datumArray {
                let variable = choosenDate.getDate();
                if(deinDatum.compare(variable).rawValue == 0){
                    searchedbilldata?.append(choosenDate)
                }
            }
            
            //USE finishedArray
            
            print(searchedbilldata ?? "EMPTY");
        }
    
    func durchsucheMonat(deinDatum: Date, array: [BillData2]) {
        
        
        for choosenVar in array {
            let variable = choosenVar.getDate();
            
            if(deinDatum.compare(variable).rawValue == -1){
                
                var dateComponent = DateComponents();
                dateComponent.day = 31;
                
                let futureDate = Calendar.current.date(byAdding: dateComponent, to: deinDatum);
                
                if(deinDatum.compare(variable).rawValue == 1){
                    
                    //searchedbilldata.append(choosenVar);
                    searchedbilldata?.append(choosenVar);
                    
                }
                
            }
        }
        if(searchedbilldata == nil){
            return;
        }
        print(searchedbilldata ?? "EMPTY")
    }
    func checkElse(text: String) -> Bool {
        if(text.count <= 3){
            return false;
        }
        for item in billdata {
            if(text.contains(item.rechnungsersteller)){
                searchedbilldata?.append(item);
            }
        }
        
        print(searchedbilldata ?? "NOTHING FOUND");
        return true;
    }
}