pub mod TestCoin {
    use Chance.Coin.CoinType
    use Random2.RandomFloat32
    @Test
    pub def testCoin01(): Unit \ Assert +IO=
        let actual = run {
            Chance.Coin.flip({ heads=0.3f32, tails=0.3f32, edge=0.3f32 })
        } with Chance.Coin.runWithIO;
        Assert.assertEq({expected = CoinType.Heads}, actual)


    @Test
    pub def testCoin02(): Unit \ Assert = 
        let actual = run {
            Chance.Coin.flipCoinWithEdge()
        } with handler Chance.Coin {
            def flip(_, k) = k(CoinType.Edge)
        };
        Assert.assertEq({expected = CoinType.Edge}, actual)

    pub def testCoin03(): Unit \ IO + Assert + Abort = 
        let l = run {
            List.range(0, 10_000_000) |>
            List.map(_ -> Chance.Coin.flip({ heads=0.3f32, tails=0.3f32, edge=0.3f32 }))
        } with Chance.Coin.runWithIO;
        let l_ = List.map(a -> List.count(b -> a == b, l))(List#{CoinType.Heads, CoinType.Tails, CoinType.Edge});
        let max = Option.getOrAbort(List.maximum(l_));
        let min = Option.getOrAbort(List.minimum(l_));
        println(l_);
        Assert.assertTrue(max - min < 5_000);
        ()


}