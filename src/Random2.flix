// should be merged with Math.Random    
pub eff Random2 {
    def randomByte(): Int8
}

pub mod Random2 {
    import java.util.{Random => JRandom}
    import java.security.{SecureRandom => JSecureRandom}
    ///
    /// An effect used to generate a random boolean
    ///
    pub eff RandomBool {
        def randomBool(): Bool
    }

    ///
    /// An effect used to generate a random 64-bit integer
    ///
    pub eff RandomInt64 {
        def randomInt64(): Int64
    }

    ///
    /// An effect used to generate a random 32-bit integer
    ///
    pub eff RandomInt32 {
        def randomInt32(): Int32
    }

    ///
    /// An effect used to generate a random 16-bit integer
    ///
    pub eff RandomInt16 {
        def randomInt16(): Int16
    }


    ///
    /// An effect used to generate a random 8-bit integer
    ///
    pub eff RandomInt8 {
        def randomInt8(): Int8
    }


    ///
    /// An effect used to generate a random 64-bit float
    ///
    pub eff RandomFloat64 {
        def randomFloat64(): Float64
    }

    ///
    /// An effect used to generate a random 32-bit float
    ///
    pub eff RandomFloat32 {
        def randomFloat32(): Float32
    }

    ///
    /// An effect used to generate a random Unit-value
    ///
    pub eff RandomUnit {
        def randomUnit(): Unit
    }

    pub def randomBytes(n: Int32): Vector[Int8] \ Random2 = 
        Vector.repeat(n, 0i8)
        |> Vector.map(_ -> Random2.randomByte()) 

    ///
    /// Handles the `Random` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Random` effect using the `IO` effects.
    ///
    pub def handle(f: a -> b \ ef): a -> b \ (ef - Random2) + IO =
        x -> {
            let rnd = new JRandom(); // Reuse Random instance.
            run {
                f(x)
            } with handler Random2 {
                def randomByte(k) = 
                    let bytes = Vector#{0i8};
                    rnd.nextBytes(bytes);
                    let b = Option.getWithDefault(0i8, Vector.head(bytes));
                    k(b)
            }
        }

    ///
    /// Runs the `Random` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Random` effect using the `IO` effects.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Random2) + IO = handle(f)()

    ///
    /// Runs the `Random` effect of the given function `f` from an initial seed.
    ///
    /// In other words, re-interprets the `Random` effect using seeded deterministic randomness.
    ///
    pub def handleWithSeed(seed: Int64, f: a -> b \ ef): a -> b \ ef - Random2 =
        // Note: Given a *specific* seed, JRandom is fully deterministic (i.e. pure).
        x -> {
            let rnd = unsafe IO { new JRandom(seed) };
            run {
                f(x)
            } with handler Random2 {
                def randomByte(k) = 
                    let b = unsafe IO { 
                        let bytes = Vector#{0i8};
                        rnd.nextBytes(bytes);
                        Option.getWithDefault(0i8, Vector.head(bytes))
                    };
                    k(b)
            }
        }

    ///
    /// Runs the `Random` effect of the given function `f` from an initial seed.
    ///
    /// In other words, re-interprets the `Random` effect using seeded deterministic randomness.
    ///
    pub def runWithSeed(seed: Int64, f: Unit -> a \ ef): a \ ef - Random2 = handleWithSeed(seed, f)()


    ///
    /// Handles the `Random` effect of the given function `f` using the java `SecureRandom`-class
    ///
    /// May block while entropy is gathered for seed. 
    ///
    pub def handleWithSecureRandom(f: a -> b \ ef): a -> b \ (ef - Random2) + IO =
        x -> {
            let rnd = new JSecureRandom();
            run {
                f(x)
            } with handler Random2 {
                def randomByte(k) = 
                    let bytes = Vector#{0i8};
                    rnd.nextBytes(bytes);
                    let b = Option.getWithDefault(0i8, Vector.head(bytes));
                    k(b)
            }
        }

    ///
    /// runs the `Random` effect of the given function `f` using the java `SecureRandom`-class
    ///
    /// May block while entropy is gathered for seed. 
    ///
    pub def runWithSecureRandom(f: Unit -> a \ ef): a \ (ef - Random2) + IO = handleWithSecureRandom(f)() 
}