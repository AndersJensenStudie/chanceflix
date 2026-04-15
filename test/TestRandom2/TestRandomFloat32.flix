mod TestRandomFloat32 {
    use Random2.RandomFloat32

    @Test
    pub def testGetRandomFloat32(): Unit \ Assert + IO = 
        run {
            def loop(i: Int32) = {
                let num = RandomFloat32.randomFloat32();
                Assert.assertTrue(num < 1f32 and num >= 0f32);
                if (i < 1000) {
                    loop(i + 1)
                } else {
                    ()
                }
            };
            loop(0)
        } with RandomFloat32.runWithRandom
        with Random2.runWithIO

    @Test
    pub def testGetRandomFloat32_2(): Unit \ Assert + IO = 
        region rc{
            run {
                let n = 2000;
                let buckets = Array.repeat(rc, 10, 0);
                def loop(i: Int32) = {
                    let num = RandomFloat32.randomFloat32();
                    let bucketIndex = (num * 10f32) |> Float32.truncateToInt32;
                    Array.put(Array.get(bucketIndex, buckets) + 1, bucketIndex, buckets);

                    if (i < n) {
                        loop(i + 1)
                    } else {
                        ()
                    }
                };
                loop(0);
                Assert.assertTrue(Array.forAll((count) -> (160 < count and count < 240), buckets))
            } with RandomFloat32.runWithRandom
            with Random2.runWithIO
        }
}