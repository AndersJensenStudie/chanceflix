pub mod Chance.Prime {
    use Chance.Prime

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Chance.Prime) + IO =
        run {
            f()
        } with handler Prime {
            def primeRange(a, b, k) = 
                run {
                    k(trivialAlgorithm(a, b))
                } with Random2.RandomInt32.runWithIO
        }

    def trivialAlgorithm(a: Int32, b: Int32): Int32 \ Random2.RandomInt32 = 
        let a_ = if (a < 2) { 2 } else { a };
        let r = Random2.RandomInt32.randRange(a_, b);
        if (isPrime(r)) {
            r
        } else {
            trivialAlgorithm(a, b)
        }

    pub def prime(): Int32 \ Chance.Prime = 
        Chance.Prime.primeRange(2, Int32.maxValue())

    pub def isPrime(p: Int32): Bool \ {} = 
        if (p < 2) { false } else
        let sq = p 
        |> Int32.toFloat64
        |> (x -> Float64.pow(base = x, 0.5))
        |> Float64.tryToInt32
        |> Option.getWithDefault(-1)
        |> (x -> x + 1);
        @Tailrec
        def recIsPrime(n: Int32): Bool = {
            if (n == sq) {
                true
            } else if (Int32.modulo(p, n) == 0) {
                false
            } else {
                recIsPrime(n + 1)
            }
        };
        recIsPrime(2)

    pub def isPrimeMillerRabin(p: Int32): Bool \ {} = 
        if (p < 2) { false } else 
        ???
}