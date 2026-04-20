pub mod Chance.Normal {
    use Math.Random
    use Chance.Normal
    use Chance.Normal.getNormalFloat64
    use Random2.RandomFloat64
    use Random2.RandomFloat64.randomFloat64

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Normal) + IO =
        run {
            f()
        } with handler Normal {
            def normal(mean, dev, k) = 
                run {
                    k(getNormalFloat64(mean, dev))
                } with RandomFloat64.runWithIO
        }

    pub def runWithRandomFloat64(f: Unit -> a \ ef): a \ (ef - Normal) + RandomFloat64 =
        run {
            f()
        } with handler Normal {
            def normal(mean, dev, k) = 
                k(getNormalFloat64(mean, dev))
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Normal) + Random2 =
        run {
            f()
        } with handler Normal {
            def normal(mean, dev, k) = 
                run {
                    k(getNormalFloat64(mean, dev))
                } with RandomFloat64.runWithRandom
        }

    def getNormalFloat64(mean: Float64, dev: Float64): Float64 \ RandomFloat64 = 
        let u = randomFloat64() * 2f64 - 1f64;
        let v = randomFloat64() * 2f64 - 1f64;
        let s = u * u + v * v;
        if (s >= 1f64 or s == 0f64) {
            getNormalFloat64(mean, dev)
        } else {
            let norm = u * Util.sqrt(-2f64 * Util.log(s) / s);
            dev * norm + mean
        }

    pub def standardNormal(): Float64 \ Normal = 
        Chance.Normal.normal(0f64, 1f64)

}