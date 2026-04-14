pub mod Random2.RandomFloat32 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomFloat32 - Math.Random) + IO =
        run {
            f()
        } with runWithRandom
        with Math.Random.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomFloat32) + Math.Random =
        run {
            f()
        } with handler RandomFloat32 {
            def randomFloat32(k) = ???
        }
}