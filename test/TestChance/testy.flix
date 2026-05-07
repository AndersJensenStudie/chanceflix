def benis(): Unit \ IO = 
    run {
        println(Chance.Normal.standardNormal())
    } with Chance.Normal.runWithIO