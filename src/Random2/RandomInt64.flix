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

    pub def randRange(a: Int64, b: Int64): Int64 \ RandomInt64 = 
        if (b <= a) {
            0i64
        } else {
            let a_ = Int64.toBigInt(a);
            let k = Int64.toBigInt(b) - a_ + 1ii;
            let m = 2ii * (Int64.toBigInt(Int64.maxValue()) + 1ii);
            let limit = m - BigInt.modulo(m, k);
            def rec(): Int64 = {
                let r = Int64.toBigInt(Random2.RandomInt64.randomInt64()) + (m / 2ii);
                if (r >= limit) {
                    rec()
                } else {
                    BigInt.clampToInt64(min = a, max = b, (a_ + (BigInt.modulo(r, k))))
                }
            };
            rec()
        }
}