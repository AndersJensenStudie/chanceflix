mod TestRandomInt16 {
    use Random2.RandomInt16

    @Test
    def testgetRandomInt16WithRandom(): Unit \ Assert + IO = 
        let r = run {
            RandomInt16.randomInt16()
        } with RandomInt16.runWithRandom
        with handler Random2 {
            def randomBytes(_n, k) = 
                k(Vector#{Int8.maxValue(), Int8.maxValue()})
        };
        Assert.assertEq(expected = Int16.maxValue(), r)
}