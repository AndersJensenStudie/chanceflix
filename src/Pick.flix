pub eff Pick {
    def pick(i: Int32, n: Int32): Vector[Int32]
}

trait Pickable[t] {
    type Elm : Type
    pub def pick(i: Int32, col: t): t \ Pick
    pub def pickOne(col: t): Option[Pickable.Elm[t]] \ Pick
}

instance Pickable[List[e]] {
    type Elm = e
    pub def pick(i: Int32, col: List[e]): List[e] \ Pick = 
        Pick.pick(i, List.length(col)) |> Vector.toList |> List.foldLeft((acc -> (a -> (
            Option.getWithDefault(unreachable!(), List.nth(a, col)) :: acc
        ))), Nil) |> List.reverse
    pub def pickOne(col: List[e]): Option[e] \ Pick = Pickable.pick(1, col) |> List.head
}

instance Pickable[Vector[e]] {
    type Elm = e
    pub def pick(i: Int32, col: Vector[e]): Vector[e] \ Pick = 
        let idxs = Pick.pick(i, Vector.length(col));
        Vector.init((idx) -> {
            Vector.get(Vector.get(idx, idxs), col)
        }, i)
    pub def pickOne(col: Vector[e]): Option[e] \ Pick = Pickable.pick(1, col) |> Vector.head
}

instance Pickable[Chain[e]] {
    type Elm = e
    pub def pick(i: Int32, col: Chain[e]): Chain[e] \ Pick =
        Pick.pick(i, Chain.length(col)) |> Vector.toChain |> Chain.foldLeft((acc -> (a -> (
            Chain.append(Chain.get(a, col) |> Chain.singleton, acc)
        ))), Chain.empty())
    pub def pickOne(col: Chain[e]): Option[e] \ Pick = Pickable.pick(1, col) |> Chain.nth(0)
}



pub mod Pick {
    def getPick(i: Int32, n: Int32): Vector[Int32] \ Random2.RandomInt32 =
        if(n == 0) {Vector.empty()}
        else Vector.repeat(i, 0) |> Vector.map(_ -> Random2.RandomInt32.randRange(0, n))

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