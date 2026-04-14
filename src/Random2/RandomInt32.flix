pub mod Random2.RandomInt32 {
    use Random2.RandomInt32

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt32) + IO =
        run {
            f()
        } with handler RandomInt32 {
            def randomInt32(k) = 
                let b = run {
                    getRandomInt32WithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt32) + Random2 =
        run {
            f()
        } with handler RandomInt32 {
            def randomInt32(k) = 
                k(getRandomInt32WithRandom())
        }

    def getRandomInt32WithRandom(): Int32 \ Random2 = 
        ???
}