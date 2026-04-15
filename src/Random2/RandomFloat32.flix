pub mod Random2.RandomFloat32 {
    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomFloat32) + IO =
        run {
            f()
        } with handler RandomFloat32 {
            def randomFloat32(k) = 
                let b = run {
                    getRandomFloat32WithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomFloat32) + Random2 =
        run {
            f()
        } with handler RandomFloat32 {
            def randomFloat32(k) = 
                k(getRandomFloat32WithRandom())
        }

    def getRandomFloat32WithRandom(): Float32 \ Random2 = 
        let b1 = Random2.randomByte();
        let b2 = Random2.randomByte();
        let b3 = Random2.randomByte();
        let b4 = Random2.randomByte();
        if ((b1 == -1i8 or b1 == 127i8) and b2 < 0i8) {
            Float32.positiveInfinity()
        } else if ((b1 == -128i8 or b1 == 0i8) and b2 > 0i8) {
            0f32
        } else {
            let sign = b1 
            |> Int8.getBit(pos = 7) 
            |> b -> if (b == 1) -1f32 else 1f32;
            let exp = Int8.toInt32(b1)
            |> Int32.bitwiseAnd(0x7Fi32) 
            |> z -> (Int32.leftShift(z, 1) + Int8.getBit(pos = 7, b2))
            |> (y -> y - 127i32)
            |> Int32.toFloat32;
            let frac = to23BitVector(b2, b3, b4) 
            |> Vector.foldLeft(acc -> b -> acc * 2f32 + (if (b) 1f32 else 0f32), 0f32)
            |> x -> 1f32 + (x * Float32.pow(base = 2f32, -23f32));
            sign * Float32.pow(base = 2f32, exp) * frac
        }
        
    def to23BitVector(b1: Int8, b2: Int8, b3: Int8): Vector[Bool] = 
        let v1 = Vector.range(1, 8)
        |> Vector.map(p -> Int8.getBit(pos = 7 - p, b1))
        |> Vector.map(b -> b == 1);
        let v2 = Vector.range(0, 8)
        |> Vector.map(p -> Int8.getBit(pos = 7 - p, b2))
        |> Vector.map(b -> b == 1);
        let v3 = Vector.range(0, 8)
        |> Vector.map(p -> Int8.getBit(pos = 7 - p, b3))
        |> Vector.map(b -> b == 1);
        Vector.flatten(Vector#{v1, v2, v3})

}