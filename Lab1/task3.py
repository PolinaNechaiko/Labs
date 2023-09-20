print("Python-калькулятор Нечайко Поліни! Можливі оператори: +, -, *, /")
a = int(input("Введіть перше число: "))
b = int(input("Введіть друге число: "))
while True:
    oper = input("Введіть оператор: ")
    if oper not in ('+', '-', '*', '/'):
        print("Помилка! Введіть дійсний оператор: ")
        continue

    if oper == '+':
        res = a + b
    elif oper == '-':
        res = a - b
    elif oper == '*':
        res = a * b
    elif oper == '/':
        res = a / b

    print("Результат=", res)
    break