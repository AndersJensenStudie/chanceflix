mod TestRandomFloat64 {
    use Random2.RandomFloat64

    @Test
    pub def testGetRandomFloat64(): Unit \ Assert + IO = 
        run {
            def loop(i: Int32) = {
                let num = RandomFloat64.randomFloat64();
                Assert.assertTrue(num < 1f64 and num >= 0f64);
                if (i < 1000) {
                    loop(i + 1)
                } else {
                    ()
                }
            };
            loop(0)
        } with RandomFloat64.runWithRandom
        with Random2.runWithIO
    @Test
    pub def testGetRandomFloat64_2(): Unit \ Assert + IO = 
        region rc{
            run {
                let n = 2000;
                let buckets = Array.repeat(rc, 10, 0);
                def loop(i: Int32) = {
                    let num = RandomFloat64.randomFloat64();
                    let bucketIndex = (num * 10f64) |> Float64.truncateToInt32;
                    Array.put(Array.get(bucketIndex, buckets) + 1, bucketIndex, buckets);

                    if (i < n) {
                        loop(i + 1)
                    } else {
                        ()
                    }
                };
                loop(0);
                Assert.assertTrue(Array.forAll((count) -> (160 < count and count < 240), buckets))
            } with RandomFloat64.runWithRandom
            with Random2.runWithIO
        }
}