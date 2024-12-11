namespace Library1.Tests
{
    public class LibraryOneTests
    {
       
        [Test]
        public void Library1_Should_Return_Library1()
        {
            var name = Library1.LibraryOne.Name();
            Assert.That(name, Is.EqualTo("Library 1"));
        }
    }
}