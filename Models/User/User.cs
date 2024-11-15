using System.ComponentModel.DataAnnotations;

namespace WebNotes.Models.User
{
    public class User
    {
        [Key]
        public int Id { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public DateTime DateOfCreate { get; set; }
    }
}
