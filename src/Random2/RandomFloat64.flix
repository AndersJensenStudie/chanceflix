pub mod Random2.RandomFloat64 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomFloat64 - Math.Random) + IO =
        run {
            f()
        } with runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomFloat64) + Math.Random =
        run {
            f()
        } with handler RandomFloat64 {
            def randomFloat64(k) = ???
        }
}