pub mod Random2.RandomInt32 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt32 - Math.Random) + IO =
        run {
            f()
        } with runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt32) + Math.Random =
        run {
            f()
        } with handler RandomInt32 {
            def randomInt32(k) = ???
        }
}