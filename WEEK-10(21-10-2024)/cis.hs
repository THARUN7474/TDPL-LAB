import Text.Printf (printf)

type Item = (String, Double, Int)
type Discount = Double
type TaxRate = Double

itemTotal :: Item -> Double
itemTotal (_, unitPrice, quantity) = unitPrice * fromIntegral quantity

calculateSubtotal :: [Item] -> Double
calculateSubtotal items = sum $ map itemTotal items

applyDiscount :: Double -> Discount -> Double
applyDiscount subtotal discount = subtotal * ((100 - discount) / 100)

applyTax :: Double -> TaxRate -> Double
applyTax discountedSubtotal taxRate = discountedSubtotal * (taxRate / 100)

calculateFinalAmount :: [Item] -> Discount -> TaxRate -> Double
calculateFinalAmount items discount taxRate = finalAmount
  where
    subtotal = calculateSubtotal items
    discountedSubtotal = applyDiscount subtotal discount
    taxAmount = applyTax discountedSubtotal taxRate
    finalAmount = discountedSubtotal + taxAmount

generateInvoice :: [Item] -> Discount -> TaxRate -> String
generateInvoice items discount taxRate =
  unlines $ ["Itemized Invoice:"] ++
            ["Item              Price      Quantity    Total"] ++
            [ formatItem item | item <- items ] ++
            [ "\nSubtotal:         $" ++ formatDouble subtotal
            , "Discount (" ++ show discount ++ "%):  -$" ++ formatDouble discountAmount
            , "After Discount:   $" ++ formatDouble discountedSubtotal
            , "Tax (" ++ show taxRate ++ "%):       $" ++ formatDouble taxAmount
            , "----------------------------------------"
            , "Total Payable:    $" ++ formatDouble finalAmount
            ]
  where
    subtotal = calculateSubtotal items
    discountedSubtotal = applyDiscount subtotal discount
    discountAmount = subtotal - discountedSubtotal
    taxAmount = applyTax discountedSubtotal taxRate
    finalAmount = calculateFinalAmount items discount taxRate

    formatItem (name, price, quantity) =
      printf "%-16s $%-9.2f %-10d $%-8.2f" name price quantity (itemTotal (name, price, quantity))

    formatDouble = printf "%.2f"

main :: IO ()
main = do
  let items = [("Laptop", 1200.0, 1), ("Headphones", 100.0, 2), ("Keyboard", 50.0, 1)]
  let discount = 10
  let taxRate = 18
  putStrLn (generateInvoice items discount taxRate)
