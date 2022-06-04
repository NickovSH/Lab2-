#include <iostream>

using namespace std;

int main()
{
    // Массив из 10 байт
    unsigned char array[] = {43, 145, 184, 9, 85, 22, 19, 56, 233, 2};

    // Проход по каждому элементу и применение ИЛИ
    for (int i = 0; i < 10; i++)
        array[i] = array[i] | 0b01101011;

    // Вывод каждого элемента
    for (int i = 0; i < 10; i++)
        cout << (int)array[i] << " ";
    cout << endl;

    // Счетчик чисел, меньших 128
    int count = 0;
    // Проходим по каждому числу
    for (int i = 0; i < 10; i++)
        // Если оно меньше 128
        if (array[i] < 128)
            // Увеличиваем счетчик
            count++;

    // Вывод кол-во чисел, меньших 128
    cout << "Count num less 128 = " << count << endl;

    return 0;
}

