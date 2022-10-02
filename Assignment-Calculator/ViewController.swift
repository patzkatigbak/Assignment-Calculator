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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func clearTextResult()
    {
        hasDecimal = false
        textResult = ""
        ResultLabel.text = ""
        
    }
    
    func updateTextResult(value:String)
    {
        textResult = textResult + value
        ResultLabel.text = textResult
        
    }
    
    func deleteChar()
    {
        textResult.removeLast()
        ResultLabel.text = textResult
    }
    
    func calculateResult()
    {
        //To be replaced by non NSExpression
//        let expression = NSExpression(format: textResult)
//        let result = expression.expressionValue(with: nil, context: nil) as! Double
//        let resultString = formatResult(result:result)
//
        let Result = ResultLabel.text
      //  var firstNumber:Double! = 0.0
        
        
        var numberSplitArray = Result?.components(separatedBy: operatorUsed).compactMap(Float.init)
        var firstNum = Float(numberSplitArray?[0] ?? 00 )
        var secondNum = Float(numberSplitArray?[1] ?? 00 )
        var Answer:Float = 0.0
        print("answer is \(Answer)")

        switch operatorUsed
        {
        case "+":
            Answer = firstNum + secondNum
        case "-":
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
    }
    

    @IBAction func Operation_Button_Pressed(_ sender: UIButton) {
        
        hasDecimal = false
        
        let button = sender as UIButton
        
        let OperationButton:String! = (button.titleLabel?.text)
        
        if(textResult.contains("+") || textResult.contains("-") ||
           textResult.contains("x") || textResult.contains("÷"))
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
            default:
                operatorUsed = OperationButton
            }
            
            operatorUsed = OperationButton
            

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
        

        
        
        //print the tag value of thre button. THis is set in the attribute of buttons
       // print(button.tag)
        
        //hide the label of button when clicked
       // button.titleLabel?.isHidden = true
    }
    
    
    @IBAction func Extra_Button_pressed(_ sender: UIButton) {
        
        let button = sender as UIButton
        let ExtraButton:String! = (button.titleLabel?.text)
        
        
        //can be converted to switch case (to be recoded)
        if(ExtraButton == "C")
        {
            clearTextResult()
        }
        if(ExtraButton == "Del")
        {
            deleteChar()
        }
        if(ExtraButton == "=")
        {
            calculateResult()
        }
        
//        var ExtraButton:String = button.titleLabel!.text;
        
    }
}

extension Float
{
    var clean:String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.8f", self)
    }
}

