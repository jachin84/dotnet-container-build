using NodaTime;
using NodaTime.Testing;

namespace Library2.Tests
{
    public class LibraryTwoTests
    {

        [Test]
        public void Library2_Should_Return_Library2()
        {
            var name = LibraryTwo.Name();
            Assert.That(name, Is.EqualTo("Library 2"));
        }

        [Test]
        public void Can_Calculate_Age()
        {
            var isaacNewtonsBirthday = new DateTime(1643, 1, 4);
            var clock = new FakeClock(Instant.FromUtc(2024, 12, 11, 13, 56));

            var age = LibraryTwo.HowOldAmIToday(clock, "Isaac Newton", isaacNewtonsBirthday, "Australia/Brisbane");

            Console.Write(age);

            Assert.That(age, Is.EqualTo("Isaac Newton is 381 years, 11 months, 7 days old."));
        }
    }
}