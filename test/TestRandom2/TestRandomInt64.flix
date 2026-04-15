mod TestRandomInt64 {
    use Random2.RandomInt64

    @Test
    def testgetRandomInt64WithRandom(): Unit \ Assert = 
        let r = run {
            RandomInt64.randomInt64()
        } with RandomInt64.runWithRandom
        with handler Random2 {
            def randomByte(_n, k) = 
                k(-1i8) //just give (1,1,1,1,1,1,1,1) all times
        };
        Assert.assertEq(expected = -1i64, r) //Should give (1,1,1,1,1,1,1,1,1)x8
}