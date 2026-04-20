pub mod TestPhone {
    use Chance.Phone
    use Assert.assertTrue
    @Test
    pub def testPhone1(): Unit \ Assert + Phone + IO = 
        let phone = Chance.Phone.phone();
        println("Generated phone number: " + phone);
        assertTrue(String.length(phone) >= 10)

    @Test
    pub def testPhone2(): Unit \ Assert + Phone + IO = 
        let phone = Chance.Phone.rPhone("DK", true, true);
        println("Generated phone number: " + phone);
        assertTrue(String.length(phone) >= 10)
}