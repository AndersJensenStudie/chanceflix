mod Chance {
    use Chance.Coin.CoinType

    pub eff Coin {
        def flip(p: { heads = Float32, tails = Float32, edge = Float32 }): CoinType
    }
}