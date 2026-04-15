mod TestRandomInt16 {
    use Random2.RandomInt16

    @Test
    def testgetRandomInt16WithRandom(): Unit \ Assert = 
        let r = run {
            RandomInt16.randomInt16()
        } with RandomInt16.runWithRandom
        with handler Random2 {
            def randomByte(_n, k) = 
                k(-1i8) //just give (1,1,1,1,1,1,1,1) both times
        };
        Assert.assertEq(expected = -1i16, r) //Should give (1,1,1,1,1,1,1,1,1)x2
}