mod TestRandomInt8 {
    // @Test
    // pub def randRange01(): Unit \ Assert + Abort + IO =
    //     let l = run {
    //         List.range(0, 10_000_000) |>
    //         List.map(_ -> Random2.RandomInt8.randRange(-17i8, 1i8))
    //     } with Random2.RandomInt8.runWithIO;
    //     let l_ = List.range(-17, 1)
    //     |> List.map(a -> Int32.clampToInt8(min = -128i8, max = 127i8, a))
    //     |> List.map(a -> List.count(b -> a == b, l));
    //     let max = Option.getOrAbort(List.maximum(l_));
    //     let min = Option.getOrAbort(List.minimum(l_));
    //     Assert.assertTrue(max - min < 5_000)

    // pub def multiRands(): Unit \ IO + Assert + Abort + IO = 
    //     List.range(0, 100)
    //     !> (s -> println("Running case ${s}"))
    //     |> List.forEach(_ -> randRange01())

}