pub mod Random2.RandomInt32 {
    use Sys.Console.print
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
        Random2.randomBytes(4)
        |> Vector.map(Int8.toInt32 >> Int32.bitwiseAnd(255))
        |> (tmp) -> Vector.zip(Vector.range(0, Vector.length(tmp)), tmp) 
        |> Vector.map(match (i, b) -> Int32.leftShift(b, i * 8))
        |> Vector.foldLeft(Int32.bitwiseOr, 0)
}