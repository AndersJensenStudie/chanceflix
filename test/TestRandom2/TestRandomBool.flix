mod TestRandomBool {
    use UnorderedFoldable.nonEmpty
    use TestRandomBool.programWithChoices
    use Random2.RandomBool.{randomBool, runWithList, runWithTree}

    def programWithChoices(): String \ Random2.RandomBool = 
        if (randomBool()) {
                if (randomBool()) {
                    "tt"
                } else {
                    "tf"
                }
            } else {
                if (randomBool()) {
                    "ft"
                } else {
                    "ff"
                }
            }

    def programWithChoices02(): String \ Random2.RandomBool = 
        if (randomBool()) {
                "t"
            } else {
                if (randomBool()) {
                    "t"
                } else {
                    "f"
                }
            }

    def subsetSumNonRec(ls: List[Int32], t: Int32): List[Int32] \ Random2.RandomBool =
        def loop(xs, acc) = match xs {
            case Nil => acc
            case y :: rest => 
                let r = if (randomBool()) loop(rest, y :: acc) else loop(rest, acc);
                r
        };
        let s = loop(ls, Nil);
        if (List.sum(s) == t) s else Nil

    def subsetSumRec(ls: List[Int32], t: Int32): List[Int32] \ Random2.RandomBool =
        def loop(xs, acc) = match xs {
            case Nil => acc
            case y :: rest => 
                if (randomBool()) loop(rest, y :: acc) else loop(rest, acc)
        };
        let s = loop(ls, Nil);
        if (List.sum(s) == t) s else Nil

    pub def testList01(): Unit \ IO = 
        let ls = run {
            programWithChoices()
        } with runWithList;
        println(ls)

    pub def testList02(): Unit \ IO = 
        let ls = run {
            subsetSumNonRec(List#{1, 2, 3, 4, 5, 6}, 11)
        } with runWithList;
        ls |> List.filter(x -> nonEmpty(x)) |> List.forEach(println)

    pub def testList03(): Unit \ IO = 
        let ls = run {
            subsetSumRec(List#{1, 2}, 3)
        } with runWithList;
        ls |> List.filter(x -> nonEmpty(x)) |> List.forEach(println)

    pub def testList04(): Unit \ IO = 
        let ls = run {
            subsetSumNonRec(List#{1, 2}, 3)
        } with runWithList;
        ls |> List.filter(x -> nonEmpty(x)) |> List.forEach(println)

    pub def testTree01(): Unit \ IO = 
        let tr = run {
            programWithChoices()
        } with runWithTree;
        println(tr)

    pub def testTree02(): Unit \ IO = 
        let tr = run {
            programWithChoices02()
        } with runWithTree;
        println(tr)

    pub def testTree03(): Unit \ IO = 
        let tr = run {
            subsetSumNonRec(List#{1, 2}, 3)
        } with runWithTree;
        println(tr)

}