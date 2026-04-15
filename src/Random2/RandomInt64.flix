pub mod Random2.RandomInt64 {
    // @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt64 - Random2) + IO =
        run {
            f()
        } with runWithRandom
        with Random2.runWithIO

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt64) + Random2 =
        run {
            f()
        } with handler RandomInt64 {
            def randomInt64(k) = k(getRandomInt64WithRandom())
        }
        
    def getRandomInt64WithRandom(): Int64 \ Random2 = 
        Random2.randomBytes(8)
        |> Vector.map(Int8.toInt64 >> Int64.bitwiseAnd(255i64))
        |> (tmp) -> Vector.zip(Vector.range(0, Vector.length(tmp)), tmp)
        |> Vector.map(match (i, b) -> Int64.leftShift(b, i * 8))
        |> Vector.foldLeft(Int64.bitwiseOr, 0i64)
}