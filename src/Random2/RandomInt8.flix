pub mod Random2.RandomInt8 {
    use Random2.RandomInt8

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt8) + IO =
        run {
            f()
        } with handler RandomInt8 {
            def randomInt8(k) = 
                let b = run {
                    getRandomInt8WithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt8) + Random2 =
        run {
            f()
        } with handler RandomInt8 {
            def randomInt8(k) = 
                k(getRandomInt8WithRandom())
        }

    def getRandomInt8WithRandom(): Int8 \ Random2 = 
        Random2.randomBytes(1) |> Vector.head |> Option.getWithDefault(unreachable!())
} 