pub mod Chance.Hash {
    use Chance.RString
    use Chance.Hash

    ///
    /// Runs the `Hash` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Hash` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Hash) + IO =
        run {
            f()
        } with handler Hash {
            def hash(length, isUpperCase, k) = 
                run {
                    k(getCustomHash(length, isUpperCase))
                } with Random2.runWithIO
        }

    ///
    /// Runs the `Hash` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Hash` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Hash) + Random2 =
        run {
            f()
        } with handler Hash {
            def hash(length, isUpperCase, k) = 
                k(getCustomHash(length, isUpperCase))
        }

    //
    // Returns a random hex hash of `length` characters
    //
    def getCustomHash(length: Int32, isUpperCase: Bool): String \ Random2 = 
        run {
            let pool = if (isUpperCase) {
                Chance.Pool.upperHexPool()
            } else {
                Chance.Pool.upperHexPool()
            };
            RString.rString(min = length, max = length + 1, pool)
        } with RString.runWithRandom

    //
    // Returns a random hex hash of length 40 (same as a git commit hash)
    //
    pub def getHash(): String \ Random2 =
        getCustomHash(40, false)

    //
    // Returns a random uppercase hash of length `length`.
    //
    pub def getUpperHash(length: Int32): String \ Random2 =
        getCustomHash(length, true)

    //
    // Returns a random lowercase hash of length `length`.
    //
    pub def getLowerHash(length: Int32): String \ Random2 =
        getCustomHash(length, false)

}