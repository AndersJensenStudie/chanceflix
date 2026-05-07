pub mod Chance.Dice {
    use Chance.Dice

    ///
    /// Simulates rolling a four-sided die 
    ///
    pub def d4(): Int32 \ Dice = 
        Dice.roll(4)

    ///
    /// Simulates rolling a six-sided die 
    ///
    pub def d6(): Int32 \ Dice = 
        Dice.roll(6)

    ///
    /// Simulates rolling an eight-sided die 
    ///
    pub def d8(): Int32 \ Dice = 
        Dice.roll(8)

    ///
    /// Simulates rolling a ten-sided die 
    ///
    pub def d10(): Int32 \ Dice = 
        Dice.roll(10)
    
    ///
    /// Simulates rolling a twelve-sided die 
    ///
    pub def d12(): Int32 \ Dice = 
        Dice.roll(12)

    ///
    /// Simulates rolling a twenty-sided die 
    ///
    pub def d20(): Int32 \ Dice = 
        Dice.roll(20)    

    ///
    /// Simulates rolling a hundred-sided die 
    ///
    pub def d100(): Int32 \ Dice = 
        Dice.roll(100)

    ///
    /// Runs the `Dice` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Dice` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Dice) + IO =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = {
                k(run {Random2.RandomInt32.randRange(1, sides + 1)} with Random2.RandomInt32.runWithIO)
            }
        }
    
    ///
    /// Runs the `Dice` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Dice` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomI32(f: Unit -> a \ ef) : a \ (ef - Dice) + Random2.RandomInt32 =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = {
                k(Random2.RandomInt32.randRange(1, sides + 1))
            }
        }
}