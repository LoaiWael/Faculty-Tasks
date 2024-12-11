using System.Threading;
int total = 0;

Console.WriteLine("current thread: main");
calc(0, 500);
Console.WriteLine(total);
Console.WriteLine("end main thread");
total=0;
Thread th1 = new Thread(() => calc(1, 500000));
Console.WriteLine(total);
void calc(int start, int end)
{
    int temp = 0;
    for (int i = start; i <= end; i++)
    {
        temp += i;
    }
    total += temp;
}