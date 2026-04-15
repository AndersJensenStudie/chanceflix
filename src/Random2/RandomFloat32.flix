pub mod Random2.RandomFloat32 {
    use Random2.RandomFloat32

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
        let bpf = 24f32;
        let recip_bpf = 1f32 / Float32.pow(base = 2f32, bpf);
        let i32fromrandom = run {Random2.RandomInt32.randomInt32()} with Random2.RandomInt32.runWithRandom;
        let ibit24 = Int32.logicalRightShift(dist = 32-24, i32fromrandom); // get the top 24 bits
        let f = Int32.toFloat32(ibit24);
        f * recip_bpf
}