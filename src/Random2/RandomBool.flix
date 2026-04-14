pub mod Random2.RandomBool {
    use Random2.RandomBool

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomBool) + IO =
        run {
            f()
        } with handler RandomBool {
            def randomBool(k) = 
                let b = run {
                    getRandomBoolWithRandom()
                } with Math.Random.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomBool) + Math.Random =
        run {
            f()
        } with handler RandomBool {
            def randomBool(k) = 
                k(getRandomBoolWithRandom())
        }

    def getRandomBoolWithRandom(): Bool \ Math.Random = 
        Math.Random.randomInt64() >= 0i64
}