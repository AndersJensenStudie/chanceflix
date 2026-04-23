pub mod Chance.IdNumber {
    use Chance.IdNumber.Type.Cpr
    use Chance.IdNumber.Type.Ssn
    use Chance.RString
    use Chance.RString.rString
    use Chance.IdNumber

    pub enum Type with Eq, ToString {
        case Ssn, Cpr
    }

    pub def cpr(): String \ IdNumber = IdNumber.id(IdNumber.Type.Cpr, true)
    
    pub def ssn(): String \ IdNumber = IdNumber.id(IdNumber.Type.Ssn, true)

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - IdNumber) + IO =
        run {
            f()
        } with handler IdNumber {
            def id(typ, fmt, k) = k(run {getIdNumber(typ, fmt)} with Random2.RandomInt32.runWithIO)
        }

    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - IdNumber) + Random2.RandomInt32 =
        run {
            f()
        } with handler IdNumber {
            def id(typ, fmt, k) = k(getIdNumber(typ, fmt))
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - IdNumber) + Random2 =
        run {
            f()
        } with handler IdNumber {
            def id(typ, fmt, k) = k(run {getIdNumber(typ, fmt)} with Random2.RandomInt32.runWithRandom)
        }

    def getIdNumber(typ: IdNumber.Type, fmt: Bool): String \ Random2.RandomInt32 = 
        let digitPool = "012346789";
        let formatted = run {
            match typ {
                case Ssn => "${rString(min = 3, max = 3, digitPool)}-rString(min = 2, max = 2, digitPool)-rString(min = 4, max = 4, digitPool)"
                case Cpr => "${rString(min = 6, max = 6, digitPool)}-${rString(min = 4, max = 4, digitPool)}"
            }
        } with RString.runWithRandomInt32;
        if (fmt) {
            formatted
        } else {
            String.replace(src = "-", dst = "", formatted)
        }
}