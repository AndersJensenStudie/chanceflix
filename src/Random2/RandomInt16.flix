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
        let bytes = Random2.randomBytes(2);
        fromBytes(bytes)

    def fromBytes(v: Vector[Int8]): Int16 \ {} = 
        let b1 = Option.getWithDefault(0i8, Vector.head(v));
        let b2 = Option.getWithDefault(0i8, Vector.nth(1, v));
        let b2IsNeg = b2 < 0i8;
        let b2_ = if (b2IsNeg) {
            b2 |> Int8.setBit(pos = 7) |> Int8.flipBit(pos = 7) |> Int8.toInt16
        } else {
            Int8.toInt16(b2)
        };
        let b1_ = Int16.leftShift(Int8.toInt16(b1), 8);
        let res = Int16.bitwiseOr(b1_, b2_);
        if (b2IsNeg) {
            Int16.setBit(pos = 7, res)
        } else {
            res
        }

    def toBitVector(i: Int8): Vector[Bool] = 
        List.range(0, 8) 
        |> List.map(x -> Int8.getBit(pos = 7 - x, i))
        |> List.map(x -> if (x == 1) true else false)
        |> List.toVector

    pub def withBits(): Int16 \ Random2 = 
        let bytes = Random2.randomBytes(2);
        let b = Vector.flatten(Vector#{
            bytes |> Vector.head |> Option.getWithDefault(0i8) |> toBitVector,
            bytes |> Vector.nth(1) |> Option.getWithDefault(0i8) |> toBitVector
        });
        Vector.foldLeft(acc -> v -> 
            let shifted = Int16.leftShift(acc, 1);
            if (v) Int16.bitwiseOr(shifted, 1i16) else shifted
        , 0i16, b)

}