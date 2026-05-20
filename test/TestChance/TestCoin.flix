pub mod TestCoin {
    use Chance.Coin
    use Chance.Coin.CoinFace
    use Random2.RandomFloat64

    @Test
    pub def testCoin02(): Unit \ Assert = 
        let actual = run {
            Chance.Coin.flipCoinWithEdge()
        } with handler Chance.Coin {
            def flip(_, k) = k(CoinFace.Edge)
        };
        Assert.assertEq({expected = CoinFace.Edge}, actual)

    pub def testCoin03(): Unit \ IO + Assert + Abort = 
        let l = run {
            List.range(0, 10_000_000) |>
            List.map(_ -> Chance.Coin.flip({ heads=0.3f64, tails=0.3f64, edge=0.3f64 }))
        } with Chance.Coin.runWithIO;
        let l_ = List.map(a -> List.count(b -> a == b, l))(List#{CoinFace.Heads, CoinFace.Tails, CoinFace.Edge});
        let max = Option.getOrAbort(List.maximum(l_));
        let min = Option.getOrAbort(List.minimum(l_));
        Assert.assertTrue(max - min < 5_000);
        ()

    pub def testCoin04(): Unit \ IO = 
        let _ = run {
            def loop(i: Int32) = {
                // let h = Random2.RandomFloat64.randomFloat64()*1000f64;
                let h = 0f64;
                let t = Random2.RandomFloat64.randomFloat64()*1000f64;
                let e = Random2.RandomFloat64.randomFloat64()*1000f64;
                println("h=${h}, t=${t}, e=${e}");
                let _ = Chance.Coin.flip({ heads=h, tails=t, edge=e });
                if (i < 1000) {loop(i + 1)} else {()}
            };
            loop(0)
        } with Chance.Coin.runWithIO with Random2.RandomFloat64.runWithIO;
        ()

    pub def testCoin5(): Unit \ IO =
        let _x = run {
            let x = Coin.flipCoin();
            let y = Coin.flipCoin();
            if (x==y) println("You won!") else println("You loose!")
        } with Coin.withMultipleResumption
        with Coin.runWithIO;
        ()



}