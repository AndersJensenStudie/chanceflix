pub mod Chance {
    use Chance.unique
    use Chance.CreditCardType.CreditCardType
    use Chance.Coin.CoinType
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

    pub eff Animal {
        def rAnimal(typ: String): String
    }

    pub eff Age {
        def rAge(typ: Option[Chance.Age.AgeType]): Int32
    }

    pub eff Currency {
        def currency(): Chance.Currency.Cur
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

    ///
    /// An effect used to generate a random int in {0, 1}.
    /// Gives 1 with probability `p`.
    /// A `p` larger than 1 guarantees the result will be 1. A `p` smaller than 0 guarantees 0.
    ///
    pub eff Bernoulli {
        def bernoulli(p: Float64): Int32
    }

    pub eff Binomial {
        def binomial(n: Int32, p: Float64): Int32
    }

    pub eff Poisson {
        def poisson(rate: Float64): Int32
    }
    
    pub eff Coin {
        def flip(p: { heads = Float32, tails = Float32, edge = Float32 }): CoinType
    }

    pub eff Color {
        def rColor(): RichString.Color
    }

    pub eff Prime {
        def primeRange(a: Int32, b: Int32): Int32
    }

}