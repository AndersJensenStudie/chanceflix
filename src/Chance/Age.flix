pub mod Chance.Age {
    use Chance.Age
    use Random2.RandomInt32
    pub enum AgeType with Eq, Order {
        case Child,
        case Teen,
        case Adult,
        case Senior
    }

    ///
    /// Generates a random human age.
    ///
    pub def age(): Int32 \ Age = 
        rAge(None)

    ///
    /// Runs the `Age` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Age` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Age) + IO =
        run {
            f()
        } with handler Age {
            def rAge(typ, k) = 
                k(run {getAge(typ)} with RandomInt32.runWithIO)
        }

    ///
    /// Runs the `Age` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Age` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Age) + Random2.RandomInt32 = 
        run {
            f()
        } with handler Age {
            def rAge(typ, k) = 
                k(getAge(typ))
        }

    ///
    /// Runs the `Age` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Age` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Age) + Random2 = 
        run {
            f()
        } with handler Age {
            def rAge(typ, k) = 
                k(run {getAge(typ)} with RandomInt32.runWithRandom)
        }

    pub def getAge(typ: Option[AgeType]): Int32 \ RandomInt32 = 
        match typ {
            case None => RandomInt32.randRange(0, 106)
            case Some(t) => match t {
                case AgeType.Child => RandomInt32.randRange(0, 13)
                case AgeType.Teen => RandomInt32.randRange(13, 20)
                case AgeType.Adult => RandomInt32.randRange(20, 65)
                case AgeType.Senior => RandomInt32.randRange(65, 106)
            }
        }
}