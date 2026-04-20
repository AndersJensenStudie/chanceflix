pub mod TestRpg {
    use Chance.Rpg
    @Test
    pub def testRpg(): Unit \ Assert + IO =
        run {
            let rolls = Chance.Rpg.rpg("30d20", false);
            Assert.assertTrue(List.length(rolls) == 30);
            List.forEach(r -> Assert.assertTrue(1 <= r and r <= 20), rolls)
        } with Rpg.runWithIO
}