pub mod Chance.Bernoulli {
    use Chance.Bernoulli

    ///
    /// Runs the `Bernoulli` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Bernoulli` effect using the `RandomFloat64` effect.
    ///
    pub def runWithRandomFloat64(f: Unit -> a \ ef): a \ (ef - Bernoulli) + Random2.RandomFloat64 =
        run {
            f()
        } with handler Bernoulli {
            def bernoulli(p, k) = 
                k(getBernoulli(p))
        }

    ///
    /// Runs the `Bernoulli` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Bernoulli` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Bernoulli) + Random2 =
        run {
            f()
        } with handler Bernoulli {
            def bernoulli(p, k) = 
                run {
                    k(getBernoulli(p))
                } with Random2.RandomFloat64.runWithRandom
        }

    ///
    /// Runs the `Bernoulli` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Bernoulli` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Bernoulli) + IO =
        run {
            f()
        } with handler Bernoulli {
            def bernoulli(p, k) = 
                run {
                    k(getBernoulli(p))
                } with Random2.RandomFloat64.runWithIO
        }

    def getBernoulli(p: Float64): Int32 \ Random2.RandomFloat64 = 
        let r = Random2.RandomFloat64.randomFloat64();
        if (r > p) {
            0
        } else 1

    ///
    /// Returns a Bernoulli distributed random number, with probability parameter 0.5
    ///
    pub def fairBernoulli(): Int32 \ Random2.RandomFloat64 = 
        getBernoulli(0.5)
}