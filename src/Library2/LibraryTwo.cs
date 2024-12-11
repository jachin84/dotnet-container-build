using NodaTime;
using NodaTime.Extensions;

namespace Library2
{
    public static class LibraryTwo
    {
        public static string Name() => "Library 2";

        public static string HowOldAmIToday(IClock clock, string name, DateTime birthday, string timeZoneName)
        {
            var birthDate = LocalDate.FromDateTime(birthday);
            var zone = DateTimeZoneProviders.Tzdb[timeZoneName];
            var zoneClock = clock.InZone(zone);
            var age = Period.Between(birthDate, zoneClock.GetCurrentDate());

            return $"{name} is {age.Years} years, {age.Months} months, {age.Days} days old.";

        }
    }
}
