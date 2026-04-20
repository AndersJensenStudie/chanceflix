mod TestUtil {

    @Test
    pub def int32ToList01(): Unit \ IO = 
        println(Util.toDigits(3210))
}