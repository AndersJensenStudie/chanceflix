mod TestCreditCardNo {
    use Chance.RCreditCardType.{rCreditCardType, prefix, length}
    use Chance.CreditCardNo.creditCardNo
    @Test
    pub def creditCardNo01(): Unit \ IO = 
        let (t, n) = run {
            let tp = rCreditCardType();
            let nr = creditCardNo(tp);
            (tp, nr)
        } with Chance.CreditCardNo.runWithIO
        with Chance.RCreditCardType.runWithIO;
        println(n);
        println(t);
        println(String.length("${n}"))

    @Test
    def creditCardNo02(): Unit \ IO + Assert = 
        let (t, n) = run {
            let tp = rCreditCardType();
            let nr = creditCardNo(tp);
            (tp, nr)
        } with Chance.CreditCardNo.runWithIO
        with Chance.RCreditCardType.runWithIO;
        let validLen = length(t);
        Assert.assertTrue(Vector.memberOf(String.length("${n}"), validLen))

    pub def runMulti(): Unit \ IO + Assert = 
        List.range(0, 100) 
        |> List.forEach(_ -> creditCardNo02())

    @Test
    pub def creditCardNo03(): Unit \ IO = 
        let n = run {
            let tp = Chance.RCreditCardType.CreditCardType.VisaElectron;
            let nr = creditCardNo(tp);
            nr
        } with Chance.CreditCardNo.runWithIO
        with Chance.RCreditCardType.runWithIO;
        println(n)

    @Test
    def testIsValid(): Unit \ Chance.CreditCardNo + Chance.RCreditCardType + Assert = 
        let cc = Chance.CreditCardNo.getRandomCreditCardNo();
        Assert.assertTrue(Chance.CreditCard.isValidCreditCardNo(cc))

    @Test
    def testIsValid02(): Unit \ Chance.CreditCardNo + Chance.RCreditCardType + Assert = 
        let b = List.range(0, 500)
        |> List.map(_ -> Chance.CreditCardNo.getRandomCreditCardNo())
        |> List.map(n -> Chance.CreditCard.isValidCreditCardNo(n))
        |> List.forAll(b -> b);
        Assert.assertTrue(b)
}