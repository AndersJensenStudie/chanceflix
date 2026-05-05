pub mod Chance.RString {
    use Reducible.length
    use Chance.RString

    
    ///
    /// Generates a random string with length bwetween 5 (inclusive) and 20 (exclusive) using characters from `Chance.Pool.defaultPool()`.
    ///
    pub def string(): String \ RString = 
        rString(min = 5, max = 20, Chance.Pool.defaultPool())

    def getStr(min: Int32, max: Int32, pool: String): String \ Random2.RandomInt32 = 
        let chars = pool;
        let length = Random2.RandomInt32.randRange(min, max);
        List.repeat(length, 0)
        |> List.map(_ -> String.charAt(Random2.RandomInt32.randRange(0, String.length(chars) - 1), chars))
        |> List.foldLeft((acc, c) -> acc + Char.toString(c), "")

    // Middleware handlers for RString

    ///
    /// Middleware that intercepts the `RString` effect, applying the given filter function on the `pool` parameter of the `rString` operation.
    ///
    pub def withPoolFilter(filter: String -> String \ ef1, f: Unit -> a \ ef2): a \ (ef2 - RString) + RString + ef1 = 
        run {
            f()
        } with handler RString {
            def rString(min, max, pool, k) = {
                k(rString(min, max, filter(pool)))
            }
        }

    ///
    /// Middleware that intercepts the `RString` effect, making the string given to the `pool` parameter of the `rString` operation upper case.
    ///
    pub def withUpper(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.upper, f)
    
    ///
    /// Middleware that intercepts the `RString` effect, making the string given to the `pool` parameter of the `rString` operation lower case.
    ///
    pub def withLower(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.lower, f)
    
    ///
    /// Middleware that intercepts the `RString` effect, removing all non-alpha characters from the string given to the `pool` parameter of the `rString` operation.
    ///
    pub def withAlpha(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.alpha, f)
    
    ///
    /// Middleware that intercepts the `RString` effect, removing all non-numeric characters from the string given to the `pool` parameter of the `rString` operation.
    ///
    pub def withNumeric(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.numeric, f)
    
    // Terminating handlers for RString

    ///
    /// Runs the `RString` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `RString` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RString) + IO = 
        run {
            f()
        } with handler RString {
            def rString(min, max, pool, k) = {
                run {
                    getStr(min#min, max#max, pool) |> k
                } with Random2.RandomInt32.runWithIO
            }
        }
    
    ///
    /// Runs the `RString` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `RString` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - RString) + Random2.RandomInt32 = 
        run {
            f()
        } with handler RString {
            def rString(min, max, pool, k) = {
                getStr(min#min, max#max, pool) |> k
            }
        }

    ///
    /// Runs the `RString` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `RString` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RString) + Random2 = 
        run {
            f()
        } with handler RString {
            def rString(min, max, pool, k) = {
                run {
                    getStr(min#min, max#max, pool) |> k
                } with Random2.RandomInt32.runWithRandom
            }
        }
}