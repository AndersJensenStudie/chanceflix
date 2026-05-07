pub mod Chance.Pool {
    pub def defaultPool(): String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()[]"
    
    pub def alphaPool(): String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    pub def upperHexPool(): String = "1234567890ABCDEF"

    pub def lowerHexPool(): String = "1234567890abcdef"

    def isAlpha(c: Char): Bool = 
        String.exists(x -> x == c, alphaPool())

    def isNumeric(c: Char): Bool = 
        String.exists(x -> x == c, "0123456789")

    // middleware helpers for RString and RChar effects
    ///
    /// Makes all characters in `str` uppercase and removes duplicate characters
    ///
    pub def upper(str: String): String = 
        str |> String.toUpperCase |> String.toList |> List.distinct |> List.map(Char.toString) |> String.unlines
    
    ///
    /// Makes all characters in `str` lowercase and removes duplicate characters
    ///
    pub def lower(str: String): String = 
        str |> String.toLowerCase |> String.toList |> List.distinct |> List.map(Char.toString) |> String.unlines
    
    ///
    /// Removes all non-alpha characters from `str`
    ///
    pub def alpha(str: String): String = 
        str |> String.toList |> List.filter(c -> isAlpha(c)) |> List.map(Char.toString) |> String.unlines

    ///
    /// Removes all non-numeric characters from `str`
    ///
    pub def numeric(str: String): String = 
        str |> String.toList |> List.filter(c -> isNumeric(c)) |> List.map(Char.toString) |> String.unlines


}