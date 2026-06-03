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
    /// Middleware handler for `Dice` that simulates multiple rolls and picks the highest
    ///
    pub def withMaxOverSeveral(tries: Int32, f: Unit -> a \ ef): a \ (ef - Dice) + Dice =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = 
                def loop(i: Int32, best: Int32) = {
                    let x = Dice.roll(sides);
                    let b = Int32.max(x, best);
                    if (i < tries) loop(i + 1, b)
                    else b
                };
                k(loop(0, 0))
        }
    ///
    /// Middleware handler for `Dice` that simulates multiple rolls and picks the lowest
    ///
    pub def withMinOverSeveral(tries: Int32, f: Unit -> a \ ef): a \ (ef - Dice) + Dice =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = 
                def loop(i: Int32, best: Int32) = {
                    let x = Dice.roll(sides);
                    let b = Int32.min(x, best);
                    if (i < tries) loop(i + 1, b)
                    else b
                };
                k(loop(0, Int32.maxValue()))
        }
    
    ///
    /// Middleware handler for `Dice` that takes the average over multiple rolls
    ///
    pub def withAvg(tries: Int32, f: Unit -> a \ ef): a \ (ef - Dice) + Dice =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = 
                let total = List.repeat(tries, 0) |> List.map(_ -> Dice.roll(sides))
                |> List.foldLeft(roll -> acc -> roll + acc, 0);
                k(total/tries)
        }

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
    pub def runWithRandomInt32(f: Unit -> a \ ef) : a \ (ef - Dice) + Random2.RandomInt32 =
        run {
            f()
        } with handler Dice {
            def roll(sides, k) = {
                k(Random2.RandomInt32.randRange(1, sides + 1))
            }
        }
}