mod TestRandomInt16 {
    use Random2.RandomInt16

    @Test
    def testgetRandomInt16WithRandom(): Unit \ Assert = 
        let r = run {
            RandomInt16.randomInt16()
        } with RandomInt16.runWithRandom
        with handler Random2 {
            def randomBytes(_n, k) = 
                k(Vector#{-1i8, -1i8})
        };
        Assert.assertEq(expected = -1i16, r)
}