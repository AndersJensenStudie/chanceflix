pub mod TestRChar {
    use Chance.RChar
    use Chance.Pool

    @Test
    pub def testRChar(): Unit \ Assert + IO = 
    run {
        let c = RChar.char();
        Assert.assertTrue(String.exists(x -> x == c, Pool.defaultPool()))
    } with RChar.runWithIO
}