// should be merged with Math.Random
pub mod Random2 {

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
    /// An effect used to generate a random 
    ///
    pub eff RandomInt32 {
        def randomInt32(): Int32
    }

    ///
    /// An effect used to generate a random 
    ///
    pub eff RandomInt16 {
        def randomInt16(): Int16
    }


    ///
    /// An effect used to generate a random 
    ///
    pub eff RandomInt8 {
        def randomInt8(): Int8
    }


    ///
    /// An effect used to generate a random 
    ///
    pub eff RandomFloat64 {
        def randomFloat64(): Float64
    }

    ///
    /// An effect used to generate a random 
    ///
    pub eff RandomFloat32 {
        def randomFloat32(): Float32
    }

}