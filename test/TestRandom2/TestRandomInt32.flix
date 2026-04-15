mod TestRandomInt32 {
    use Random2.RandomInt32
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

    // @Test
    // def getWithRandom01(): Unit \ Assert = 
    //     let r = run {
    //         RandomInt32.randomInt32()
    //     } with RandomInt32.runWithRandom
    //     with handler Random2 {
    //         def randomInt64(k) = 
    //             k(Int64.maxValue())
    //     };
    //     Assert.assertEq(expected = Int32.maxValue(), r)
    // @Test
    // def getWithRandom02(): Unit \ Assert = 
    //     let r = run {
    //         RandomInt32.randomInt32()
    //     } with RandomInt32.runWithRandom
    //     with handler Random2 {
    //         def randomInt64(k) = 
    //             k(Int64.minValue())
    //     };
    //     Assert.assertEq(expected = Int32.minValue(), r)
    // @Test
    // def getWithRandom03(): Unit \ Assert = 
    //     let r = run {
    //         RandomInt32.randomInt32()
    //     } with RandomInt32.runWithRandom
    //     with handler Random2 {
    //         def randomInt64(k) = 
    //             k(0i64)
    //     };
    //     Assert.assertEq(expected = 0, r)
}