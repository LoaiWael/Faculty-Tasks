using System.Diagnostics;
using System.Security;
using System.Threading.Channels;

namespace OS_task
{
    internal class Program
    {
        static double wallet = 500_000;
        static int numOfStores = 0;
        static double coffeeBeans = 0;
        static int days = 0;

        static object locker=new object();

        static void Main(string[] args)
        {
            Console.WriteLine("--------------------------------------------------");
            Console.WriteLine("\tCoffee shop tycoon by Loai");
            Console.WriteLine("--------------------------------------------------");
            Console.WriteLine("Buy store: S\nBuy coffee: C\nPlay: F");

            int infinit = 1;
            List<Thread> listThreads = new List<Thread>();
            while (infinit !=0) {
                Console.WriteLine("--------------------------------------------------");
                Console.WriteLine($"Wallet: {wallet.ToString("c")}\t\tOpen Stores: {numOfStores}\t\tCoffee beans: {coffeeBeans}Kg\n\n");
                char ctrl=char.Parse(Console.ReadLine());
                int newStores=0;
                switch (char.ToLower(ctrl))
                {
                    case 's':
                        newStores = openStore();
                        for (int i = 1; i <= newStores; i++)
                        {
                            listThreads.Add(new Thread(play));
                            numOfStores += 1;
                            listThreads[i-1].Name = "Store " + i;
                        }
                        break;
                    case 'c':
                        buyCoffee(); 
                        break;
                    case 'f':
                        if (coffeeBeans == 0)
                        {
                            Console.WriteLine("\nThere is no coffee! Press (C) to buy some.\n");
                            break;
                        }
                        else if (numOfStores == 0)
                        {
                            Console.WriteLine("\nThere is no store! Press (S) to buy one.\n");
                            break;
                        }
                        foreach(Thread thread in listThreads)
                        {
                            if (!thread.IsAlive)
                            {
                                thread.Start();
                            }
                        }

                        Thread.Sleep(27000);
                        Console.WriteLine($"\nDay {days} completed!");
                        days++;
                        //foreach (Thread thread in listThreads)
                        //{                             
                        //     thread.Join();
                        //}
                        break;
                }

            }

        }
        public static int openStore()
        {
            int storePrice = 200_000;

            Console.WriteLine($"\nStore = {storePrice.ToString("c")}");
            Console.Write("Enter the number of stores to open or 0 to exit:");
            int num = int.Parse(Console.ReadLine());
            if (num == 0)
            {
                return 0;
            }
            else if(storePrice*num>wallet)
            {
                Console.WriteLine("\nNo enough money!\n");
                Thread.Sleep(700);
                return 0;
                
            }
            else
            {
                Console.WriteLine("\nPruchased succesfully!");
                Console.WriteLine($"({wallet.ToString("c")}) -{(num*storePrice).ToString("c")}\n");
                wallet -=  (num*storePrice);
                Thread.Sleep(700);
                return num;
            }
        }
        public static bool buyCoffee()
        {
            double kiloOfCoffee = 10;
            
            Console.WriteLine($"\n1 kilo of coffee beans = {kiloOfCoffee.ToString("c")}");
            Console.Write("Enter the number of kilos to buy or 0 to exit:");
            double num = double.Parse(Console.ReadLine());
            if (num == 0)
            {
                return false;
            }
            else if(num*kiloOfCoffee > wallet)
            {
                Console.WriteLine("\nNo enough money!\n");
                Thread.Sleep(700);
                return false;
            }
            else
            {
                Console.WriteLine("\nPruchased succesfully!");
                Console.WriteLine($"({wallet.ToString("c")}) -{(num * kiloOfCoffee).ToString("c")}\n");
                coffeeBeans += num;
                wallet -= (num*kiloOfCoffee);
                Thread.Sleep(700);
                return true;

            }
        }
        public static void play()
        {
            double GramCoffee = 0.2;
            Random random = new Random();
            Stopwatch threadTimer = Stopwatch.StartNew();

            while (threadTimer.Elapsed.TotalSeconds < 24)
            {
                lock (locker)
                {
                    if (coffeeBeans <= 0)
                    {
                        Console.WriteLine($"\n{Thread.CurrentThread.Name}: No more coffee to sell!");
                        coffeeBeans = 0;
                        break;
                    }
                        int threadSleep = random.Next(500, 2000);
                        double gramsSold = random.Next(100,1000);
                        Thread.Sleep(threadSleep);
                        Console.WriteLine("\n"+Thread.CurrentThread.Name+$" sold: {gramsSold}g");
                        coffeeBeans = coffeeBeans - (gramsSold/1000);
                        wallet += (gramsSold * GramCoffee);
                        Console.WriteLine($"+{(gramsSold * GramCoffee).ToString("c")} (Wallet: {wallet.ToString("c")})");
                        Console.WriteLine($"-{(gramsSold / 1000)}g (Coffee: {coffeeBeans}Kg)\n");
                }
            }
            Console.WriteLine($"{Thread.CurrentThread.Name}: Day ended.");
        }
    }
}
