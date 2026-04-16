pub mod TestRString {
    use Chance.RString
    use Chance.Pool

    @Test
    pub def testRString(): Unit \ Assert + IO = 
    run {
        let str = RString.string();
        Assert.assertTrue(String.length(str) >= 5 and String.length(str) <= 20);
        Assert.assertTrue(String.toList(str) |> List.forAll(c -> String.exists(x -> x == c, Pool.defaultPool())))
    } with RString.runWithIO
}