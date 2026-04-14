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
                } with Math.Random.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt32) + Math.Random =
        run {
            f()
        } with handler RandomInt32 {
            def randomInt32(k) = 
                k(getRandomInt32WithRandom())
        }

    def getRandomInt32WithRandom(): Int32 \ Math.Random = 
        let rand = Math.Random.randomInt64();
        Option.getWithDefault(0, Int64.tryToInt32(Int64.rightShift(rand, 32)))
}