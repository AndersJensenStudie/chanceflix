pub mod Chance.Tld {
    use Chance.Tld
    use Random2.pickOne

    def standardTlds(): Vector[String] = Vector#{"com", "org", "net", "io", "gov", "edu", "co", "us", "uk", "de", "dk"}

    ///
    /// Generates a random top-level domain from a predefined list.
    ///
    pub def tld(): String \ Tld =
        rTld(standardTlds())

    // Terminating handlers

    ///
    /// Runs the `Tld` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Tld` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Tld) + IO =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) = run {
                k(pickOne(pool))
            } with Random2.RandomInt32.runWithIO
        }

    ///
    /// Runs the `Tld` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Tld` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Tld) + Random2.RandomInt32 =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) =
                k(pickOne(pool))
            
        }

    ///
    /// Runs the `Tld` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Tld` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Tld) + Random2 =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) = run {
                k(pickOne(pool))
            } with Random2.RandomInt32.runWithRandom
        }
}