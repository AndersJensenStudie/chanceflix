pub mod TestGuid {
    use Chance.Guid
    @Test
    pub def testGuid(): Unit \ Assert + IO =
        run {
            let guid = Guid.guid();
            Assert.assertTrue(String.length(guid) == 36);
            Assert.assertTrue(String.charAt(8, guid) == '-');
            Assert.assertTrue(String.charAt(13, guid) == '-');
            Assert.assertTrue(String.charAt(18, guid) == '-');
            Assert.assertTrue(String.charAt(23, guid) == '-')
        } with Guid.runWithIO
}