pub mod Random2.RandomUnit {
    use Random2.RandomUnit

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomUnit) + IO =
        run {
            f()
        } with handler RandomUnit {
            def randomUnit(k) = 
                let b = run {
                    getRandomUnitWithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomUnit) + Random2 =
        run {
            f()
        } with handler RandomUnit {
            def randomUnit(k) = 
                k(getRandomUnitWithRandom())
        }

    def getRandomUnitWithRandom(): Unit \ Random2 = 
        let _ = Random2.randomByte();
        ()
}