pub mod Random2.RandomInt64 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt64 - Math.Random) + IO =
        run {
            f()
        } with runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt64) + Math.Random =
        run {
            f()
        } with handler RandomInt64 {
            def randomInt64(k) = k(Math.Random.randomInt64())
        }
}