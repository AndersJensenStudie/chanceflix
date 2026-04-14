eff RandomBool {
    def randomBool(): Bool
}

mod RandomBool {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomBool - Math.Random) + IO =
        run {
            f()
        } with RandomBool.runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomBool) + Math.Random =
        run {
            f()
        } with handler RandomBool {
            def randomBool(k) = 
                k(Math.Random.randomFloat64() > 0.5)
        }
}