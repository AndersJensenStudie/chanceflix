pub mod Chance.Coin {
    use Chance.Coin
    use Chance.Coin.CoinType

    pub enum CoinType {
        case Heads
        case Tails
        case Edge
    }

    instance ToString[CoinType] {
        pub def toString(x: CoinType): String = match x {
            case CoinType.Heads => "Heads"
            case CoinType.Tails => "Tails"
            case CoinType.Edge => "Edge"
        }
    }
    
    instance Eq[CoinType] {
        pub def eq(x: CoinType, y: CoinType): Bool = match (x, y) {
            case (CoinType.Heads, CoinType.Heads) => true
            case (CoinType.Tails, CoinType.Tails) => true
            case (CoinType.Edge, CoinType.Edge) => true
            case _ => false
        }
    }
    
    pub def flipCoin(): CoinType \ Coin = 
        flip({ heads=0.5f32, tails=0.5f32, edge=0f32 })

    pub def flipCoinWithEdge(): CoinType \ Coin =
        flip({ heads=0.45f32, tails=0.45f32, edge=0.1f32 })

    def getRandomCoinTypeIndex(v: Vector[Float32], r: Float32, i: Int32): Int32 = 
        if (i > 2) 
            bug!("unreachable") 
        else
            let r_ = r - Option.getWithDefault(0f32, Vector.nth(i, v));
            if (r_ <= 0f32) i else getRandomCoinTypeIndex(v, r_, i+1)

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Coin) + IO = 
        run {
            f()
        } with handler Coin {
            def flip(p, k) = 
                let { heads, tails, edge } = p;
                let vF = Vector#{heads, tails, edge};
                let r = run {
                    let totalP = Vector.foldLeft(p1 -> p2 -> p1 + p2, 0f32, vF);
                    let randNum = Random2.RandomFloat32.randRange(0f32, 1f32);
                    let res_i = getRandomCoinTypeIndex(vF, randNum*totalP, 0i32);
                    Option.getWithDefault(bug!("unreachable"), Vector.nth(res_i, Vector#{CoinType.Heads, CoinType.Tails, CoinType.Edge}))
                } with Random2.RandomFloat32.runWithIO;
                k(r)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Coin) + Random2 = 
        run {
            f()
        } with handler Coin {
            def flip(p, k) = 
                let { heads, tails, edge } = p;
                let vF = Vector#{heads, tails, edge};
                let r = run {
                    let totalP = Vector.foldLeft(p1 -> p2 -> p1 + p2, 0f32, vF);
                    let randNum = Random2.RandomFloat32.randRange(0f32, 1f32);
                    let res_i = getRandomCoinTypeIndex(vF, randNum*totalP, 0i32);
                    Option.getWithDefault(bug!("unreachable"), Vector.nth(res_i, Vector#{CoinType.Heads, CoinType.Tails, CoinType.Edge}))
                } with Random2.RandomFloat32.runWithRandom;
                k(r)
        }
    
    pub def runWithRandomFloat32(f: Unit -> a \ ef): a \ (ef - Coin) + Random2.RandomFloat32 = 
        run {
            f()
        } with handler Coin {
            def flip(p, k) = 
                let { heads, tails, edge } = p;
                let vF = Vector#{heads, tails, edge};
                let totalP = Vector.foldLeft(p1 -> p2 -> p1 + p2, 0f32, vF);
                let randNum = Random2.RandomFloat32.randRange(0f32, 1f32);
                let res_i = getRandomCoinTypeIndex(vF, randNum*totalP, 0i32);
                let r = Option.getWithDefault(bug!("unreachable"), Vector.nth(res_i, Vector#{CoinType.Heads, CoinType.Tails, CoinType.Edge}));
                k(r)
        }
}