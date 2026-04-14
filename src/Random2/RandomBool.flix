pub mod Random2.RandomBool {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomBool - Math.Random) + IO =
        run {
            f()
        } with runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomBool) + Math.Random =
        run {
            f()
        } with handler RandomBool {
            def randomBool(k) = 
                k(Math.Random.randomFloat64() > 0.5)
        }
}