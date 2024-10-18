int[] arr = { 9, 5, 7, 8, 2, 1, 3, 4, 6, 10 };
Console.Write(bubbleSort(arr));

// bubble sort method
static int[] bubbleSort(int[] arr)
{
    var temp = 0;
    for (int i; i < arr.length; i++)
    {
        for (int j; j < (arr.length - 1); j++)
        {
            if (arr[j] > arr[j + 1])
            {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}