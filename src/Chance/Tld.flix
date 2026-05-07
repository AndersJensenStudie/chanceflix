pub mod Chance.Tld {
    use Chance.Tld

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
                k(Pickable.pick(1, pool) |> Vector.head |> Option.getWithDefault(""))
            } with Pick.runWithIO
        }

    ///
    /// Runs the `Tld` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Tld` effect using the `Pick` effect.
    ///
    pub def runWithPick(f: Unit -> a \ ef): a \ (ef - Tld) + Pick =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) =
                k(Pickable.pick(1, pool) |> Vector.head |> Option.getWithDefault(""))   
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
                k(Pickable.pick(1, pool) |> Vector.head |> Option.getWithDefault(""))
            } with Pick.runWithRandomInt32
            with Random2.RandomInt32.runWithRandom
        }
}