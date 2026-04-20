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

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt16) + Random2 =
        run {
            f()
        } with handler RandomInt16 {
            def randomInt16(k) = 
                k(getRandomInt16WithRandom())
        }

    def getRandomInt16WithRandom(): Int16 \ Random2 = 
        Random2.randomBytes(2)
        |> Vector.map(Int8.toInt16 >> Int16.bitwiseAnd(255i16))
        |> (tmp) -> Vector.zip(Vector.range(0, Vector.length(tmp)), tmp)
        |> Vector.map(match (i, b) -> Int16.leftShift(b, i * 8))
        |> Vector.foldLeft(Int16.bitwiseOr, 0i16)

    pub def randRange(a: Int16, b: Int16): Int16 \ RandomInt16 = 
        if (b <= a) {
            0i16
        } else {
            let a_ = Int16.toInt32(a);
            let k = Int16.toInt32(b) - a_;
            let m = 2i32 * (Int16.toInt32(Int16.maxValue()) + 1i32);
            let limit = m - Int32.modulo(m, k);
            def rec(): Int16 = {
                let r = Int16.toInt32(Random2.RandomInt16.randomInt16()) + (m / 2i32);
                if (r >= limit) {
                    rec()
                } else {
                    Int32.clampToInt16(min = a, max = b, (a_ + (Int32.modulo(r, k))))
                }
            };
            rec()
        }
        
}