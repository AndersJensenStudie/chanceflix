mod TestRandomInt16 {
    use TestRandomInt16.twoValues
    def toBitVector(i: Int8): Vector[Bool] = 
        List.range(0, 8) 
        |> List.map(x -> Int8.getBit(pos = 7 - x, i))
        |> List.map(x -> if (x == 1) true else false)
        |> List.toVector

    def toBitVector16(i: Int16): Vector[Bool] = 
        List.range(0, 16) 
        |> List.map(x -> Int16.getBit(pos = 15 - x, i))
        |> List.map(x -> if (x == 1) true else false)
        |> List.toVector

    def bitVectorToString(v: Vector[Bool]): String \ {} = 
        Vector.foldLeft(acc -> b -> acc + "${if (b) 1 else 0}", "", v)

    @Test
    pub def getRandomInt16WithRandom01(): Unit \ IO = 
        let r = run {
            Random2.RandomInt16.getRandomInt16WithRandom()
        } with handler Random2 {
            def randomByte(k) = 
                k(-1i8)
        };
        let expected = -1i8 |> toBitVector |> bitVectorToString |> String.repeat(2);
        println(expected);
        println(r |> toBitVector16 |> bitVectorToString)

    @Test
    pub def getRandomInt16WithRandom02(): Unit \ IO = 
        let r = run {
            Random2.RandomInt16.getRandomInt16WithRandom()
        } with handler Random2 {
            def randomByte(k) = 
                k(0i8)
        };
        let expected = 0i8 |> toBitVector |> bitVectorToString |> String.repeat(2);
        println(expected);
        println(r |> toBitVector16 |> bitVectorToString)

    pub def getRandomInt16WithRandom03(): Unit \ IO = 
        let b = Int8.maxValue();
        let r = run {
            Random2.RandomInt16.getRandomInt16WithRandom()
        } with handler Random2 {
            def randomByte(k) = 
                k(b)
        };
        let expected = b |> toBitVector |> bitVectorToString |> String.repeat(2);
        println(expected);
        println(r |> toBitVector16 |> bitVectorToString)

    pub def getRandomInt16WithRandom04(): Unit \ IO = 
        let b = Int8.maxValue() + 1i8;
        let r = run {
            Random2.RandomInt16.getRandomInt16WithRandom()
        } with handler Random2 {
            def randomByte(k) = 
                k(b)
        };
        let expected = b |> toBitVector |> bitVectorToString |> String.repeat(2);
        println(expected);
        println(r |> toBitVector16 |> bitVectorToString)

    // basically property based testing
    pub def getRandomInt16WithRandom05(): Unit \ IO + Random2.RandomInt8 + Assert = 
        region rc {
            List.repeat(Int32.maxValue(), "hello, world")
            |> List.forEach(_ -> 
                let r1 = Random2.RandomInt8.randomInt8();
                let r2 = Random2.RandomInt8.randomInt8();
                let f = twoValues(r1, r2, rc);
                let r = run {
                    Random2.RandomInt16.getRandomInt16WithRandom()
                } with handler Random2 {
                    def randomByte(k) = 
                        k(f())
                };
                let r1Expected = r1 |> toBitVector |> bitVectorToString;
                let r2Expected = r2 |> toBitVector |> bitVectorToString;
                let actual = r |> toBitVector16 |> bitVectorToString;
                Assert.assertEq(expected = r1Expected + r2Expected, actual)
            )
        }

    pub def twoValues(r1: a, r2: a, rc: Region[r]): (Unit -> a \ r) \ r with Eq[a] = 
        let ref = Ref.fresh(rc, r1);
        () ->  
            let ret = Ref.get(ref);
            if (ret == r1) {
                Ref.put(r2, ref)
            } else {
                Ref.put(r1, ref)
            };
            ret
}