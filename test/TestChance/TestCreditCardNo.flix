mod TestCreditCardNo {
    use Chance.RCreditCardType.{rCreditCardType, prefix, length, runWithIO}
    use Chance.CreditCardNo.creditCardNo
    @Test
    pub def creditCardNo01(): Unit \ IO = 
        let (t, n) = run {
            let tp = rCreditCardType();
            let nr = creditCardNo(tp);
            (tp, nr)
        } with Chance.CreditCardNo.runWithIO
        with runWithIO;
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
        with runWithIO;
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
        with runWithIO;
        println(n)


    // fails on 55457151418330410, 6767781098526792491, 3461012584730810
    @Test
    pub def testIsValid(): Unit \ IO + Chance.CreditCardNo + Chance.RCreditCardType = 
        let cc = Chance.CreditCardNo.getRandomCreditCardNo();
        println(cc);
        println(Chance.CreditCard.isValidCreditCardNo(cc))
}