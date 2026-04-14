pub mod Random2.RandomInt16 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt16 - Math.Random) + IO =
        run {
            f()
        } with runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt16) + Math.Random =
        run {
            f()
        } with handler RandomInt16 {
            def randomInt16(k) = ???
        }
}