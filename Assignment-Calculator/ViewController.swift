//
//  ViewController.swift
//  Program ID: Assignment2-Calculator Basic Functionality
//  Author: Patrick Katigbak(301253113), Sao Kuan I(301204757), Chan Yat Man(301279592)
//  Description: Calculator with basic functionality working
//  Last Modification: October 5, 2022


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
      
    }
    
    //When +/- Button is pressed and the screen result or value is not zero this function will be triggered
    func plusMinusUpdate()
    {
        var firstNum:Float = 0.0
        var secondNum:Float = 0.0
        var Result = ResultLabel.text
        
        //This will put ( ) parethesis to input number when +/- is entered. to negate or reverse the negate
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
        
        
    }
    
    /*this will be triggered when Clear button is pressed*/
    func clearTextResult()
    {
        hasDecimal = false
        textResult = "0"
        ResultLabel.text = textResult
        operatorUsed = ""
        
    }
    
    /*This will be triggered everytime a number/operation/extra buttion is pressed. this will Append the text in the screen*/
    func updateTextResult(value:String)
    {
        textResult = textResult + value
        ResultLabel.text = textResult
        
    }

    /*This will be triggered when delete button is pressed*/
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
    
    /*This will do the calculation. when = button is pressed*/
    func calculateResult()
    {
        /*clean the textResult by removing the parenthesis*/
        var Result = ResultLabel.text
        let remainder: Int = 0
        Result!.removeAll(where: { removeCharacters.contains($0) })
        
        /*calculate result will only be performed if theres operator used*/
        if(operatorUsed != "")
        {

            var numberSplitArray = Result?.components(separatedBy: operatorUsed).compactMap(Double.init)
            var firstNum = Double(numberSplitArray?[0] ?? 00 )
            var secondNum = Double(numberSplitArray?[1] ?? 00 )
            var Answer:Double = 0.00
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

    
            
            if (Answer.truncatingRemainder(dividingBy: 1) == 0)
            {
                textResult = String(format: "%.0f", Answer)
            }
            else
            {
                textResult = String(Answer.removeZerosFromEnd())
            }
            
            
            ResultLabel.text = textResult
            operatorUsed = ""
            hasDecimal = false
        }
        else
        {
            print("No Operator used")
        }
        
    }
    

    /*This will be triggeree when any operation button is pressed*/
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
            
            updateTextResult(value: OperationButton)
            
        }
        
    }
    
    
    /*when any numeric button is pressed, this will be triggered*/
    @IBAction func Number_Button_Pressed(_ sender: UIButton) {
        
        //set the label on what the button is clicked
        let button = sender as UIButton

        let numberButton:String! = (button.titleLabel?.text)

        textResult  = ResultLabel.text
     
        let firstCharacter = textResult.prefix(1)
        
        let lastCharacter = textResult.suffix(1)
        
        
        if((numberButton == "." && operatorUsed != "" && hasDecimal == false) &&
            ((textResult.suffix(1) == "0") ||  (textResult.suffix(1) == operatorUsed))  )
        {
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
    
    
    /*When +/- is pressed*/
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
    
    @IBAction func Percent_Button_pressed(_ sender: UIButton) {
        var Result = ResultLabel.text
        var Answer:Float = 0.0
        
        //will be performed only when theres no current operation
        if(operatorUsed == "")
        {
            let removeCharacters: Set<Character> = ["(", ")"]

            Result!.removeAll(where: { removeCharacters.contains($0) })
            
            Answer = Float(Result!)! / 100
            
            textResult = String(Answer)
            
            ResultLabel.text = textResult
            
            hasDecimal = false
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

/*This extension and function below was taken from: https://stackoverflow.com/questions/29560743/swift-remove-trailing-zeros-from-double#:~:text=In%20Swift%204%20you%20can,precision)%20return%20String(formatter.
*/
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return String(formatter.string(from: number) ?? "")
    }
}
