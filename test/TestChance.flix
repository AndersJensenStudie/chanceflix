pub mod TestChance {
    use Chance.Dice
    use Chance.Rpg

    @Test
    pub def testN(): Unit \ Assert + IO =
        run {
            let rolls = Chance.n(() -> Chance.Dice.roll(100), 105);
            Assert.assertTrue(List.length(rolls) == 105);
            List.forEach(r -> Assert.assertTrue(1 <= r and r <= 100), rolls)
        } with Dice.runWithIO
    @Test
    pub def testN2(): Unit \ IO + Assert =
        run {
            let ll = Chance.n(() -> Chance.Rpg.rpg("3d6", true), 10); 
            List.forEach(l -> Assert.assertTrue(List.length(l) == 1), ll);
            ll |> List.forEach(l -> Assert.assertSome(List.head(l)))
        } with Rpg.runWithIO
    
    @Test
    pub def testUnique(): Unit \ Assert + IO =
        run {
            let rolls = Chance.unique(() -> Chance.Dice.roll(100), 10);
            Assert.assertTrue(List.length(rolls) == 10);
            Assert.assertTrue(List.distinct(rolls) == rolls)
        } with Dice.runWithIO
    
}