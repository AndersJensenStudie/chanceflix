pub mod Chance.Dice {
    use Chance.Dice

    pub def d4(): Int32 \ Dice = 
        Dice.roll(4)

    pub def d6(): Int32 \ Dice = 
        Dice.roll(6)

    pub def d8(): Int32 \ Dice = 
        Dice.roll(8)

    pub def d10(): Int32 \ Dice = 
        Dice.roll(10)
    
    pub def d12(): Int32 \ Dice = 
        Dice.roll(12)

    pub def d20(): Int32 \ Dice = 
        Dice.roll(20)    

    pub def d100(): Int32 \ Dice = 
        Dice.roll(100)

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Dice) + IO =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = {
                k(run {Random2.RandomInt32.randRange(1, sides + 1)} with Random2.RandomInt32.runWithIO)
            }
        }
    
    pub def runWithRandomI32(f: Unit -> a \ ef) : a \ (ef - Dice) + Random2.RandomInt32 =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = {
                k(Random2.RandomInt32.randRange(1, sides + 1))
            }
        }
}