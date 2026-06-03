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

    def subsetSum(ls: List[Int32], t: Int32): List[Int32] \ Random2.RandomBool = 
        let l = ls |> List.filter(_ -> randomBool());
        if ((l |> List.sum) == t) {
            l
        } else {
            Nil
        }

    def subsetSum2(subset: List[Int32], t: Int32): List[Int32] = 
        if (List.sum(subset) == t) {
            subset
        } else {
            Nil
        }

    def priceFor(isMember: Bool, hasPromo: Bool): Int32 = 
        let price = 100;
        let membersDiscount = if (isMember) { 30 } else { 0 };
        let promoDiscount = if (hasPromo) { 80 } else { 0 };
        price - membersDiscount - promoDiscount

    @Test
    pub def testPriceFor01(): Unit \ IO = 
        let res = run {
            priceFor(randomBool(), randomBool())
        } with runWithTree;
        println(res)

    pub def testSubsetSum(): Unit \ IO = 
        let ls = List#{1,2,3};
        let target = 6;
        let tree = run {
            let subset = ls |> List.filter(_ -> randomBool());
            subsetSum2(subset, target)
        } with runWithTree;
        println(tree)

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

    // does not work in Flix 0.72. Will work in 0.73 🤞
    pub def testTree04(): Unit \ IO = 
        let tr = run {
            subsetSum(List#{1, 2}, 3)
        } with runWithTree;
        println(tr)

}