pub mod Random2.RandomInt16 {
    use Random2.RandomInt16

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt16) + IO =
        run {
            f()
        } with handler RandomInt16 {
            def randomInt16(k) = 
                let b = run {
                    getRandomInt16WithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt16) + Random2 + IO =
        run {
            f()
        } with handler RandomInt16 {
            def randomInt16(k) = 
                k(getRandomInt16WithRandom())
        }

    pub def getRandomInt16WithRandom(): Int16 \ Random2 = 
        let b = Vector.flatten(Vector#{
            Random2.randomByte() |> toBitVector,
            Random2.randomByte() |> toBitVector
        });
        Vector.foldLeft(acc -> v -> 
            let shifted = Int16.leftShift(acc, 1);
            if (v) Int16.bitwiseOr(shifted, 1i16) else shifted
        , 0i16, b)

    def toBitVector(i: Int8): Vector[Bool] = 
        Vector.range(0, 8) 
        |> Vector.map(x -> Int8.getBit(pos = 7 - x, i))
        |> Vector.map(x -> if (x == 1) true else false)

}