pub mod TestPick {
    @Test
    pub def testPickList01(): Unit \ Assert =
        let lst = List#{"hello", "world"};
        let str = run {
            Pickable.pick(1, lst)
        } with handler Pick {
            def pick(_i, _n, k) = List.append(k(Vector#{0}), k(Vector#{1}))
        };
        Assert.assertEq(expected = lst, str)
    
    @Test
    pub def testPickList02(): Unit \ Assert + IO = 
        let choices = List.range(0, 100);
        run {
            def loop(i) = {
                let choice = Pickable.pick(1, choices) |> List.head |> Option.getWithDefault(-1);
                Assert.assertTrue(List.exists(x -> choice == x, choices));
                if (i < 1000) loop(i + 1) else ()
            };
            loop(0)
        } with Pick.runWithIO

    @Test
    pub def testPickList03(): Unit \ IO = 
        let choices = List.empty();
        run {
            let _x = Pickable.pick(1, choices);
            ()
        } with Pick.runWithIO
}