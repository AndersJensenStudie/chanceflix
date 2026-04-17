pub mod Chance.Tld {
    use Chance.Tld
    use Random2.pickOne

    def standardTlds(): Vector[String] = Vector#{"com", "org", "net", "io", "gov", "edu", "co", "us", "uk", "de", "dk"}

    pub def tld(): String \ Tld =
        rTld(standardTlds())

    // Terminating handlers
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Tld) + IO =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) = run {
                k(pickOne(pool))
            } with Random2.RandomInt32.runWithIO
        }

    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Tld) + Random2.RandomInt32 =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) =
                k(pickOne(pool))
            
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Tld) + Random2 =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) = run {
                k(pickOne(pool))
            } with Random2.RandomInt32.runWithRandom
        }
}