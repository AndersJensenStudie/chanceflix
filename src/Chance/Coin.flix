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

    def getRandomCoinTypeIndex(v: Vector[Float32], r: Float32): Int32 = 
        def loop(loop_r: Float32, loop_i: Int32): Int32 = {
            let loop_r_ = loop_r - Option.getWithDefault(0f32, Vector.nth(loop_i, v));
            if (loop_r_ <= 0f32) loop_i else loop(loop_r_, loop_i+1)
        };
        loop(r, 0)

    def handleCoinFlip(p: { heads = Float32, tails = Float32, edge = Float32 }): CoinType \ Random2.RandomFloat32 = {
        let { heads, tails, edge } = p;
        let vF = Vector#{heads, tails, edge};
        let totalP = Vector.foldLeft(p1 -> p2 -> p1 + p2, 0f32, vF);
        let randNum = Random2.RandomFloat32.randRange(0f32, 1f32);
        let res_i = getRandomCoinTypeIndex(vF, randNum*totalP);
        Option.getWithDefault(bug!("unreachable"), Vector.nth(res_i, Vector#{CoinType.Heads, CoinType.Tails, CoinType.Edge}))
    }

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Coin) + IO = 
        run {
            f()
        } with handler Coin {
            def flip(p, k) = 
                let r = run {
                    handleCoinFlip(p)
                } with Random2.RandomFloat32.runWithIO;
                k(r)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Coin) + Random2 = 
        run {
            f()
        } with handler Coin {
            def flip(p, k) = 
                let r = run {
                    handleCoinFlip(p)
                } with Random2.RandomFloat32.runWithRandom;
                k(r)
        }
    
    pub def runWithRandomFloat32(f: Unit -> a \ ef): a \ (ef - Coin) + Random2.RandomFloat32 = 
        run {
            f()
        } with handler Coin {
            def flip(p, k) = 
                k(handleCoinFlip(p))
        }
}