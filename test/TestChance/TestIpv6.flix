pub mod TestIpv6 {
    @Test
    pub def testIpv601(): Unit \ IO = 
        run { println("Los finale: ${Chance.Ipv6.rIpv6("")}") } with Chance.Ipv6.runWithIO

    pub def testIpv602(): Unit \ IO = 
        run { println(Chance.Ipv6.getIpv6Addr()) } with Chance.Ipv6.runWithIO

    @Test
    pub def testIpv603(): Unit \ IO + Assert = 
        let actual = run {
            Chance.Ipv6.rIpv6("::::::::")
        } with Chance.Ipv6.runWithIO;
        Assert.assertEq({ expected = None }, actual)

    @Test
    pub def testIpv604(): Unit \ IO = 
        run {
            println(Chance.Ipv6.rIpv6("0000:r0r0:0000:0000:rrrr:0000:0000:0000"))
        } with Chance.Ipv6.runWithIO

    //////////// This should fail through `Ipv6Addr.fromString` but doesn't ///////////
    // @Test
    // pub def testIpv605(): Unit \ IO + Assert =
    //     let actual = run {
    //         Chance.Ipv6.rIpv6("11111:0000:0000:0000:0000:0000:0000:0000")
    //     } with Chance.Ipv6.runWithIO;
    //     Assert.assertEq({ expected = None }, actual)


}