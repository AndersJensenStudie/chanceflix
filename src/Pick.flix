pub eff Pick {
    def pick(i: Int32, n: Int32): Vector[Int32]
}

trait Pickable[t] {
    type Aef : Eff = {}
    pub def pick(i: Int32, col: t): t \ Pick + Pickable.Aef[t]
}

instance Pickable[List[e]] {
    pub def pick(i: Int32, col: List[e]): List[e] \ Pick = 
        Pick.pick(i, List.length(col)) |> Vector.toList |> List.foldLeft((acc -> (a -> (
            Option.getWithDefault(bug!("tis"), List.nth(a, col)) :: acc
        ))), Nil) |> List.reverse
}

instance Pickable[Vector[e]] {
    pub def pick(i: Int32, col: Vector[e]): Vector[e] \ Pick = 
        let idxs = Pick.pick(i, Vector.length(col));
        Vector.init((idx) -> {
            Vector.get(Vector.get(idx, idxs), col)
        }, i)
}

instance Pickable[Chain[e]] {
    pub def pick(i: Int32, col: Chain[e]): Chain[e] \ Pick =
        Pick.pick(i, Chain.length(col)) |> Vector.toChain |> Chain.foldLeft((acc -> (a -> (
            Chain.append(Chain.get(a, col) |> Chain.singleton, acc)
        ))), Chain.empty())
}


pub mod Pick {
    def getPick(i: Int32, n: Int32): Vector[Int32] \ Random2.RandomInt32 =
        Vector.repeat(i, 0) |> Vector.map(_ -> Random2.RandomInt32.randRange(0, n))

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Pick) + IO =
        run {
            f()
        } with handler Pick {
            def pick(i, n, k) = 
                k(run {getPick(i, n)} with Random2.RandomInt32.runWithIO)
        }
    
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Pick) + Random2.RandomInt32 =
        run {
            f()
        } with handler Pick {
            def pick(i, n, k) = 
                k(getPick(i, n))
        }
}