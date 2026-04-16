pub mod TestDice {
    use Chance.Dice
    @Test
    pub def testD12(): Unit \ Assert + IO =
        run {
            def loop(count: Int32) = {
                let x = Dice.d12();
                println(x);
                Assert.assertTrue(1 <= x and x <= 12);
                if (count < 10) {loop(count + 1)} else {()}
            };
            loop(0)
        } with Dice.runWithIO
}