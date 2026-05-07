pub mod Chance.RChar {
    use Chance.RChar

    ///
    /// Generates a random char using characters from `Chance.Pool.defaultPool()`.
    ///
    pub def char(): Char \ RChar = 
        rChar(Chance.Pool.defaultPool())


    // Middleware handlers
    
    ///
    /// Middleware that intercepts the `RChar` effect, applying the given filter function on the `pool` parameter of the `rChar` operation.
    ///
    pub def withPoolFilter(filter: String -> String \ ef1, f: Unit -> a \ ef2): a \ (ef2 - RChar) + RChar + ef1= 
        run {
            f()
        } with handler RChar {
            def rChar(pool, k) = {
                k(RChar.rChar(filter(pool)))
            }
        }
    
    ///
    /// Middleware that intercepts the `RChar` effect, making the string given to the `pool` parameter of the `rChar` operation upper case.
    ///
    pub def withUpper(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.upper, f)

    ///
    /// Middleware that intercepts the `RChar` effect, making the string given to the `pool` parameter of the `rChar` operation lower case.
    ///
    pub def withLower(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.lower, f)
    
    ///
    /// Middleware that intercepts the `RChar` effect, removing all non-alpha characters from the string given to the `pool` parameter of the `rChar` operation.
    ///
    pub def withAlpha(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.alpha, f)
    
    ///
    /// Middleware that intercepts the `RChar` effect, removing all non-numeric characters from the string given to the `pool` parameter of the `RChar` operation.
    ///
    pub def withNumeric(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.numeric, f)

    // terminating handlers for RChar

    ///
    /// Runs the `RChar` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `RChar` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RChar) + IO = 
        run {
            f()
        } with handler RChar {
            def rChar(pool, k) = {
                run {
                    pool
                    |> String.charAt(Random2.RandomInt32.randRange(0, String.length(pool) - 1))
                    |> k
                } with Random2.RandomInt32.runWithIO
            }
        }
    
    ///
    /// Runs the `RChar` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `RChar` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - RChar) + Random2.RandomInt32 = 
        run {
            f()
        } with handler RChar {
            def rChar(pool, k) = {
                pool
                |> String.charAt(Random2.RandomInt32.randRange(0, String.length(pool) - 1))
                |> k
            }
        }

    ///
    /// Runs the `RChar` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `RChar` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RChar) + Random2 = 
        run {
            f()
        } with handler RChar {
            def rChar(pool, k) = {
                run {
                    pool
                    |> String.charAt(Random2.RandomInt32.randRange(0, String.length(pool) - 1))
                    |> k
                } with Random2.RandomInt32.runWithRandom
            }
        }
}