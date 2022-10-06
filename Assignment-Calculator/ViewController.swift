//
//  ViewController.swift
//  Assignment-Calculator
//
//  Created by Patrick Katigbak, Sao Kuan I, Michelle C K  on 2022-09-19.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var ResultLabel: UILabel!
    
    var textResult:String! = ""
    
    var hasDecimal:Bool = false
    
    var hasOperator:Bool = false
    
    var lastCharacterAfterDelete = "0"
    
    var emptyResultString = false
    
    var operatorUsed:String = ""
    let removeCharacters: Set<Character> = ["(", ")"]
    var negate:Float = -1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func plusMinusUpdate()
    {
        var firstNum:Float = 0.0
        var secondNum:Float = 0.0
        var Result = ResultLabel.text
        
        if(operatorUsed == "")
        {
            
            var firstNumString = Result
            firstNumString!.removeAll(where: { removeCharacters.contains($0) })
           
            firstNum = Float(firstNumString!) ?? 00
            firstNum = firstNum * negate
            textResult = String("(\(firstNum))")
            ResultLabel.text = textResult
            
        }
        else
        {
          //  var numberSplitArray = Result?.components(separatedBy: operatorUsed).compactMap(String.init)
            
            let numberSplitArray = Result?.components(separatedBy: operatorUsed)
            var firstNumString = String(numberSplitArray![0])
            var secondNumString = String(numberSplitArray![1])
            
            print("first num is \(firstNumString) and 2nd num is \(secondNumString)" )
            
            if (secondNumString == "" || secondNumString == "0" || secondNumString == "0." || secondNumString == "-")
            {
                if(secondNumString == "-")
                {
                    secondNumString = ""
                }
                else
                {
                    secondNumString = "-"
                }
                
                textResult = String("\(firstNumString)\(operatorUsed)\(secondNumString)")
                ResultLabel.text = textResult
                
            }
            else
            {
                secondNumString.removeAll(where: { removeCharacters.contains($0) })
                secondNum = Float(secondNumString) ?? 00
                secondNum = secondNum * negate
                secondNumString = String("(\(secondNum))")
                textResult = String("\(firstNumString)\(operatorUsed)\(secondNumString)")
                ResultLabel.text = textResult
                
            }

        }
        

//        textResult.removeLast()
//        ResultLabel.text = textResult
        
    }
    
    func clearTextResult()
    {
        hasDecimal = false
        textResult = "0"
        ResultLabel.text = textResult
        operatorUsed = ""
        
    }
    
    func updateTextResult(value:String)
    {
        textResult = textResult + value
        ResultLabel.text = textResult
        
    }
    
    func deleteChar()
    {
        
        if(ResultLabel.text != "")
        {
            textResult.removeLast()
            ResultLabel.text = textResult
            
            if(!textResult.contains("+") && !textResult.contains("‒") &&
               !textResult.contains("x") && !textResult.contains("÷"))
            {
                operatorUsed = ""
            }
        }
        
        if(ResultLabel.text == "")
        {
            textResult = "0"
            ResultLabel.text = textResult
            hasDecimal = false
        }
        
        
    }
    
    func calculateResult()
    {
        //clean the textResult by removing the parenthesis
        var Result = ResultLabel.text
        let remainder: Int = 0
        Result!.removeAll(where: { removeCharacters.contains($0) })
        print("After Cleaning = \(Result)")
        
        //calculate result will only be performed if theres operator used
        if(operatorUsed != "")
        {
            
            var formatResult8Decimal:Float = 0.0
            var numberSplitArray = Result?.components(separatedBy: operatorUsed).compactMap(Float.init)
            var firstNum = Float(numberSplitArray?[0] ?? 00 )
            var secondNum = Float(numberSplitArray?[1] ?? 00 )
            var Answer:Float = 0.0
            print("answer is \(Answer)")

            switch operatorUsed
            {
            case "+":
                Answer = firstNum + secondNum
            case "‒":
                Answer = firstNum - secondNum
            case "*":
                Answer = firstNum * secondNum
            case "÷":
                Answer = firstNum / secondNum
            default:
                print("Invalid Operator")
            }

            
           // formatResult8Decimal = round(value * 1000) / 1000.0
//            formatResult8Decimal = Float(String(Answer.clean))!
//            formatResult8Decimal = round(formatResult8Decimal * 100000000) / 100000000.0
            
            if (Answer.truncatingRemainder(dividingBy: 1) == 0)
            {
                textResult = String(format: "%.0f", Answer)
            }
            else
            {
                textResult = String(Answer)
                //cut the string to 8
            }
            ResultLabel.text = textResult
            
            textResult = ResultLabel.text
            operatorUsed = ""
            hasDecimal = false
        }
        else
        {
            print("No Operator used")
        }
        
    }
    

    @IBAction func Operation_Button_Pressed(_ sender: UIButton) {
        
        hasDecimal = false
        
        let button = sender as UIButton
        
        var OperationButton:String! = (button.titleLabel?.text)
        
        if(textResult.contains("+") || textResult.contains("‒") ||
           textResult.contains("x") || textResult.contains("÷") ||
           textResult == "" || textResult.contains("*"))
        {
               
            print("contains operator already - Do Nothing")
            
        }
        else
        {
            switch OperationButton
            {
            case "x":
                operatorUsed = "*"
                OperationButton = "*"
            case "÷":
                operatorUsed = "÷"
            case "%":
                print("Function not Implemented Yet")
                operatorUsed = ""
            default:
                operatorUsed = OperationButton
            }
            
//          operatorUsed = OperationButton
            updateTextResult(value: OperationButton)
            
        }
        
    }
    
    
    @IBAction func Number_Button_Pressed(_ sender: UIButton) {
        
        //set the label on what the button is clicked
        let button = sender as UIButton

        let numberButton:String! = (button.titleLabel?.text)

        textResult  = ResultLabel.text
        //get the first character
        let firstCharacter = textResult.prefix(1)
        
        let lastCharacter = textResult.suffix(1)
        
        
        if((numberButton == "." && operatorUsed != "" && hasDecimal == false) &&
            ((textResult.suffix(1) == "0") ||  (textResult.suffix(1) == operatorUsed))  )
        {
            print("went hereaaa")
            updateTextResult(value: "0")
        }
        
        if(hasDecimal==true && numberButton == ".")
        {
            print("Nothing to do")
        }
        else
        {
            
            if(numberButton == "." && textResult == "0" && operatorUsed == "")
            {
//                updateTextResult(value: "0")
            }
            else
            {
                if(textResult.suffix(2) == "-0")
                {
                    textResult.removeLast()
                }
                    
                if(textResult == "0" && hasDecimal == false)
                {
                    textResult.removeLast()
                }
                
            }
            
            updateTextResult(value: numberButton)
            
            if(numberButton == ".")
            {
                hasDecimal = true
            }
        }
        
    }
    
    
    @IBAction func SpecialPlusMinus_Button_Pressed(_ sender: UIButton) {
        
        var Result = ResultLabel.text
        
        switch Result
        {
        case "0":
            textResult = "-0"
            ResultLabel.text = textResult
        case "-0":
            textResult = "0"
            ResultLabel.text = textResult
        default:
            plusMinusUpdate()
        }
         
    }
    
    @IBAction func Extra_Button_pressed(_ sender: UIButton) {
        
        let button = sender as UIButton
        let ExtraButton:String! = (button.titleLabel?.text)
        
        switch ExtraButton
        {
        case "C":
            clearTextResult()
        case "Del":
            deleteChar()
        case "=":
            calculateResult()
        default:
            print("Do nothing - Function not implemented yet")
        }
    }
}

extension Float
{
    var clean:String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.8f", self)
    }
}

