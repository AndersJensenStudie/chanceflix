pub mod Chance.Ipv6 {
    use Chance.Ipv6.rIpv6
    use Chance.Ipv6
    use Net.Ipv6Addr

    @DefaultHandler
    pub def runWithIO(f: Unit -> b \ ef): b \ (ef - Ipv6) + IO =
        run {
            f()
        } with handler Ipv6 {
            def rIpv6(s, k) = 
                let r = run {
                    genIpv6Addr(s)
                } with Random2.RandomInt32.runWithIO;
                k(r)
        }

    pub def runWithRandom(f: Unit -> b \ ef): b \ (ef - Ipv6) + Random2 =
        run {
            f()
        } with handler Ipv6 {
            def rIpv6(s, k) = 
                let r = run {
                    genIpv6Addr(s)
                } with Random2.RandomInt32.runWithRandom;
                k(r)
        }

    pub def runWithRandomInt32(f: Unit -> b \ ef): b \ (ef - Ipv6) + Random2.RandomInt32 =
        run {
            f()
        } with handler Ipv6 {
            def rIpv6(s, k) = 
                k(genIpv6Addr(s))
        }

    pub def getIpv6Addr(): Ipv6Addr \ Chance.Ipv6 =
        Option.getWithDefault(unreachable!(), Chance.Ipv6.rIpv6(""))
        
        

    def genIpv6Addr(s: String): Option[Ipv6Addr] \ Random2.RandomInt32 = 
        let randomized_s = run {
            evaluateString(s)
        } with Chance.RString.runWithRandomInt32 
        with Chance.RChar.runWithRandomInt32;
        match randomized_s {
            case Some(str) => Ipv6Addr.fromString(str)
            case None => None
        }
        
    def evaluateString(s: String): Option[String] \ Chance.RString + Chance.RChar = 
        let colonIndices = String.indicesOf({ substr = ":" }, s);
        let colonIndicesLen = Vector.length(colonIndices);
        let colonChecked = 
            if (colonIndicesLen < 7) Some(s + String.repeat(7 - colonIndicesLen, ":"))
            else if (colonIndicesLen > 7) None //too many colons goes oh noes
            else Some(s);
        //append missing colons, insert random values
        let validS = match colonChecked { 
            case Some(str) => 
                let temp = str
                    |> String.splitOn({ substr = ":" })
                    |> List.map(elem -> if (elem == "") Chance.RString.rString({ min = 4 }, { max = 5 }, Chance.Pool.lowerHexPool()) else elem)
                    |> String.intercalate(":")
                    |> String.map(c -> if (c == 'r') Chance.RChar.rChar(Chance.Pool.lowerHexPool()) else c);
                Some(temp)
            case None => None
        };
        validS
}