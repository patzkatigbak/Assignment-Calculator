//
//  ViewController.swift
//  Assignment-Calculator
//
//  Created by Patrick Katigbak, Sao Kuan I,  on 2022-09-19.
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
        textResult = ""
        ResultLabel.text = ""
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
        
    }
    
    func calculateResult()
    {
        //clean the textResult by removing the parenthesis
        var Result = ResultLabel.text
        Result!.removeAll(where: { removeCharacters.contains($0) })
        print("After Cleaning = \(Result)")
        
        //calculate result will only be performed if theres operator used
        if(operatorUsed != "")
        {
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
            case "x":
                Answer = firstNum * secondNum
            case "÷":
                Answer = firstNum / secondNum
            default:
                print("Invalid Operator")
            }

        
            ResultLabel.text = String(Answer.clean)
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
        
        let OperationButton:String! = (button.titleLabel?.text)
        
        if(textResult.contains("+") || textResult.contains("‒") ||
           textResult.contains("x") || textResult.contains("÷") ||
           textResult == "")
        {
               
            print("contains operator already - Do Nothing")
            
        }
        else
        {
            switch OperationButton
            {
            case "x":
                operatorUsed = "*"
            case "÷":
                operatorUsed = "/"
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

        //get the first character
        let firstCharacter = textResult.prefix(1)
        
        let lastCharacter = textResult.suffix(1)
        
        print(firstCharacter)
        print(hasDecimal)
        
        if(hasDecimal==true && numberButton == ".")
        {
            print("Nothing to do")
        }
        else
        {
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
        case "":
            updateTextResult(value: "-")
        case "-":
            updateTextResult(value: "")
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

