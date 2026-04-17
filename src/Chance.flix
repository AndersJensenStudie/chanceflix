pub mod Chance {
    use Chance.unique
    use Chance.CreditCardType.CreditCardType
    // Effect definitions
    pub eff Dice {
        def roll(sides: Int32): Int32
    }
    
    pub eff Rpg {
        def rpg(str: String, sum: Bool): List[Int32]
    }
    
    pub eff Guid {
        def guid(): String
    }

    pub eff RString {
        def rString(min: {min = Int32}, max: {max = Int32}, pool: String): String
    }

    pub eff RChar {
        def rChar(pool: String): Char
    }
    
    pub eff Tld {
        def rTld(pool: Vector[String]): String
    }

    pub eff Phone {
        def rPhone(country: String, fmt: Bool, cc: Bool): String
    }

    // Utility functions for effects
    pub def n(f: Unit -> b \ ef, i: Int32): List[b] \ ef =
        if (i <= 0) {
            Nil
        } else {
            let x = f();
            x :: n(f, i - 1)
        }

    pub def unique(f: Unit -> b \ ef, i: Int32): List[b] \ ef with Eq[b] =
        if (i <= 0) {
            Nil
        } else {
            let x = f();
            let rest = unique(f, i - 1);
            if (List.exists(elem -> (x == elem), rest)) {
                unique(f, i) //try again without decrementing i
            } else {
                x :: rest
            }
        }

    ///
    /// An effect used to generate a random credit card number of type `tp`.
    ///
    /// The resulting card will be of correct length and pass Luhns Algorithm
    ///
    pub eff CreditCardNo {
        def creditCardNo(tp: CreditCardType): String
    }

    pub eff CreditCardType {
        def creditCardType(): CreditCardType
    }

    pub eff CreditCard {
        def creditCardNo(tp: CreditCardType): String
        def creditCardType(): CreditCardType
    }

    pub eff Hash {
        def hash(length: Int32, isUpperCase: Bool): String
    }

    pub eff Normal {
        def normal(mean: Float64, dev: Float64): Float64 
    }

}