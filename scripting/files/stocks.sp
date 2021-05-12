//thanks Entity
stock int eGetRandomInt(int min = 0, int max = 2147483647) {

    int random = GetURandomInt();

    if(random == 0)
        random++;

    return RoundToCeil(float(random) / (float(2147483647) / float(max - min + 1))) + min - 1;

}