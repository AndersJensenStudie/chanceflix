pub mod TestAnimal {
    use Chance.Animal

    @Test
    pub def testAnimal01(): Unit \ Assert + IO =
        run {
            let animal = Animal.rAnimal("ocean");
            Assert.assertTrue(animal != "dog")
        } with Animal.runWithIO

    @Test
    pub def testAnimal02(): Unit \ Assert + IO =
        run {
            let animal = Animal.rAnimal("pet");
            Assert.assertTrue(animal != "whale")
        } with Animal.runWithIO
}