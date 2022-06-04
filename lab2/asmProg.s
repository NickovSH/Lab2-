.data

# Массив с числами (размером в 1 байт)
array:
    .byte 43, 145, 184, 9, 85, 22, 19, 56, 233, 2
array_end:

# Формат вывода числа
format_print:
    .string "%d "

# Формат вывода кол-во чисел, меньших 128
count_print:
    .string "Count num less 128 = %d\n"

# Вывод новой строки
next_line:
    .string "\n"


.text
.globl main


# esi - указатель на элемент массива

# Главная функция
main:
    # Маска, с которой нужно сделать ИЛИ
    movb $0b01101011, %dl
    # Записываем в esi начало массива
    movl $array, %esi

# Цикличное ИЛИ с каждом элементом
or_loop:
    # Вытаскиваем значение элемента из вассива
    movb (%esi), %al
    # ИЛИ
    orb %dl, %al
    # Помещаем новое значение обратно в массив
    movb %al, (%esi)

    # Переходим к след. элементу массива
    inc %esi
    # Проверям, не дошли ли до конца массива
    cmpl $array_end, %esi

    # Если нет, то повторяем or_loop
    jne or_loop


    # Кидаем в esi первый элемент массива
    movl $array, %esi
# Вывод массива
print_array:
    # Обнуляем eax, чтоб в нем не было мусора
    xorl %eax, %eax
    # Кидаем в него значение элемента массива
    movb (%esi), %al
    # Теперь его кидаем в стэк
    pushl %eax
    # Кидаем в стэк формат вывода числа
    pushl $format_print
    # Вызываем вывод числа
    call printf
    # Возвращаем указатель стэка назад
    addl $8, %esp

    # переходим к след. элементу массива
    inc %esi

    # Проверяем на конец массива
    cmp $array_end, %esi
    jne print_array

    
    # Переводим каретку на новую строку
    pushl $next_line
    call printf
    addl $4, %esp

    
    movl $array, %esi
    # Обнуляем счетчик
    xorl %edx, %edx
# Считаем кол-во элементов, меньших 128
calc_num:
    # Вытаскиваем значение элемента
    movb (%esi), %al
    # Сравниваем с 128
    cmpb $128, %al
    # Если больше, то просто переходим к след. элементу
    jae next_num

    # Если нет, то увелич. счетчик
    inc %edx
# Переход к след. элементу
next_num:
    inc %esi
    cmpl $array_end, %esi
    jne calc_num

    # Выводим кол-во элементов, меньших 128
    pushl %edx
    pushl $count_print
    call printf
    addl $8, %esp

    # Завершение программы
    movl $1, %eax
    movl $0, %ebx
    int $0x80
