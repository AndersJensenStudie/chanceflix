pub mod Random2.RandomInt8 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt8 - Math.Random) + IO =
        run {
            f()
        } with runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt8) + Math.Random =
        run {
            f()
        } with handler RandomInt8 {
            def randomInt8(k) = ???
        }
}