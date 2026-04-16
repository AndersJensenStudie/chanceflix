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

    pub def randRange(a: Int32, b: Int32): Int32 \ RandomInt32 = 
        if (b <= a) {
            0i32
        } else {
            let a_ = Int32.toInt64(a);
            let k = Int32.toInt64(b) - a_;
            let m = 2i64 * (Int32.toInt64(Int32.maxValue()) + 1i64);
            let limit = m - Int64.modulo(m, k);
            def rec(): Int32 = {
                let r = Int32.toInt64(Random2.RandomInt32.randomInt32()) + (m / 2i64);
                if (r >= limit) {
                    rec()
                } else {
                    Int64.clampToInt32(min = a, max = b, (a_ + (Int64.modulo(r, k))))
                }
            };
            rec()
        }
}