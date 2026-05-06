pub mod Chance.CreditCard {
    use Chance.CreditCardNo
    use Chance.RCreditCardType
    use Chance.RCreditCardType.CreditCardType
    use Chance.CreditCard

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - CreditCard) + IO =
        run {
            f()
        } with handler CreditCard {
            def creditCardNo(tp, k) = 
                run {
                    k(CreditCardNo.creditCardNo(tp))
                } with CreditCardNo.runWithIO
            def creditCardType(k) = 
                run {
                    k(RCreditCardType.rCreditCardType())
                } with RCreditCardType.runWithIO
        } 

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - CreditCard) + Random2 =
        run {
            f()
        } with handler CreditCard {
            def creditCardNo(tp, k) = 
                run {
                    k(CreditCardNo.creditCardNo(tp))
                } with CreditCardNo.runWithRandom
            def creditCardType(k) = 
                run {
                    k(RCreditCardType.rCreditCardType())
                } with RCreditCardType.runWithRandom
        }

    pub def runBothWithIO(f: Unit -> a \ ef): a \ (ef - CreditCardNo - RCreditCardType) + IO =
        run {
            f()
        } with RCreditCardType.runWithIO
        with CreditCardNo.runWithIO

    def prefix(pre: String): Option[CreditCardType] = 
        use Vector.memberOf;
        if (memberOf(pre, Vector#{"34", "37"})) {
            Some(CreditCardType.AmericanExpress)
        } else if (memberOf(pre, Vector#{"5610", "560221", "560222", "560223", "560224", "560225"})) {
            Some(CreditCardType.BankCard)
        } else if (pre == "62") {
            Some(CreditCardType.ChinaUnionPay)
        } else if (memberOf(pre, Vector#{"30", "36", "38", "39"})) {
            Some(CreditCardType.DinersClubInternational)
        } else if (pre == "55") {
            Some(CreditCardType.DinersClubUnitedStatesAndCanada)
        } else if (memberOf(pre, Vector#{"6011", "644", "645", "646", "647", "648", "649", "65"})) {
            Some(CreditCardType.DiscoverCard)
        } else if (memberOf(pre, Vector#{"637", "638", "639"})) {
            Some(CreditCardType.InstaPayment)
        } else if (memberOf(pre, (Vector.range(3528, 3589 + 1)) |> Vector.map(i -> "${i}"))) {
            Some(CreditCardType.JCB)
        } else if (memberOf(pre, Vector#{"6706", "6771", "6709"})) {
            Some(CreditCardType.Laser)
        } else if (memberOf(pre, Vector#{"5018", "5020", "5038", "5893", "6304", "6759", "6761", "6762", "6763"})) {
            Some(CreditCardType.Maestro)
        } else if (memberOf(pre, Vector.append(Vector.range(2221, 2720 + 1), Vector.range(51, 55)) |> Vector.map(i -> "${i}"))) {
            Some(CreditCardType.Mastercard)
        } else if (memberOf(pre, Vector#{"6334", "6767"})) {
            Some(CreditCardType.Solo)
        } else if (memberOf(pre, Vector#{"4903", "4905", "4911", "4936", "564182", "633110", "6333", "6759"})) {
            Some(CreditCardType.Switch)
        } else if (memberOf(pre, Vector#{"4026", "417500", "4844", "4913", "4917"})) {
            Some(CreditCardType.VisaElectron)
        } else if (pre == "5019") {
            Some(CreditCardType.Dankort)
        } else if (pre == "4571") {
            Some(CreditCardType.VisaDankort)
        } else if ((pre == "4")) {
            Some(CreditCardType.Visa)
        } else {
            None
        }

    def isLuhns(no: String): Bool \ {} = 
        let ls = no 
        |> String.toList
        |> List.map(c -> 
            let optc = Char.digit(radix = 10, c);
            match optc {
                case Some(x) => x
                case None => -1 
            }
        );
        let len = List.length(ls);
        let head = List.take(len - 1, ls);
        match List.last(ls) {
            case None => false
            case Some(check) => 
                let sum = List.range(0, len - 1)
                    |> List.map(i -> if (Int32.modulo(i, 2) == 0) 2 else 1)
                    |> List.zip(List.reverse(head))
                    |> List.map(match (n, m) -> n * m)
                    |> List.map(Util.toDigits)
                    |> List.flatten
                    |> List.sum;
                let checkDig = Int32.modulo((10 - (Int32.modulo(sum, 10))), 10);
                checkDig == check
        }
        

    pub def isValidCreditCardNo(no: String): Bool \ {} = 
        let noLen = String.length(no);
        @Tailrec
        def rec(cut: Int32): Bool = {
            if (cut < noLen) {
                let prefString = String.dropRight(cut, no);
                let pref = prefix(prefString);
                match pref {
                    case None => 
                        rec(cut + 1)
                    case Some(x) => 
                        let ccLen = RCreditCardType.length(x);
                        if (Vector.memberOf(noLen, ccLen) and isLuhns(no)) {
                            true
                        } else {
                            rec(cut + 1)
                        }
                }
            } else {
                false
            }
        };
        rec(noLen - 6)

}