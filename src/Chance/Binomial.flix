pub mod Chance.Binomial {
    use Chance.Bernoulli.bernoulli
    use Chance.Binomial
    use Chance.Bernoulli

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Binomial) + IO =
        run {
            f()
        } with handler Binomial {
            def binomial(n, p, k) = 
                run {
                    k(getBinomialWithFloat64(n, p, 0))
                } with Random2.RandomFloat64.runWithIO
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Binomial) + Random2 =
        run {
            f()
        } with handler Binomial {
            def binomial(n, p, k) = 
                run {
                    k(getBinomialWithFloat64(n, p, 0))
                } with Random2.RandomFloat64.runWithRandom
        }

    pub def runWithRandomFloat64(f: Unit -> a \ ef): a \ (ef - Binomial) + Random2.RandomFloat64 =
        run {
            f()
        } with handler Binomial {
            def binomial(n, p, k) = 
                k(getBinomialWithFloat64(n, p, 0))
        }

    pub def runWithBernoulli(f: Unit -> a \ ef): a \ (ef - Binomial) + Chance.Bernoulli =
        run {
            f()
        } with handler Binomial {
            def binomial(n, p, k) = 
                k(getBinomialWithBernoulli(n, p, 0))
        }

    @Tailrec
    def getBinomialWithBernoulli(n: Int32, p: Float64, acc: Int32): Int32 \ Chance.Bernoulli = 
        if (n <= 0) {
            acc
        } else {
            getBinomialWithBernoulli(n - 1, p, bernoulli(p) + acc)
        }

    @Tailrec
    def getBinomialWithFloat64(n: Int32, p: Float64, acc: Int32): Int32 \ Random2.RandomFloat64 = 
        if (n <= 0) {
            acc
        } else {
            let r = Random2.RandomFloat64.randomFloat64();
            let b = if (r > p) { 0 } else { 1 };
            getBinomialWithFloat64(n - 1, p, b + acc)
        }
    
    @Deprecated
    pub def getBinomial(n: Int64, p: Float64): Int32 \ Random2.RandomFloat64 = 
        let r = Random2.RandomFloat64.randomFloat64();
        let nf = Int64.toFloat64(n);
        let nFac = Int64.toFloat64(Int64.factorial(n));
        let q = (1f64 - p);
        def cumulative(cdf: Float64, k: Int64): Int32 = {
            let kf = Int64.toFloat64(k);
            let kFac = Int64.factorial(k);
            let denomf = Int64.toFloat64(kFac * Int64.factorial(n - k));
            let binom = nFac / denomf;
            let pk = Float64.pow(base = p, kf) * Float64.pow(base = q, nf - kf);
            let cdf_ = binom * pk + cdf;
            if (cdf_ > r) {
                Int64.clampToInt32(min = 0, max = Int32.maxValue(), k)
            } else {
                cumulative(cdf_, k - 1i64)
            }
        };
        cumulative(0f64, n)
}