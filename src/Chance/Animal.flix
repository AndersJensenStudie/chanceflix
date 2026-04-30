pub mod Chance.Animal {
    use Ref.get
    use Chance.Animal

    pub def animal(): String \ Animal = Animal.rAnimal("")

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Animal) + IO =
        run {
            f()
        } with handler Animal {
            def rAnimal(typ, k) = 
                k(run {getAnimal(typ)} with Random2.RandomInt32.runWithIO)
        }
    
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Animal) + Random2.RandomInt32 =
        run {
            f()
        } with handler Animal {
            def rAnimal(typ, k) = 
                k(getAnimal(typ))
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Animal) + Random2 =
        run {
            f()
        } with handler Animal {
            def rAnimal(typ, k) = 
                k(run {getAnimal(typ)} with Random2.RandomInt32.runWithRandom)
        }
    

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

    pub def types(): Set[String] = 
        Map.keysOf(animals())


    def getAnimal(typ: String): String \ Random2.RandomInt32 = 
        let animalsMap = animals();
        run{ match Map.get(typ, animalsMap) {
            case None => {
                Set.toVector(types()) |> Pickable.pick(1) |> Vector.head |> Option.getWithDefault("") |> getAnimal // try again with a random type
            }
            case Some(animals) => {
                List.toVector(animals) |> Pickable.pick(1) |> Vector.head |> Option.getWithDefault("")
            }
        }} with Pick.runWithRandomInt32
}