mod TestCreditCardNo {
    use Chance.CreditCardType.{creditCardType, prefix, length}
    use Chance.CreditCardNo.creditCardNo
    @Test
    pub def creditCardNo01(): Unit \ IO = 
        let (t, n) = run {
            let tp = creditCardType();
            let nr = creditCardNo(tp);
            (tp, nr)
        } with Chance.CreditCardNo.runWithIO
        with Chance.CreditCardType.runWithIO;
        println(n);
        println(t);
        println(String.length("${n}"))

    @Test
    def creditCardNo02(): Unit \ IO + Assert = 
        let (t, n) = run {
            let tp = creditCardType();
            let nr = creditCardNo(tp);
            (tp, nr)
        } with Chance.CreditCardNo.runWithIO
        with Chance.CreditCardType.runWithIO;
        let validLen = length(t);
        Assert.assertTrue(Vector.memberOf(String.length("${n}"), validLen))

    pub def runMulti(): Unit \ IO + Assert = 
        List.range(0, 100) 
        |> List.forEach(_ -> creditCardNo02())

    @Test
    pub def creditCardNo03(): Unit \ IO = 
        let n = run {
            let tp = Chance.CreditCardType.CreditCardType.VisaElectron;
            let nr = creditCardNo(tp);
            nr
        } with Chance.CreditCardNo.runWithIO
        with Chance.CreditCardType.runWithIO;
        println(n)
}