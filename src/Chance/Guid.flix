pub mod Chance.Guid {
    use Chance.Guid
    use Random2.RandomInt32.{randRange}
    use Random2.RandomInt32

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Guid) + IO = 
        let gp = "0123456789abcdef";
        let v = "12345";
        let va = "89ab";
        run {
            f()
        } with handler Guid {
            def guid(k) = {
                run {
                    let ver = help(v, 1);
                    let var = help(va, 1);
                    "${help(gp, 8)}-${help(gp, 4)}-${ver}${help(gp, 3)}-${var}${help(gp, 3)}-${help(gp, 12)}"
                    |> k
                } with RandomInt32.runWithIO
            }
        }

    def help(pool: String, n: Int32): String \ Random2.RandomInt32 = 
        List.repeat(n, 0)
        |> List.map(_ -> String.charAt(randRange(0, n), pool))
        |> List.foldLeft((acc, c) -> acc + Char.toString(c), "")
}