pub mod TestPrime {
    @Test
    def prime01(): Unit \ Assert + Chance.Prime = 
        let p = Chance.Prime.primeRange(0, Int32.maxValue());
        Assert.assertTrue(Chance.Prime.isPrime(p))

    @Test
    def prime02(): Unit \ Assert + Chance.Prime = 
        let p = Chance.Prime.prime();
        Assert.assertTrue(Chance.Prime.isPrime(p))

    // def primetime01(): Unit \ IO + Time.Clock + Chance.Prime + IO = 
    //     let nr = 2_500;
    //     let l1 = List.range(0, nr);
    //     let t1 = Time.Clock.now();
    //     let _ = List.map(_ -> Chance.Prime.prime(0, Int32.maxValue()), l1);
    //     let t2 = Time.Clock.now();
    //     let timef = Int64.toFloat64(t2 - t1) / Int32.toFloat64(nr);
    //     println("time pr prime: ${timef} ms")

}