pub mod Chance.Tld {
    use Chance.Tld

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
                k(Pickable.pick(1, pool) |> Vector.head |> Option.getWithDefault(""))
            } with Pick.runWithIO
        }

    pub def runWithPick(f: Unit -> a \ ef): a \ (ef - Tld) + Pick =
        run {
            f()
        } with handler Tld {
            def rTld(pool, k) =
                k(Pickable.pick(1, pool) |> Vector.head |> Option.getWithDefault(""))   
        }

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