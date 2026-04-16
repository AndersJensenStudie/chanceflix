pub mod Chance.RString {
    use Reducible.length
    use Chance.RString

    
    pub def string(): String \ RString = 
        rString(min = 5, max = 20, Chance.Pool.defaultPool())

    def getStr(min: Int32, max: Int32, pool: String): String \ Random2.RandomInt32 = 
        let chars = pool;
        let length = Random2.RandomInt32.randRange(min, max);
        List.repeat(length, 0)
        |> List.map(_ -> String.charAt(Random2.RandomInt32.randRange(0, String.length(chars) - 1), chars))
        |> List.foldLeft((acc, c) -> acc + Char.toString(c), "")

    // Middleware handlers for RString
    pub def withPoolFilter(filter: String -> String \ ef1, f: Unit -> a \ ef2): a \ (ef2 - RString) + RString + ef1 = 
        run {
            f()
        } with handler RString {
            def rString(min, max, pool, k) = {
                k(rString(min, max, filter(pool)))
            }
        }

    pub def withUpper(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.upper, f)
    
    pub def withLower(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.lower, f)
    
    pub def withAlpha(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.alpha, f)
    
    pub def withNumeric(f: Unit -> a \ ef): a \ (ef - RString) + RString =
        withPoolFilter(Chance.Pool.numeric, f)
    
    // Terminating handlers for RString
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
    
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - RString) + Random2.RandomInt32 = 
        run {
            f()
        } with handler RString {
            def rString(min, max, pool, k) = {
                getStr(min#min, max#max, pool) |> k
            }
        }

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