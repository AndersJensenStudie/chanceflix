mod TestRandomInt32 {
    use Random2.RandomInt32
    @Test
    def getWithRandom01(): Unit \ Assert = 
        let r = run {
            RandomInt32.randomInt32()
        } with RandomInt32.runWithRandom
        with handler Random2 {
            def 
        }
}