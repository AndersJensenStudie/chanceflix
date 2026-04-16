pub mod Chance.RChar {
    use Chance.RChar

    pub def char(): Char \ RChar = 
        rChar(Chance.Pool.defaultPool())


    // Middleware handlers
    pub def withPoolFilter(filter: String -> String \ ef1, f: Unit -> a \ ef2): a \ (ef2 - RChar) + RChar + ef1= 
        run {
            f()
        } with handler RChar {
            def rChar(pool, k) = {
                k(RChar.rChar(filter(pool)))
            }
        }
    
    pub def withUpper(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.upper, f)

    pub def withLower(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.lower, f)
    
    pub def withAlpha(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.alpha, f)
    
    pub def withNumeric(f: Unit -> a \ ef): a \ (ef - RChar) + RChar = 
        withPoolFilter(Chance.Pool.numeric, f)

    // terminating handlers for RChar
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