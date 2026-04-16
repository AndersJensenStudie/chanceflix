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
        Random2.randomByte()

    pub def randRange(a: Int8, b: Int8): Int8 \ RandomInt8 = 
        if (b <= a) {
            0i8
        } else {
            let a_ = Int8.toInt16(a);
            let k = Int8.toInt16(b) - a_;
            let m = 2i16 * (Int8.toInt16(Int8.maxValue()) + 1i16);
            let limit = m - Int16.modulo(m, k);
            def rec(): Int8 = {
                let r = Int8.toInt16(Random2.RandomInt8.randomInt8()) + (m / 2i16);
                if (r >= limit) {
                    rec()
                } else {
                    Int16.clampToInt8(min = a, max = b, (a_ + (Int16.modulo(r, k))))
                }
            };
            rec()
        }
} 