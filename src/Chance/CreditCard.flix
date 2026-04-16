pub mod Chance.CreditCard {
    use Chance.CreditCardNo
    use Chance.CreditCardType
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
                    k(CreditCardType.creditCardType())
                } with CreditCardType.runWithIO
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
                    k(CreditCardType.creditCardType())
                } with CreditCardType.runWithRandom
        }

    pub def runBothWithIO(f: Unit -> a \ ef): a \ (ef - CreditCardNo - CreditCardType) + IO =
        run {
            f()
        } with CreditCardType.runWithIO
        with CreditCardNo.runWithIO

}