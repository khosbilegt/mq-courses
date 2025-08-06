count_5c = 3
count_10c = 1
count_1d = 2
count_5d = 3

total_purchase_amount = 1.25

total_payment = (count_5c * 0.05) + (count_10c * 0.10) + (count_1d * 1.00) + (count_5d * 5.00)

dollars = int(total_payment)
cents = int((total_payment - dollars) * 100)

# Part A
print(f"Payment received: {dollars} dollars and {cents} cents")

# Part B
change = total_payment - total_purchase_amount
change_dollars = int(change)
change_cents = int((change - change_dollars) * 100)

print(f"Change given: {change_dollars} dollars and {change_cents} cents")
