pub mod Chance.Pool {
    use Chance.RString
    pub def defaultPool(): String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()[]"
    
    pub def alphaPool(): String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

    def isAlpha(c: Char): Bool = 
        String.exists(x -> x == c, alphaPool())

    def isNumeric(c: Char): Bool = 
        String.exists(x -> x == c, "0123456789")

    // middleware helpers for RString and RChar effects
    pub def upper(str: String): String = 
        str |> String.toUpperCase |> String.toList |> List.distinct |> List.map(Char.toString) |> String.unlines
    
    pub def lower(str: String): String = 
        str |> String.toLowerCase |> String.toList |> List.distinct |> List.map(Char.toString) |> String.unlines
    
    pub def alpha(str: String): String = 
        str |> String.toList |> List.filter(c -> isAlpha(c)) |> List.map(Char.toString) |> String.unlines

    pub def numeric(str: String): String = 
        str |> String.toList |> List.filter(c -> isNumeric(c)) |> List.map(Char.toString) |> String.unlines


}