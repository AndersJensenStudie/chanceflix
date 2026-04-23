pub mod TestBinomial {
    @Test
    def getBinomial02(): Unit \ Chance.Binomial + Assert = 
        let n = 1000;
        let li = List.range(0, n)
        |> List.map(_ -> Chance.Binomial.binomial(10, 0.5));
        List.range(0, 11)
        |> List.map(a -> List.count(b -> a == b, li))
        |> List.maximum
        |> Option.getWithDefault(-100)
        !> (x -> Assert.assertTrue(x > n / 5))
        |> (x -> Assert.assertTrue(x < n / 3))
}