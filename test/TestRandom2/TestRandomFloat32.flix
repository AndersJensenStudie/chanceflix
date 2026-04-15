mod TestRandomFloat32 {
    @Test
    pub def test01(): Unit \ IO = 
        let b = run {
            Random2.RandomFloat32.randomFloat32()
        } with Random2.RandomFloat32.runWithRandom 
        with handler Random2 {
            def randomByte(k) = 
                k(1i8)
        };
        println(b)
}