pub mod Random2.RandomInt64 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt64 - Random2) + IO =
        run {
            f()
        } with runWithRandom
        with Random2.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt64) + Random2 =
        run {
            f()
        } with handler RandomInt64 {
            def randomInt64(k) = k(Random2.randomInt64())
        }
}