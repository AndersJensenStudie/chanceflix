pub mod Chance.Animal {
    use Ref.get
    use Chance.Animal

    ///
    /// Generates a random animal.
    ///
    pub def animal(): String \ Animal = Animal.rAnimal("")

    ///
    /// Runs the `Animal` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Animal` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Animal) + IO =
        run {
            f()
        } with handler Animal {
            def rAnimal(typ, k) = 
                k(run {getAnimal(typ)} with Random2.RandomInt32.runWithIO)
        }
    
    ///
    /// Runs the `Animal` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Animal` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Animal) + Random2.RandomInt32 =
        run {
            f()
        } with handler Animal {
            def rAnimal(typ, k) = 
                k(getAnimal(typ))
        }

    ///
    /// Runs the `Animal` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Animal` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Animal) + Random2 =
        run {
            f()
        } with handler Animal {
            def rAnimal(typ, k) = 
                k(run {getAnimal(typ)} with Random2.RandomInt32.runWithRandom)
        }
    

    ///
    /// Returns a map from habitat type to a list of animals living there. 
    ///
    pub def animals(): Map[String, List[String]] = 
        Map#{
            "ocean" => List#{"fish", "shark", "dolphin", "whale", "octopus", "jellyfish", "crab", "lobster", "starfish", "seahorse"},
            "desert" => List#{"camel", "scorpion", "lizard", "snake", "meerkat", "coyote", "vulture", "armadillo", "roadrunner"},
            "grassland" => List#{"bison", "antelope", "prairie dog", "badger", "coyote", "fox", "rattlesnake", "hawk", "eagle"},
            "forest" => List#{"deer", "bear", "wolf", "fox", "squirrel", "raccoon", "owl", "woodpecker", "skunk"},
            "farm" => List#{"cow", "pig", "chicken", "sheep", "goat", "horse", "duck", "turkey", "donkey"},
            "pet" => List#{"dog", "cat", "hamster", "rabbit", "guinea pig", "parrot", "fish", "turtle", "ferret"},
            "zoo" => List#{"lion", "tiger", "elephant", "giraffe", "zebra", "monkey", "panda", "kangaroo", "penguin"}
        }

    ///
    /// Returns a set of habitat types.
    ///
    pub def types(): Set[String] = 
        Map.keysOf(animals())


    def getAnimal(typ: String): String \ Random2.RandomInt32 = 
        let animalsMap = animals();
        match Map.get(typ, animalsMap) {
            case None => {
                Set.toVector(types()) |> Random2.pickOne |> getAnimal // try again with a random type
            }
            case Some(animals) => {
                List.toVector(animals) |> Random2.pickOne
            }
        }
}