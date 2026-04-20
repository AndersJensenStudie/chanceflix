pub mod TestAge {
    use Chance.Age.AgeType
    use Assert.assertTrue
    use Chance.Age
    @Test
    pub def testAge01(): Unit \ Assert + IO =
        run {
            def loop(i: Int32) = {
                let age = Age.age();
                assertTrue(0 <= age and age <= 105);
                if (i < 100) {loop(i + 1)} else {()}
            };
            loop(0)
        } with Age.runWithIO

    @Test
    pub def testAge02(): Unit \ Assert + IO =
        run {
            def loop(i: Int32) = {
                let age = Age.rAge(Some(AgeType.Teen));
                assertTrue(13 <= age and age <= 19);
                if (i < 100) {loop(i + 1)} else {()}
            };
            loop(0)
        } with Age.runWithIO
}