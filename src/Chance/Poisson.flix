pub mod Chance.Poisson {

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Poisson) + IO =
        run {
            f()
        } with handler Poisson {
            def poisson(rate, k) = 
                run {
                    k(getPoissonWithJunhao(rate))
                } with Random2.RandomFloat64.runWithIO
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Poisson) + Random2 =
        run {
            f()
        } with handler Poisson {
            def poisson(rate, k) = 
                run {
                    k(getPoissonWithJunhao(rate))
                } with Random2.RandomFloat64.runWithRandom
        }

    pub def runWithRandomFloat64(f: Unit -> a \ ef): a \ (ef - Poisson) + Random2.RandomFloat64 =
        run {
            f()
        } with handler Poisson {
            def poisson(rate, k) = 
                k(getPoissonWithJunhao(rate))
        }

    // pub def getPoissonWithFloat64(rate: Float64): Int32 \ Random2.RandomFloat64 = 
    //     let r = Random2.RandomFloat64.randomFloat64();
    //     def cumulative(k: Int32, cdf: Float64): Int32 = {
    //         let cdf_ = (cdf * rate) / Int32.toFloat64(k);
    //         if (cdf_ > r) {
    //             k
    //         } else {
    //             cumulative(k + 1, cdf_)
    //         }
    //     };
    //     cumulative(1, Util.exp(-rate))

    // pub def getPoissonWithKnuths(rate: Float64): Int32 \ Random2.RandomFloat64 = 
    //     let l = Util.exp(-rate);
    //     def rec(k: Int32, p: Float64): Int32 \ Random2.RandomFloat64 = {
    //         let r = Random2.RandomFloat64.randomFloat64();
    //         let p_ = p * r;
    //         if (p_ > l) {
    //             rec(k + 1, p_)
    //         } else {
    //             k - 1
    //         }
    //     };
    //     rec(1, 1f64)

    def getPoissonWithJunhao(rate: Float64): Int32 \ Random2.RandomFloat64 = 
        let step = 500f64;
        def rescale(rateLeft: Float64, p: Float64): (Float64, Float64) = {
            if (p < 1f64 and rateLeft > 0f64) {
                if (rateLeft > step) {
                    rescale(rateLeft - step, p * Util.exp(step))
                } else {
                    rescale(0f64, p * Util.exp(rateLeft))
                }
            } else {
                (rateLeft, p)
            }
        };
        def rec(k: Int32, rateLeft: Float64, p: Float64): Int32 \ Random2.RandomFloat64 = {
            let k_ = k + 1;
            let u = Random2.RandomFloat64.randomFloat64();
            let (rateLeft_, p_) = rescale(rateLeft, p * u);
            if (p_ > 1f64) {
                rec(k_, rateLeft_, p_)
            } else {
                k
            }
        };
        rec(0, rate, 1f64)


} 