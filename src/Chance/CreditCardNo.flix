pub mod Chance.CreditCardNo {
    use Chance.RCreditCardType.{CreditCardType, length, prefix}

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Chance.CreditCardNo) + IO = 
        run {
            f()
        } with handler Chance.CreditCardNo {
            def creditCardNo(tp, k) = 
                let n = run {
                    generateCCNo(tp)
                } with Random2.RandomInt32.runWithIO;
                k(n)
        }

    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Chance.CreditCardNo) + Random2.RandomInt32 = 
        run {
            f()
        } with handler Chance.CreditCardNo {
            def creditCardNo(tp, k) = 
                let n = generateCCNo(tp);
                k(n)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Chance.CreditCardNo) + Random2 = 
        run {
            f()
        } with handler Chance.CreditCardNo {
            def creditCardNo(tp, k) = 
                let n = run {
                    generateCCNo(tp)
                } with Random2.RandomInt32.runWithRandom;
                k(n)
        }

    pub def runWithCreditCard(f: Unit -> a \ ef): a \ (ef - Chance.CreditCardNo) + Chance.CreditCard =
        run {
            f()
        } with handler Chance.CreditCardNo {
            def creditCardNo(tp, k) = 
                let t = Chance.CreditCard.creditCardNo(tp);
                k(t)
        }

    ///
    /// Generates a random credit card number.
    ///
    /// The resulting card will be of correct length and pass Luhns Algorithm.
    /// 
    pub def getRandomCreditCardNo(): String \ Chance.RCreditCardType + Chance.CreditCardNo = 
        let tp = Chance.RCreditCardType.rCreditCardType();
        creditCardNo(tp)

    ///
    /// Generates a random credit card number of type `tp` that passes Luhns Algorithm
    ///
    def generateCCNo(tp: CreditCardType): String \ Random2.RandomInt32 =
        run {
            let len = length(tp) |> Pickable.pick(1) |> Vector.head |> Option.getWithDefault(0);
            let pre = prefix(tp) |> Pickable.pick(1) |> Vector.head |> Option.getWithDefault(0);
            generateCCNoWithLuhns(len, pre)
        } with Pick.runWithRandomInt32

    ///
    /// Generate a credit card number of length `len` with prefix `pre`
    /// that passes Luhns Algorithm
    ///
    def generateCCNoWithLuhns(len: Int32, pre: Int32): String \ Random2.RandomInt32 = 
        let prel = Util.toDigits(pre);
        let toGenerate = len - List.length(prel) - 1;
        let r = List.range(0, toGenerate)
        |> List.map(_ -> Random2.RandomInt32.randRange(0, 10));
        let nrs = List.append(prel, r);
        let check = Int32.modulo(10 - Int32.modulo(luhnsSum(List.reverse(nrs)), 10), 10);
        let full = List.append(nrs, check :: Nil);
        List.join("", full)

    ///
    /// Generate the sum of the numbers in `ls`, using the rule 
    /// that the numbers are mulitplied with 1 and 2 alternating
    ///
    def luhnsSum(ls: List[Int32]): Int32 = 
        List.range(0, List.length(ls))
        |> List.map(i -> if (Int32.modulo(i, 2) == 0) 2 else 1)
        |> List.zip(ls)
        |> List.map(match (n, m) -> n * m)
        |> List.map(Util.toDigits)
        |> List.flatten
        |> List.sum
}