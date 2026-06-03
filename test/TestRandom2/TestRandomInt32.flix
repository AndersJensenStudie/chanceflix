mod TestRandomInt32 {
    use Assert.assertTrue
    use Random2.RandomInt32
    use Random2.RandomInt32.{randomInt32, randRange, runWithIO, runWithRange, runWithTestRange, runWithTestRangePar}
    @Test
    def testGetRandomInt32WithRandom(): Unit \ Assert + IO =
        let r = run {
            RandomInt32.randomInt32()
        } with RandomInt32.runWithRandom
        with handler Random2 {
            def randomByte(_n, k) = 
                k(-1i8) //just give (1,1,1,1,1,1,1,1) 4 times
        };
        Assert.assertEq(expected = -1i32, r) //Should give (1,1,1,1,1,1,1,1,1)x4

    ///
    /// Fails in approx. 2 / 10E-458 of cases. 
    ///
    @Test
    def testRandomRange(): Unit \ Assert + IO = 
        let r = run {
            List.repeat(10000, 0) 
            |> List.map(_ -> randRange(0, 10))
        } with runWithIO;
        r !> (x -> assertTrue(List.memberOf(0, x)))
        |> List.filter(x -> x != 0)
        !> (x -> assertTrue(List.memberOf(1, x)))
        |> List.filter(x -> x != 1)
        !> (x -> assertTrue(List.memberOf(2, x)))
        |> List.filter(x -> x != 2)
        !> (x -> assertTrue(List.memberOf(3, x)))
        |> List.filter(x -> x != 3)
        !> (x -> assertTrue(List.memberOf(4, x)))
        |> List.filter(x -> x != 4)
        !> (x -> assertTrue(List.memberOf(5, x)))
        |> List.filter(x -> x != 5)
        !> (x -> assertTrue(List.memberOf(6, x)))
        |> List.filter(x -> x != 6)
        !> (x -> assertTrue(List.memberOf(7, x)))
        |> List.filter(x -> x != 7)
        !> (x -> assertTrue(List.memberOf(8, x)))
        |> List.filter(x -> x != 8)
        !> (x -> assertTrue(List.memberOf(9, x)))
        |> List.filter(x -> x != 9)
        |> (x -> assertTrue(List.isEmpty(x)))
        
    @Test
    def runWithRange01(): Unit \ Assert =
        let res = run {
            randomInt32()
            |> ToString.toString
        } with runWithRange(0, 10);
        Assert.assertEq(expected = List#{"0","1","2","3","4","5","6","7","8","9"}, res)

    @Test
    def runWithRange02(): Unit \ Assert = 
        let res = run {
            Chance.Dice.d6()
        } with Chance.Dice.runWithRandomInt32
        with runWithRange(1, 1000);
        let v = res |> List.foldLeft(acc -> elm -> 
            let b = (elm > 0) and (elm < 7) and acc;
            Assert.assertTrue(b);
            b
        , true);
        Assert.assertTrue(v)


    @Test
    pub def runWithRange03(): Unit \ Assert = 
        let avrg = x -> y -> (x + y) / 2;
        let res = run {
            let x = randomInt32();
            let y = randomInt32();
            avrg(x, y)
        } with runWithRange(1, 1000);
        res |> List.forEach(a -> assertTrue(a > 0 and a < 1000))

    @Test 
    pub def testProperties(): Unit \ Assert = 
        let abs = x -> Int32.abs(x) >= 0;
        let parse = x -> Int32.parse(10, "${x}") == Ok(x);
        let neg = x -> (x * -1) * -1 == x;
        run {
            randomInt32()
        } with runWithTestRange(abs, -1_000, 1_000);
        run {
            randomInt32()
        } with runWithTestRange(parse, -1_000, 1_000);
        run {
            randomInt32()
        } with runWithTestRange(neg, -1_000, 1_000)


    @Test 
    def parse01(): Unit \ Assert = 
        (run {
            randomInt32()
        } with runWithRange(-1000, 1000))
        |> List.forEach(x -> Assert.assertEq(expected = Ok(x), Int32.parse(10, "${x}")))

    @Test 
    def parse02(): Unit \ Assert = 
        let lst = run {
            randomInt32()
        } with runWithRange(-1000, 1000);
        lst |> List.forEach(x -> Assert.assertEq(expected = Ok(x), Int32.parse(10, "${x}")))

    @Test 
    pub def parse03(): Unit \ Assert = 
        let pbt = x -> Ok(x) == Int32.parse(10, "${x}");
        let b = run {
            randomInt32()
        } with runWithTestRangePar(pbt, Int32.minValue(), Int32.maxValue());
        assertTrue(b)
}