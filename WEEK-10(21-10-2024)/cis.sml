type item = { name: string, price: real, quantity: int }
type discount = real
type taxRate = real

fun itemTotal {name, price, quantity} = price * Real.fromInt quantity

fun calculateSubtotal items = List.foldl (fn (item, acc) => itemTotal item + acc) 0.0 items

fun applyDiscount subtotal discount = subtotal * ((100.0 - discount) / 100.0)

fun applyTax discountedSubtotal taxRate = discountedSubtotal * (taxRate / 100.0)

fun calculateFinalAmount items discount taxRate =
    let
        val subtotal = calculateSubtotal items
        val discountedSubtotal = applyDiscount subtotal discount
        val taxAmount = applyTax discountedSubtotal taxRate
    in
        discountedSubtotal + taxAmount
    end

fun formatReal r = Real.fmt (StringCvt.FIX (SOME 2)) r

fun padRight (s: string) (n: int) =
    let
        val len = String.size s
    in
        if len >= n then s
        else s ^ String.concat (List.tabulate (n - len, fn _ => " "))
    end

fun generateInvoice items discount taxRate =
    let
        val subtotal = calculateSubtotal items
        val discountedSubtotal = applyDiscount subtotal discount
        val discountAmount = subtotal - discountedSubtotal
        val taxAmount = applyTax discountedSubtotal taxRate
        val finalAmount = calculateFinalAmount items discount taxRate

        fun formatItem {name, price, quantity} =
            String.concat [
                padRight name 16,
                "$", formatReal price, "   ",
                Int.toString quantity, "        ",
                "$", formatReal (itemTotal {name = name, price = price, quantity = quantity})
            ]

        val header = ["Item               Price    Quantity    Total"]
        val itemLines = List.map formatItem items
        val summaryLines = [
            "\nSubtotal:          $" ^ formatReal subtotal,
            "Discount (" ^ formatReal discount ^ "%):   -$" ^ formatReal discountAmount,
            "After Discount:    $" ^ formatReal discountedSubtotal,
            "Tax (" ^ formatReal taxRate ^ "%):        $" ^ formatReal taxAmount,
            "------------------------------",
            "Total Payable:     $" ^ formatReal finalAmount
        ]
    in
        String.concatWith "\n" (["Itemized Invoice:"] @ header @ itemLines @ summaryLines)
    end

val items = [
    {name = "Laptop", price = 1200.0, quantity = 1},
    {name = "Headphones", price = 100.0, quantity = 2},
    {name = "Keyboard", price = 50.0, quantity = 1}
]
val discount = 10.0
val taxRate = 18.0

val _ = print (generateInvoice items discount taxRate ^ "\n")
