pub mod Chance.CreditCard {
    use Chance.CreditCardNo
    use Chance.RCreditCardType
    use Chance.CreditCard

    ///
    /// Runs the `CreditCard` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `CreditCard` effect using the `IO` effect.
    ///
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

    ///
    /// Runs the `CreditCard` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `CreditCard` effect using the `Random2` effect.
    ///
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

    ///
    /// Runs the `CreditCardNo` and `CreditCardType` effects of the given function `f`.
    ///
    /// In other words, re-interprets the `CreditCardNo` and `CreditCardType` effects using the `IO` effect.
    ///
    pub def runBothWithIO(f: Unit -> a \ ef): a \ (ef - CreditCardNo - RCreditCardType) + IO =
        run {
            f()
        } with RCreditCardType.runWithIO
        with CreditCardNo.runWithIO

}