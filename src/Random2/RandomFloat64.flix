pub mod Random2.RandomFloat64 {
    use Random2.RandomFloat64

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomFloat64) + IO =
        run {
            f()
        } with handler RandomFloat64 {
            def randomFloat64(k) = 
                let b = run {
                    getRandomFloat64WithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomFloat64) + Random2 =
        run {
            f()
        } with handler RandomFloat64 {
            def randomFloat64(k) = 
                k(getRandomFloat64WithRandom())
        }

    def getRandomFloat64WithRandom(): Float64 \ Random2 = 
        let bpf = 53f64;
        let recip_bpf = 1f64 / Float64.pow(base = 2f64, bpf);
        let i64fromrandom = run {Random2.RandomInt64.randomInt64()} with Random2.RandomInt64.runWithRandom;
        let ibit53 = Int64.logicalRightShift(dist = 64-53, i64fromrandom); // get the top 53 bits
        let f = Int64.toFloat64(ibit53);
        f * recip_bpf

    pub def randRange(a: Float64, b: Float64): Float64 \ RandomFloat64 = 
        let r = RandomFloat64.randomFloat64();
        a + (r * (b - a))
}