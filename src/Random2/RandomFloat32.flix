pub mod Random2.RandomFloat32 {
    use Random2.RandomFloat32

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomFloat32) + IO =
        run {
            f()
        } with handler RandomFloat32 {
            def randomFloat32(k) = 
                let b = run {
                    getRandomFloat32WithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomFloat32) + Random2 =
        run {
            f()
        } with handler RandomFloat32 {
            def randomFloat32(k) = 
                k(getRandomFloat32WithRandom())
        }

    def getRandomFloat32WithRandom(): Float32 \ Random2 = 
        ???
}